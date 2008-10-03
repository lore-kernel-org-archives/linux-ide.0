From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/6] Hibernation: Introduce system_entering_hibernation
Date: Fri, 3 Oct 2008 23:51:45 +0200
Message-ID: <200810032351.46869.rjw@sisk.pl>
References: <200808290002.55026.rjw@sisk.pl> <200810031703.32114.rjw@sisk.pl> <200810032348.59709.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41541 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753500AbYJCVzX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Oct 2008 17:55:23 -0400
In-Reply-To: <200810032348.59709.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Hibernation: Introduce system_entering_hibernation

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
---
 include/linux/suspend.h |    2 ++
 kernel/power/disk.c     |    9 +++++++++
 2 files changed, 11 insertions(+)

Index: linux-2.6/include/linux/suspend.h
===================================================================
--- linux-2.6.orig/include/linux/suspend.h
+++ linux-2.6/include/linux/suspend.h
@@ -232,6 +232,7 @@ extern unsigned long get_safe_page(gfp_t
 
 extern void hibernation_set_ops(struct platform_hibernation_ops *ops);
 extern int hibernate(void);
+extern bool system_entering_hibernation(void);
 #else /* CONFIG_HIBERNATION */
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
 static inline void swsusp_set_page_free(struct page *p) {}
@@ -239,6 +240,7 @@ static inline void swsusp_unset_page_fre
 
 static inline void hibernation_set_ops(struct platform_hibernation_ops *ops) {}
 static inline int hibernate(void) { return -ENOSYS; }
+static inline bool system_entering_hibernation(void) { return false; }
 #endif /* CONFIG_HIBERNATION */
 
 #ifdef CONFIG_PM_SLEEP
Index: linux-2.6/kernel/power/disk.c
===================================================================
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -72,6 +72,13 @@ void hibernation_set_ops(struct platform
 	mutex_unlock(&pm_mutex);
 }
 
+static bool entering_platform_hibernation;
+
+bool system_entering_hibernation(void)
+{
+	return entering_platform_hibernation;
+}
+
 #ifdef CONFIG_PM_DEBUG
 static void hibernation_debug_sleep(void)
 {
@@ -416,6 +423,7 @@ int hibernation_platform_enter(void)
 	if (error)
 		goto Close;
 
+	entering_platform_hibernation = true;
 	suspend_console();
 	ftrace_save = __ftrace_enabled_save();
 	error = device_suspend(PMSG_HIBERNATE);
@@ -451,6 +459,7 @@ int hibernation_platform_enter(void)
  Finish:
 	hibernation_ops->finish();
  Resume_devices:
+	entering_platform_hibernation = false;
 	device_resume(PMSG_RESTORE);
 	__ftrace_enabled_restore(ftrace_save);
 	resume_console();

