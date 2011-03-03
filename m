From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/2] Documentation: document new link power management policy option
Date: Thu,  3 Mar 2011 10:21:18 -0800
Message-ID: <1299176478-2999-3-git-send-email-kristen@linux.intel.com>
References: <1299176478-2999-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32825 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758620Ab1CCSS4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Mar 2011 13:18:56 -0500
In-Reply-To: <1299176478-2999-1-git-send-email-kristen@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>

Describe new link power management option, power_off.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 .../scsi/link_power_management_policy.txt          |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/scsi/link_power_management_policy.txt b/Documentation/scsi/link_power_management_policy.txt
index d18993d..6a024e6 100644
--- a/Documentation/scsi/link_power_management_policy.txt
+++ b/Documentation/scsi/link_power_management_policy.txt
@@ -1,5 +1,5 @@
 This parameter allows the user to set the link (interface) power management.
-There are 3 possible options:
+There are 4 possible options:
 
 Value			Effect
 ----------------------------------------------------------------------------
@@ -16,4 +16,6 @@ medium_power		Tell the controller to enter a lower power state
 			when possible, but do not enter the lowest power
 			state, thus improving latency over min_power setting.
 
-
+power_off		If the port is unoccupied, the port will power
+			completely down.  For occupied ports, this option
+			is not valid.
-- 
1.7.3.1

