From: Brett Russ <russb@emc.com>
Subject: Re: [PATCH] libata-2.6: verify cmd bug fixes/support
Date: Wed, 02 Feb 2005 08:19:27 -0500
Message-ID: <4200D35F.5030200@emc.com>
References: <42002023.9060606@emc.com> <42004A0C.70809@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080301080607060702000201"
Received: from mailhub.lss.emc.com ([168.159.2.31]:16869 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S262437AbVBBNTc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Feb 2005 08:19:32 -0500
Received: from [192.168.1.100] ([10.4.10.126])
	by mailhub.lss.emc.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id j12DJPv4021023
	for <linux-ide@vger.kernel.org>; Wed, 2 Feb 2005 08:19:25 -0500 (EST)
In-Reply-To: <42004A0C.70809@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080301080607060702000201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Below is a resend of a patch which gets the read verify command working. 
  I moved the patch to the libata-2.6 tree since that seems to be where 
Albert's patch ended up, so let's keep them together.  Sending as an 
attachment to avoid mailer interference.

Signed-off-by: Brett Russ <russb@emc.com>

--------------080301080607060702000201
Content-Type: text/x-patch;
 name="libata-2.6.10-rc2-verify.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-2.6.10-rc2-verify.diff"

===== drivers/scsi/libata-scsi.c 1.63 vs edited =====
--- 1.63/drivers/scsi/libata-scsi.c	2005-02-01 22:24:53 -05:00
+++ edited/drivers/scsi/libata-scsi.c	2005-02-02 08:03:50 -05:00
@@ -488,13 +488,18 @@
 	}
 
 	if (lba48) {
+		tf->command = ATA_CMD_VERIFY_EXT;
+
 		tf->hob_nsect = (n_sect >> 8) & 0xff;
 
 		tf->hob_lbah = (sect >> 40) & 0xff;
 		tf->hob_lbam = (sect >> 32) & 0xff;
 		tf->hob_lbal = (sect >> 24) & 0xff;
-	} else
+	} else {
+		tf->command = ATA_CMD_VERIFY;
+
 		tf->device |= (sect >> 24) & 0xf;
+	}
 
 	tf->nsect = n_sect & 0xff;
 
===== include/linux/ata.h 1.21 vs edited =====
--- 1.21/include/linux/ata.h	2004-11-06 13:44:16 -05:00
+++ edited/include/linux/ata.h	2005-02-02 08:15:49 -05:00
@@ -123,6 +123,8 @@
 	ATA_CMD_PIO_WRITE_EXT	= 0x34,
 	ATA_CMD_SET_FEATURES	= 0xEF,
 	ATA_CMD_PACKET		= 0xA0,
+	ATA_CMD_VERIFY		= 0x40,
+	ATA_CMD_VERIFY_EXT	= 0x42,
 
 	/* SETFEATURES stuff */
 	SETFEATURES_XFER	= 0x03,

--------------080301080607060702000201--
