From: "Conke Hu" <conke.hu@gmail.com>
Subject: Re: [PATCH 2/3] atiixp.c: sb600 ide only has one channel
Date: Tue, 9 Jan 2007 20:48:53 +0800
Message-ID: <5767b9100701090448h1d9dc37erc9bbf9c3202f7389@mail.gmail.com>
References: <5767b9100701060414j2e2385a8xcbab477bedca34b3@mail.gmail.com>
	 <58cb370e0701061814g7d37578cj6edab7f15e630348@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:58954 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbXAIMsz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jan 2007 07:48:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so6558600uga
        for <linux-ide@vger.kernel.org>; Tue, 09 Jan 2007 04:48:53 -0800 (PST)
In-Reply-To: <58cb370e0701061814g7d37578cj6edab7f15e630348@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, linux-ide@vger.kernel.org

On 1/7/07, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 1/6/07, Conke Hu <conke.hu@gmail.com> wrote:
> > AMD/ATI SB600 IDE/PATA controller only has one channel.
> >
> > Signed-off-by: Conke Hu <conke.hu@amd.com>
>
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>
> [ but the patch is line wrapped ]
>

Hi Bart,
    Thank you!
    I've re-created the patch based on 2.6.20-rc4, pls see below.
    I've sent out 3 patches for the same file atiixp.c, pls apply it
after the [patch 1/3] :)
-------------------
--- linux-2.6.20-rc4/drivers/ide/pci/atiixp.c.2	2007-01-09
15:21:29.000000000 +0800
+++ linux-2.6.20-rc4/drivers/ide/pci/atiixp.c	2007-01-09
15:25:15.000000000 +0800
@@ -328,7 +328,14 @@ static ide_pci_device_t atiixp_pci_info[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
 		.bootable	= ON_BOARD,
-	},
+	},{	/* 1 */
+		.name		= "SB600_PATA",
+		.init_hwif	= init_hwif_atiixp,
+		.channels	= 1,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x48,0x01,0x00}, {0x00,0x00,0x00}},
+ 		.bootable	= ON_BOARD,
+ 	},
 };

 /**
@@ -349,7 +356,7 @@ static struct pci_device_id atiixp_pci_t
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP200_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 1},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
