#include "singletons/loggingmanager.hpp"
#include "debug/log.hpp"
#include "singletons/pathmanager.hpp"
#include "singletons/settingsmanager.hpp"

#include <QDir>
#include <QStandardPaths>

#include <unordered_map>

namespace chatterino {
namespace singletons {

LoggingManager::LoggingManager()
    : pathManager(PathManager::getInstance())
{
}

LoggingManager &LoggingManager::getInstance()
{
    static LoggingManager instance;
    return instance;
}

void LoggingManager::addMessage(const QString &channelName, messages::MessagePtr message)
{
    const auto &settings = singletons::SettingManager::getInstance();

    if (!settings.enableLogging) {
        return;
    }

    auto it = this->loggingChannels.find(channelName);
    if (it == this->loggingChannels.end()) {
        auto channel = new LoggingChannel(channelName, this->getDirectoryForChannel(channelName));
        channel->addMessage(message);
        this->loggingChannels.emplace(channelName,
                                      std::unique_ptr<LoggingChannel>(std::move(channel)));
    } else {
        it->second->addMessage(message);
    }
}

QString LoggingManager::getDirectoryForChannel(const QString &channelName)
{
    if (channelName.startsWith("/whispers")) {
        return this->pathManager.whispersLogsFolderPath;
    } else if (channelName.startsWith("/mentions")) {
        return this->pathManager.mentionsLogsFolderPath;
    } else {
        QString logPath(this->pathManager.channelsLogsFolderPath + QDir::separator() + channelName);

        if (!this->pathManager.createFolder(logPath)) {
            debug::Log("Error creating channel logs folder for channel {}", channelName);
        }

        return logPath;
    }
}

}  // namespace singletons
}  // namespace chatterino
