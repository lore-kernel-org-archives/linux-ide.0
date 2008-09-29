From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/6] Hibernation: Introduce new system state for the last phase of hibernation
Date: Tue, 30 Sep 2008 00:10:37 +0200
Message-ID: <200809300010.39000.rjw@sisk.pl>
References: <200808290002.55026.rjw@sisk.pl> <48D17BBE.5020807@garzik.org> <200809300006.24919.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200809300006.24919.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Hibernation: Introduce new system state for the last phase of hibernation

Replace unused SYSTEM_SUSPEND_DISK with a new system_state value
SYSTEM_HIBERNATE_ENTER that can be used by device drivers to check if
the system is in the last phase of hibernation.

In particular, some SATA drivers are going to use it for blacklisting
systems in which the disks should not be spun down during the last
phase of hibernation (the BIOS will do that anyway).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/kernel.h |    2 +-
 kernel/power/disk.c    |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/power/disk.c
===================================================================
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -416,6 +416,7 @@ int hibernation_platform_enter(void)
 	if (error)
 		goto Close;
 
+	system_state = SYSTEM_HIBERNATE_ENTER;
 	suspend_console();
 	ftrace_save = __ftrace_enabled_save();
 	error = device_suspend(PMSG_HIBERNATE);
@@ -451,6 +452,7 @@ int hibernation_platform_enter(void)
  Finish:
 	hibernation_ops->finish();
  Resume_devices:
+	system_state = SYSTEM_RUNNING;
 	device_resume(PMSG_RESTORE);
 	__ftrace_enabled_restore(ftrace_save);
 	resume_console();
Index: linux-2.6/include/linux/kernel.h
===================================================================
--- linux-2.6.orig/include/linux/kernel.h
+++ linux-2.6/include/linux/kernel.h
@@ -247,7 +247,7 @@ extern enum system_states {
 	SYSTEM_HALT,
 	SYSTEM_POWER_OFF,
 	SYSTEM_RESTART,
-	SYSTEM_SUSPEND_DISK,
+	SYSTEM_HIBERNATE_ENTER,
 } system_state;
 
 #define TAINT_PROPRIETARY_MODULE	(1<<0)

