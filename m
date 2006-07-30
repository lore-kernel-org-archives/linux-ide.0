From: Tejun Heo <htejun@gmail.com>
Subject: Re: Hotplug with sata_nv
Date: Mon, 31 Jul 2006 05:35:01 +0900
Message-ID: <44CD17F5.5010800@gmail.com>
References: <44BE9B67.7020901@philipp-wagner.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070709030507090705050806"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:42315 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751352AbWG3Uey (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Jul 2006 16:34:54 -0400
Received: by py-out-1112.google.com with SMTP id t32so449776pyc
        for <linux-ide@vger.kernel.org>; Sun, 30 Jul 2006 13:34:54 -0700 (PDT)
In-Reply-To: <44BE9B67.7020901@philipp-wagner.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philipp Wagner <mail@philipp-wagner.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070709030507090705050806
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello, Philipp,

Sorry about late reply.  There were OLS and then some personal things to 
attend to.

Philipp Wagner wrote:
> When I remove one drive, I get the following messages into
> /var/log/messages:
> 
> Jul 19 21:59:08 srv1 kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
> 0x1810000 action 0x2 frozen
> Jul 19 21:59:08 srv1 kernel: ata2: soft resetting port
> Jul 19 21:59:08 srv1 kernel: ata2: SATA link down (SStatus 0 SControl 300)
> Jul 19 21:59:08 srv1 kernel: ata2: failed to recover some devices,
> retrying in 5 secs
> Jul 19 21:59:13 srv1 kernel: ata2: hard resetting port
> Jul 19 21:59:14 srv1 kernel: ata2: SATA link down (SStatus 0 SControl 300)
> Jul 19 21:59:14 srv1 kernel: ata2: failed to recover some devices,
> retrying in 5 secs
> Jul 19 21:59:19 srv1 kernel: ata2: hard resetting port
> Jul 19 21:59:20 srv1 kernel: ata2: SATA link down (SStatus 0 SControl 300)
> Jul 19 21:59:20 srv1 kernel: ata2.00: disabled
> Jul 19 21:59:20 srv1 kernel: ata2: EH pending after completion,
> repeating EH (cnt=4)
> Jul 19 21:59:20 srv1 kernel: ata2: EH complete
> 
> The files /dev/sdb* are removed and the RAID says it has been degraded,
> which is perfectly ok.

This looks good.

> Now I re-insert the drive and get the following messages into
> /var/log/messages:
> 
> Jul 19 22:00:11 srv1 kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
> 0x50000 action 0x2 frozen
> Jul 19 22:00:19 srv1 kernel: ata2: port is slow to respond, please be
> patient
> Jul 19 22:00:42 srv1 kernel: ata2: port failed to respond (30 secs)
> Jul 19 22:00:42 srv1 kernel: ata2: soft resetting port
> Jul 19 22:00:49 srv1 kernel: ata2: port is slow to respond, please be
> patient
> Jul 19 22:01:12 srv1 kernel: ata2: port failed to respond (30 secs)
> Jul 19 22:01:12 srv1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
> SControl 300)
> Jul 19 22:01:12 srv1 kernel: ata2: EH pending after completion,
> repeating EH (cnt=4)
> Jul 19 22:01:12 srv1 kernel: ata2: EH complete

Hmmm... Softreset fails but libata doesn't notice it has failed.

Can you try the attached patch?

-- 
tejun

--------------070709030507090705050806
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 56da255..0ff682b 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -257,7 +257,9 @@ static struct ata_port_info nv_port_info
 	/* generic */
 	{
 		.sht		= &nv_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_HRST_TO_RESUME |
+				  ATA_FLAG_SKIP_D2H_BSY,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
@@ -266,7 +268,9 @@ static struct ata_port_info nv_port_info
 	/* nforce2/3 */
 	{
 		.sht		= &nv_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_HRST_TO_RESUME |
+				  ATA_FLAG_SKIP_D2H_BSY,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
@@ -275,7 +279,9 @@ static struct ata_port_info nv_port_info
 	/* ck804 */
 	{
 		.sht		= &nv_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_HRST_TO_RESUME |
+				  ATA_FLAG_SKIP_D2H_BSY,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,

--------------070709030507090705050806--
