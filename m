From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Netcell SyncRaid problem post 2.6.27
Date: Fri, 29 May 2009 21:13:16 +0200
Message-ID: <200905292113.16487.bzolnier@gmail.com>
References: <20090528230317.RVVK21638.aamtaout02-winn.ispmail.ntl.com@trevor2.dsl.pipex.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f168.google.com ([209.85.220.168]:37332 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbZE2TJl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 May 2009 15:09:41 -0400
Received: by fxm12 with SMTP id 12so4588898fxm.37
        for <linux-ide@vger.kernel.org>; Fri, 29 May 2009 12:09:42 -0700 (PDT)
In-Reply-To: <20090528230317.RVVK21638.aamtaout02-winn.ispmail.ntl.com@trevor2.dsl.pipex.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Trevor Hemsley <trevor.hemsley@ntlworld.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Friday 29 May 2009 01:01:33 Trevor Hemsley wrote:
> On Thu, 28 May 2009 14:10:15 +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> >
> >On Thursday 28 May 2009 01:56:21 Trevor Hemsley wrote:
> >> Hi
> >> 
> >> Apologies if you are not the kernel maintainer that I should be writing
> >> to.
> >> 
> >> I have a Netcell SyncRAID SR5000 controller in my machine here and in
> >> kernels post 2.6.27 it is no longer working correctly. I've had a quick
> >> look at the code but before I dig too deeply, I thought I'd ask to see
> >> if this is something that's already been fixed.
> >
> >Checks for LBA48 support were fixed at this time and since this is a kind
> >of unusual controller (hardware ATA RAID) it could be that we may need to
> >add some special tweaks for it (or it could be just a bug somewhere).
> >
> >Please send me output of 'hdparm --Istdout /dev/hde' command, also please
> >use linux-ide@vger.kernel.org mailing list for communication if possible.
> 
> Since I am unsure about the etiquette of posting attachments to this
> list I have put copies of hdparm --Istdout /dev/hde and dmesg output
> from both kernel 2.6.27.2 and 2.6.29.4 in
> http://www.os2warp.org/sysbench/netcell.tar.gz
> 
> Both kernels are self-compiled but based on the original Centos 5.3
> .config file. The 2.6.29.4 is created by copying the 2.6.27.2 .config
> and then running `make oldconfig` and taking all defaults for those
> items that are new.

Thanks.

Please try this patch (it is for 2.6.30-rc7 but also applies to 2.6.29):

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide_pci_generic: add quirk for Netcell ATA RAID

We need to explicitly mark words 85-87 as valid ones since
firmware doesn't do it.

This should fix support for LBA48 and FLUSH CACHE [EXT] command
which stopped working after we applied more strict checking of
identify words in:

	commit 942dcd85bf8edf38cdc3745306ca250684d99a61
	("ide: idedisk_supports_lba48() -> ata_id_lba48_enabled()")

and

	commit 4b58f17d7c45a8e5f4acda641bec388398b9c0fa
	("ide: ide_id_has_flush_cache() -> ata_id_flush_enabled()")

Reported-by: "Trevor Hemsley" <trevor.hemsley@ntlworld.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
once tested+merged this should also go into 2.6.2[89] and libata

 drivers/ide/ide-pci-generic.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: b/drivers/ide/ide-pci-generic.c
===================================================================
--- a/drivers/ide/ide-pci-generic.c
+++ b/drivers/ide/ide-pci-generic.c
@@ -33,6 +33,16 @@ static int ide_generic_all;		/* Set to c
 module_param_named(all_generic_ide, ide_generic_all, bool, 0444);
 MODULE_PARM_DESC(all_generic_ide, "IDE generic will claim all unknown PCI IDE storage controllers.");
 
+static void netcell_quirkproc(ide_drive_t *drive)
+{
+	/* mark words 85-87 as valid */
+	drive->id[ATA_ID_CSF_DEFAULT] |= 0x4000;
+}
+
+static const struct ide_port_ops netcell_port_ops = {
+	.quirkproc		= netcell_quirkproc,
+};
+
 #define DECLARE_GENERIC_PCI_DEV(extra_flags) \
 	{ \
 		.name		= DRV_NAME, \
@@ -74,6 +84,7 @@ static const struct ide_port_info generi
 
 	{	/* 6: Revolution */
 		.name		= DRV_NAME,
+		.port_ops	= &netcell_port_ops,
 		.host_flags	= IDE_HFLAG_CLEAR_SIMPLEX |
 				  IDE_HFLAG_TRUST_BIOS_FOR_DMA |
 				  IDE_HFLAG_OFF_BOARD,
