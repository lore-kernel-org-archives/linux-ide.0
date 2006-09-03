From: Jonathan Dieter <jdieter@gmail.com>
Subject: Kernel fix for ICH7M controller
Date: Sun, 03 Sep 2006 17:26:56 +0300
Message-ID: <44FAE630.20801@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030107030304040409050906"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:58729 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750865AbWICO1B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Sep 2006 10:27:01 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1570902wxc
        for <linux-ide@vger.kernel.org>; Sun, 03 Sep 2006 07:27:01 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: fedora-devel-list@redhat.com

This is a multi-part message in MIME format.
--------------030107030304040409050906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The ata_piix module doesn't detect that my laptop's disk controller 
(Intel Corporation 82801GBM/GHM - ICH7 Family) is configured to have 
PATA drives in the first two channels.  I looked at Intel's 
documentation and they say that my controller isn't supposed to support 
this configuration, but it's the default setup on this laptop, there's 
no way to change it in the BIOS, and it works in Windows, so I'm 
assuming this is a documentation error.

This patch changes one line in ata_piix.c so that it sees this 
configuration as valid (and therefore recognizes my drives).  I've 
tested it on my laptop and the module is now working perfectly (whereas 
the kernel was using the old IDE driver previously with no DMA enabled).

I'm cc'ing fedora-devel-list because I'm not even sure where this patch 
is supposed to go and I would like it to make it into FC6, as I really 
don't want to have to jump through hoop after hoop just to get FC6 
installed on my hard drive.

Thanks,
Jonathan


--------------030107030304040409050906
Content-Type: text/x-patch;
 name="linux-2.6-fix-ich7m-with-pata-on-channel-one.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6-fix-ich7m-with-pata-on-channel-one.patch"

--- linux-2.6.17/drivers/scsi/ata_piix.c	2006-09-03 16:37:16.000000000 +0300
+++ linux-2.6.17-new/drivers/scsi/ata_piix.c	2006-09-03 16:39:14.000000000 +0300
@@ -326,15 +326,15 @@
 static const struct piix_map_db ich6m_map_db = {
 	.mask = 0x3,
 	.port_enable = 0x5,
 	.present_shift = 4,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
 		{  P0,  P2,  RV,  RV }, /* 00b */
-		{  RV,  RV,  RV,  RV },
+		{ IDE, IDE,  P1,  P3 }, /* 01b */
 		{  P0,  P2, IDE, IDE }, /* 10b */
 		{  RV,  RV,  RV,  RV },
 	},
 };
 
 static const struct piix_map_db ich8_map_db = {
 	.mask = 0x3,

--------------030107030304040409050906--

-- 
VGER BF report: U 0.501341
