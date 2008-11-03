From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/8] Hibernation: Introduce system_entering_hibernation
Date: Mon,  3 Nov 2008 19:01:02 +0900
Message-ID: <1225706469-27870-2-git-send-email-tj@kernel.org>
References: <1225706469-27870-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60506 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754746AbYKCKBc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Nov 2008 05:01:32 -0500
In-Reply-To: <1225706469-27870-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Tejun Heo <tj@kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce boolean function system_entering_hibernation() returning
'true' during the last phase of hibernation, in which devices are
being put into low power states and the sleep state (for example,
ACPI S4) is finally entered.

Some device drivers need such a function to check if the system is
in the final phase of hibernation.  In particular, some SATA drivers
are going to use it for blacklisting systems in which the disks
should not be spun down during the last phase of hibernation (the
BIOS will do that anyway).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/suspend.h |    2 ++
 kernel/power/disk.c     |   10 ++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 2ce8207..195200b 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -232,6 +232,7 @@ extern unsigned long get_safe_page(gfp_t gfp_mask);
 
 extern void hibernation_set_ops(struct platform_hibernation_ops *ops);
 extern int hibernate(void);
+extern bool system_entering_hibernation(void);
 #else /* CONFIG_HIBERNATION */
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
 static inline void swsusp_set_page_free(struct page *p) {}
@@ -239,6 +240,7 @@ static inline void swsusp_unset_page_free(struct page *p) {}
 
 static inline void hibernation_set_ops(struct platform_hibernation_ops *ops) {}
 static inline int hibernate(void) { return -ENOSYS; }
+static inline bool system_entering_hibernation(void) { return false; }
 #endif /* CONFIG_HIBERNATION */
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index c9d7408..248e243 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -72,6 +72,14 @@ void hibernation_set_ops(struct platform_hibernation_ops *ops)
 	mutex_unlock(&pm_mutex);
 }
 
+static bool entering_platform_hibernation;
+
+bool system_entering_hibernation(void)
+{
+	return entering_platform_hibernation;
+}
+EXPORT_SYMBOL_GPL(system_entering_hibernation);
+
 #ifdef CONFIG_PM_DEBUG
 static void hibernation_debug_sleep(void)
 {
@@ -416,6 +424,7 @@ int hibernation_platform_enter(void)
 	if (error)
 		goto Close;
 
+	entering_platform_hibernation = true;
 	suspend_console();
 	ftrace_save = __ftrace_enabled_save();
 	error = device_suspend(PMSG_HIBERNATE);
@@ -451,6 +460,7 @@ int hibernation_platform_enter(void)
  Finish:
 	hibernation_ops->finish();
  Resume_devices:
+	entering_platform_hibernation = false;
 	device_resume(PMSG_RESTORE);
 	__ftrace_enabled_restore(ftrace_save);
 	resume_console();
-- 
1.5.4.5

