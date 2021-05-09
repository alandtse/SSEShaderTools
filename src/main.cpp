#include "skse64_common/skse_version.h"

#include "SKSE/API.h"

#include "version.h" 
#include "hooks.h"
#include "skse64_common/BranchTrampoline.h"


extern "C" {
	bool SKSEPlugin_Query(const SKSE::QueryInterface* a_skse, SKSE::PluginInfo* a_info)
	{
		SKSE::Logger::OpenRelative(FOLDERID_Documents, L"\\My Games\\Skyrim Special Edition\\SKSE\\ShaderTools.log");
		SKSE::Logger::SetPrintLevel(SKSE::Logger::Level::kDebugMessage);
		SKSE::Logger::SetFlushLevel(SKSE::Logger::Level::kDebugMessage);
		SKSE::Logger::UseLogStamp(true);

		_MESSAGE("ShaderTools v%s", SHDT_VERSION_VERSTRING);

		a_info->infoVersion = SKSE::PluginInfo::kVersion;
		a_info->name = "MyFirstPlugin";
		a_info->version = SHDT_VERSION_MAJOR;

		if (a_skse->IsEditor()) {
			_FATALERROR("Loaded in editor, marking as incompatible!\n");
			return false;
		}

		return true;
	}


	bool SKSEPlugin_Load(const SKSE::LoadInterface* a_skse)
	{
		_MESSAGE("ShaderTools loaded");

		if (!SKSE::Init(a_skse)) {
			return false;
		}

		if (!g_localTrampoline.Create(1024 * 1)) {
			_FATALERROR("Failed to create local trampoline!\n");
			return false;
		}

		if (!g_branchTrampoline.Create(1024 * 1)) {
			_FATALERROR("Failed to create branch trampoline!\n");
			return false;
		}
		
		InstallBSShaderHooks();

		return true;
	}
};
