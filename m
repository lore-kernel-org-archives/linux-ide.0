From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] Make ide dma blacklist handling a bit saner.
Date: Thu, 31 May 2007 00:36:05 +0200
Message-ID: <200705310036.06009.bzolnier@gmail.com>
References: <20070521145042.GA6957@redhat.com> <200705282141.42507.bzolnier@gmail.com> <7vfy5ga6v2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:50035 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759250AbXE3WXE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 May 2007 18:23:04 -0400
Received: by an-out-0708.google.com with SMTP id d31so775704and
        for <linux-ide@vger.kernel.org>; Wed, 30 May 2007 15:23:03 -0700 (PDT)
In-Reply-To: <7vfy5ga6v2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Dave Jones <davej@redhat.com>


Hi,

On Tuesday 29 May 2007, Junio C Hamano wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> writes:
> 
> > The change itself looks good but IMO it is worth doing it before patch #2/3
> > (it would also make it possible for me to merge this patch immediately).
> 
> Yes, I should have considered that the earlier #2/3 needs
> coordination between you and Jeff.
> 
> > When it comes to patch #2 - Alan's comment may be a bit harsh but he seems
> > to be right - there should be a common library-like file (ata-blacklist.c
> > or ata-quirks.c or whatever name you like) containing ata_device_blacklist[].
> >
> > This would require slight modification of ide_in_drive_list() to teach
> > it about ATA_HORKAGE_DMA ... Please also note that <linux/ata.h> is used by both
> > IDE and libata so it should be a good place to put struct ata_blacklist_entry
> > and ATA_HORKAGE_* macros.
> 
> Thanks for the hint.  Alan is correct to point out that I
> cheated. ;-)  If I understand correctly, the change would
> involve:
> 
>  - create a new file that has ata_device_blacklist[] whose type
>    is "struct ata_blacklist_entry" (i.e. matches libata-core),
>    by separating the table out of ata/libata-core.c.
> 
>    Q1. should that file go to drivers/ata/ or drivers/ide/?

No strong preference here but I think that it should be drivers/ata/ since it
is updated more frequently (NCQ etc).  Either way there needs to be a BIG FAT
comment at the top of the file explaining that the file is used by both IDE
and SCSI/libata subsystems.

For the new file (i.e. ata-quirks) to be a shared library it needs to be
similar to libraries from lib/ (ie. lib/crc16c).  After some thought I'm
convinced that it is an optimal solution.  It allows the real code sharing
and at the same time it is the simplest when it comes to the build rules.

Of course I can be missing something really obvious which would prevent
this scheme from working...  :)

>  - make that file depended on when either libata and/or IDE is
>    selected.
> 
>    Q2. Kconfig dependency rule is needed for this, perhaps.  How
>    should that look like?

Lets assume that the new config entry will be CONFIG_ATA_QUIRKS
and that it shouldn't be visible during kernel configuration.

* drivers/ata/Kconfig:

menuconfig ATA should select ATA_QUIRKS

...

config ATA_QUIRKS
	tristate
	depends on ATA || BLK_DEV_IDE

* drivers/ide/Kconfig:

config BLK_DEV_IDEDMA should select ATA_QUIRKS

Or something similar... now to the Makefile modifications...

* drivers/ata/Makefile:

Add rule for obj-$(CONFIG_ATA_QUIRKS) at the top of the file.

* drivers/Makefile:

Replace obj-$(CONFIG_ATA) with obj-y (so ata-quirks library
gets compiled even if it is selected only by IDE subsystem).

Since ata-quirks is a stand-alone module the kernel build
system should take care of the rest.

>  - some out-of-tree drivers might be using ide_in_drive_list()
>    and relying on it to take "struct drive_list_entry"; create a
>    new function, ide_in_device_list(), that takes "struct
>    ata_blacklist_entry" as its parameter.
> 
>    Q3. Is the 'out-of-tree drivers' a real issue, and if so, is
>    the above a reasonable avenue to take?

Not a real issue, I'm not aware of any out of tree IDE drivers.

>  - convert in-tree callers to use ide_in_device_list() instead,
>    feeding it ata_device_blacklist[], and remove drive_blacklist[]
>    from drivers/ide/ide-dma.c.
> 
>    Q4. What would you like to do for drive_whitelist[]?

Add ATA_HORKAGE_DMA_OK and add drive_whitelist[] entries back to
ata_device_blacklist[]?  Unless somebody has a better idea...

> > Care to respin both patches?
> 
> Before the questions are answered I cannot respin the earlier
> #2/3, but I can certainly respin #3/3.

Thanks, all three patches were applied.

Bart
