From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH #upstream] ahci: add HFLAG_YES_FBS and apply it to 88SE9128
Date: Fri, 07 Jan 2011 21:22:35 +0200
Message-ID: <4D2767FB.5060706@iki.fi>
References: <4C4AFE7C.5070506@kernel.org> <4CF45BC0.2030701@iki.fi> <4CF4FCBE.2060406@kernel.org> <4CF55A4B.1020402@iki.fi> <4CFE8EE2.1060908@iki.fi> <4CFF67B6.7090805@kernel.org> <4CFFC9D0.2090803@garzik.org> <4CFFCAE3.1090106@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060402070009010508030706"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from saarni.dnainternet.net ([83.102.40.136]:49337 "EHLO
	saarni.dnainternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab1AGTWm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2011 14:22:42 -0500
In-Reply-To: <4CFFCAE3.1090106@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>

This is a multi-part message in MIME format.
--------------060402070009010508030706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 08.12.2010 20:13, Tejun Heo wrote:
> Hello,

Hello!

> On 12/08/2010 07:09 PM, Jeff Garzik wrote:
>>> I'm not completely comfortable with going ahead with the patch tho.
>>> It probably is okay but it's still a shot in the dark.  Is there
>>> anyone with marvell contact?
>>
>> I have docs for most Marvell models, but not this one; and no
>> contacts...  Presumably it is some variant of their existing Marvell
>> AHCI line of chips, but beyond that, you and I are both just
>> guessing.
> 
> Eh, well, in that case as it's a fix one way or the other,
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.

Ping? This regression fix doesn't seem to be applied in any tree yet.

Attached again, just in case.

-- 
Anssi Hannula

--------------060402070009010508030706
Content-Type: text/x-patch;
 name="0001-ahci-do-not-match-the-IDE-interface-of-88SE9128.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ahci-do-not-match-the-IDE-interface-of-88SE9128.patch"

>From 5e4e904eb78d69528bc3b3ddd39a55579642bfbd Mon Sep 17 00:00:00 2001
From: Anssi Hannula <anssi.hannula@iki.fi>
Date: Tue, 30 Nov 2010 03:43:15 +0200
Subject: [PATCH] ahci: do not match the IDE interface of 88SE9128

Commit 5f173107ecad83a50 added HFLAG_YES_FBS workaround for 88SE9128
(1b4b:9123).

However, that change inadvertently caused the legacy IDE interface of
the controller (with the same pci id) to become associated with the AHCI
driver as well, causing the driver to try to bring the interface up in
vain.

Fix that by matching against class as well.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 drivers/ata/ahci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3288263..791cf9b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -379,6 +379,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
 	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
 	{ PCI_DEVICE(0x1b4b, 0x9123),
+	  .class = PCI_CLASS_STORAGE_SATA_AHCI,
+	  .class_mask = 0xffffff,
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9128 */
 
 	/* Promise */
-- 
1.7.3


--------------060402070009010508030706--
