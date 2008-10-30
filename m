From: "Borislav Petkov" <petkovbb@googlemail.com>
Subject: Re: Linux 2.6.28-rc2 lost IDE disk on old laptop
Date: Thu, 30 Oct 2008 15:33:38 +0100
Message-ID: <9ea470500810300733u34dab7d2rd69a8d806b85ac65@mail.gmail.com>
References: <alpine.LFD.2.00.0810261221350.3386@nehalem.linux-foundation.org>
	 <20081030135017.GA8325@erig.dyndns.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755965AbYJ3Odw@vger.kernel.org>
In-Reply-To: <20081030135017.GA8325@erig.dyndns.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org

Hi,

On Thu, Oct 30, 2008 at 2:50 PM, Wolfgang Erig <Wolfgang.Erig@gmx.de> wrote:
> Hi,
>
> the kernel 2.6.28-rc2 does not boot on my old laptop.
> Panic ... cannot access (301) ... aka /dev/hda1
> The previously used version 2.6.27-rc8 runs fine.
>
> During 'make oldconfig' I saw questions about IDE (or ATA)
> but I see no obvious problem with my .config
>
> Wolfgang
>
>
> $ lspci
> 00:00.0 Host bridge: Intel Corporation 430TX - 82439TX MTXC (rev 01)
> 00:01.0 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 01)
> 00:01.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)

Have you tried compiling your kernel with CONFIG_BLK_DEV_PIIX enabled and
CONFIG_IDE_GENERIC disabled?

> 00:01.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
> 00:01.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 01)
> 00:06.0 VGA compatible controller: Chips and Technologies F65554 (rev c2)
> 00:14.0 CardBus bridge: Cirrus Logic PD 6832 PCMCIA/CardBus Ctrlr (rev c1)
> 00:14.1 CardBus bridge: Cirrus Logic PD 6832 PCMCIA/CardBus Ctrlr (rev c1)
>
> $ egrep -i 'ide|ata' .config
> # CONFIG_X86_MCE_NONFATAL is not set
> # CONFIG_ATALK is not set
> CONFIG_HAVE_IDE=y
> CONFIG_IDE=y
> # Please see Documentation/ide/ide.txt for help/info on IDE drives
> # CONFIG_BLK_DEV_IDE_SATA is not set
> CONFIG_IDE_GD=y
> CONFIG_IDE_GD_ATA=y
> # CONFIG_IDE_GD_ATAPI is not set
> # CONFIG_BLK_DEV_IDECS is not set
> CONFIG_BLK_DEV_IDECD=y
> CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> # CONFIG_IDE_PROC_FS is not set
> # IDE chipset support/bugfixes
> CONFIG_IDE_GENERIC=y
> # CONFIG_BLK_DEV_IDEPNP is not set
> # PCI IDE chipsets support
> # Other IDE chipsets support
> # CONFIG_BLK_DEV_IDEDMA is not set
> # CONFIG_ATA is not set
> # CONFIG_VIDEO_DEV is not set
> # CONFIG_VIDEO_MEDIA is not set
> CONFIG_VIDEO_OUTPUT_CONTROL=m
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> # Authenticated Encryption with Associated Data
>

-- 
Regards/Gruss,
Boris
