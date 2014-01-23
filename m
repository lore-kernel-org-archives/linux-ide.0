From: Mohit Kumar <mohit.kumar@st.com>
Subject: [PATCH V2 3/8] ahci: Add a driver_data field to struct ahci_platform_data
Date: Thu, 23 Jan 2014 16:02:43 +0530
Message-ID: <af75111fb61aebfee6e0233b39dc4cf006906402.1390471111.git.mohit.kumar@st.com>
References: <cover.1390471111.git.mohit.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:47705 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753495AbaAWKd4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jan 2014 05:33:56 -0500
In-Reply-To: <cover.1390471111.git.mohit.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Pratyush Anand <pratyush.anand@st.com>, Viresh Kumar <viresh.linux@gmail.com>, spear-devel@list.st.com, linux-arm-kernel@lists.infradead.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

From: Pratyush Anand <pratyush.anand@st.com>

Platform functions passed to the driver may also need some private
data. Till, now following approaches have been taken to manage these
data:
-- SPEAr13xx platform keep it locally in the files defining platform
functions.
-- IMX has created a new ahci platform device as a child of
platform device created by DT and then attached this data as the
driver_data of ahci's dev->parent.

Adding a driver_data field helps in using the same platform driver as
that of created by DT.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Tested-by: Mohit Kumar <mohit.kumar@st.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel@list.st.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/ahci_platform.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 73a2500..76d35e8 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -28,6 +28,7 @@ struct ahci_platform_data {
 	const struct ata_port_info *ata_port_info;
 	unsigned int force_port_map;
 	unsigned int mask_port_map;
+	void *driver_data;
 };
 
 #endif /* _AHCI_PLATFORM_H */
-- 
1.7.0.1

