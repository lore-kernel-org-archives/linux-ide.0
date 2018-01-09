From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/3] ata: Allow having a port recovery callback
Date: Tue,  9 Jan 2018 15:04:55 -0800
Message-ID: <1515539097-26742-2-git-send-email-f.fainelli@gmail.com>
References: <1515539097-26742-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515539097-26742-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcm-kernel-feedback-list@broadcom.com
Cc: Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Srinath Mannam <srinath.mannam@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Dan Carpenter <dan.carpenter@oracle.com>, "open list:LIBATA SUBSYSTEM Serial and
        Parallel ATA drivers" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Some AHCI controllers may need to recovery from a failure to identify a drive,
such as the Broadcom AHCI controller, make that possible at both the
libata-core.c and AHCI controller level such that we can provide such an error
recovery callback.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/libata-core.c | 2 ++
 include/linux/libata.h    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3c09122bf038..921c2813af07 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2045,6 +2045,8 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	if (ata_msg_warn(ap))
 		ata_dev_warn(dev, "failed to IDENTIFY (%s, err_mask=0x%x)\n",
 			     reason, err_mask);
+	if (ap->host->ops->port_recovery)
+		ap->host->ops->port_recovery(ap);
 	return rc;
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ed9826b21c5e..23646a557ab2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -956,6 +956,7 @@ struct ata_port_operations {
 	int  (*port_resume)(struct ata_port *ap);
 	int  (*port_start)(struct ata_port *ap);
 	void (*port_stop)(struct ata_port *ap);
+	void (*port_recovery)(struct ata_port *ap);
 	void (*host_stop)(struct ata_host *host);
 
 #ifdef CONFIG_ATA_SFF
-- 
2.7.4
