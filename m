From: "Kuan Luo" <kluo@nvidia.com>
Subject: RE: [patch 05/25] ata: add the SW NCQ support to sata_nv for MCP51/MCP55/MCP61
Date: Thu, 27 Sep 2007 14:12:08 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B059FE1AB@hkemmail01.nvidia.com>
References: <200708102059.l7AKxYVQ008581@imap1.linux-foundation.org> <46F2F6E5.3010406@garzik.org> <46F35C7F.20400@dunaweb.hu> <46F9D6A8.8010809@garzik.org> <46F9EFC9.9030209@dunaweb.hu> <46F9F05F.40905@garzik.org> <46F9F223.4000406@dunaweb.hu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.112.152]:17148 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbXI0GRs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 02:17:48 -0400
In-Reply-To: <46F9F223.4000406@dunaweb.hu>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Zoltan Boszormenyi <zboszor@dunaweb.hu>
Cc: akpm@linux-foundation.org, Peer Chen <pchen@nvidia.com>, Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org

hi,
i saw the below changes  from
http://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git;a=commi
tdiff;h=5a5a9e1890b8260686218a68862d880daee1a817

[libata] sata_nv: Clean up ATA_FLAG_NCQ usage; bit test micro-opt

 @@ -622,7 +622,9 @@ static const struct ata_port_info nv_port_info[] =
{
        /* SWNCQ */
        {
                .sht            = &nv_swncq_sht,
-               .flags          = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+               .flags          = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+                                 ATA_FLAG_NCQ,
+               .link_flags     = ATA_LFLAG_HRST_TO_RESUME,
                .pio_mask       = NV_PIO_MASK,
                .mwdma_mask     = NV_MWDMA_MASK,
                .udma_mask      = NV_UDMA_MASK,

If swncq_enabled is set zero by user, nv_swncq_host_init would not be
called .
 Then ncq should be disabled and the libata shouldn't send ncq cmd. 
 I am not sure whether the  ATA_FLAG_NCQ flag which is in default set
makes libata send ncq cmd even when swncq_enable is 0?

nv_init_one
	} else if (type == SWNCQ && swncq_enabled) {
		dev_printk(KERN_NOTICE, &pdev->dev, "Using SWNCQ
mode\n");
		nv_swncq_host_init(host);
	}
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
