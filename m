From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata 4726 Testing
Date: Wed, 09 Jan 2008 14:45:53 +0900
Message-ID: <47845F91.9000705@gmail.com>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com> <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com> <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com> <47832D82.2020106@shaw.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080001020208060306050303"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:63624 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbYAIFqD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 00:46:03 -0500
Received: by wa-out-1112.google.com with SMTP id v27so190158wah.23
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 21:46:03 -0800 (PST)
In-Reply-To: <47832D82.2020106@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Ryder <tireman@shaw.ca>, "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080001020208060306050303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Please apply the attached patch on top of 2.6.24-rc7 and report the
result.  Thanks.

-- 
tejun

--------------080001020208060306050303
Content-Type: text/x-patch;
 name="simg-pmp-quirk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="simg-pmp-quirk.patch"

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index c0c4dbc..c07566c 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -467,7 +467,8 @@ static void sata_pmp_quirks(struct ata_port *ap)
 
 			/* class code report is unreliable */
 			if (link->pmp < 5)
-				link->flags |= ATA_LFLAG_ASSUME_ATA;
+				link->flags |= ATA_LFLAG_NO_SRST |
+					       ATA_LFLAG_ASSUME_ATA;
 
 			/* port 5 is for SEMB device and it doesn't like SRST */
 			if (link->pmp == 5)
@@ -482,7 +483,8 @@ static void sata_pmp_quirks(struct ata_port *ap)
 
 			/* class code report is unreliable */
 			if (link->pmp < 2)
-				link->flags |= ATA_LFLAG_ASSUME_ATA;
+				link->flags |= ATA_LFLAG_NO_SRST |
+					       ATA_LFLAG_ASSUME_ATA;
 
 			/* the config device at port 2 locks up on SRST */
 			if (link->pmp == 2)
@@ -497,7 +499,8 @@ static void sata_pmp_quirks(struct ata_port *ap)
 
 			/* class code report is unreliable */
 			if (link->pmp < 5)
-				link->flags |= ATA_LFLAG_ASSUME_ATA;
+				link->flags |= ATA_LFLAG_NO_SRST |
+					       ATA_LFLAG_ASSUME_ATA;
 
 			/* The config device, which can be either at
 			 * port 0 or 5, locks up on SRST.

--------------080001020208060306050303--
