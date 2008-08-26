From: Frans Pop <elendil@planet.nl>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Tue, 26 Aug 2008 12:25:45 +0200
Message-ID: <200808261225.46315.elendil@planet.nl>
References: <200808261124.39282.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml12.kpnxchange.com ([213.75.38.112]:35967 "EHLO
	hpsmtp-eml12.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757356AbYHZKZt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2008 06:25:49 -0400
In-Reply-To: <200808261124.39282.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Tuesday 26 August 2008, Frans Pop wrote:
> After booting the system I did 'echo 1 >/sys/block/sdX/device/queue_depth'
> and after that the HDD led showed disk activity again.

And to confirm that, applying the following patch to sata_mv for 2.6.26.3
makes the HDD led work again as well:

--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -131,7 +131,7 @@ enum {

        MV_GENIIE_FLAGS         = MV_COMMON_FLAGS | MV_6XXX_FLAGS |
                                  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
-                                 ATA_FLAG_NCQ | ATA_FLAG_AN,
+                                 ATA_FLAG_AN,

        CRQB_FLAG_READ          = (1 << 0),
        CRQB_TAG_SHIFT          = 1,

So somehow enabling NCQ is at the root of the issue.

Cheers,
FJP
