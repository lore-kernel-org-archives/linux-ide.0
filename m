From: Marc Zuckman <marc@fallon.classyad.com>
Subject: Problem setting dma using pata_it821x driver in vanilla 2.6.23.12 and gentoo-sources 2.6.23-r3
Date: Sat, 5 Jan 2008 17:34:17 -0500
Message-ID: <200801051734.18088.marc@fallon.classyad.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from c-71-205-247-245.hsd1.mi.comcast.net ([71.205.247.245]:60114
	"EHLO fallon.classyad.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbYAEWzc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jan 2008 17:55:32 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I recently compiled gentoo-sources-2.6.23-r3 and subsequently vanilla 
2.6.23.12 , but could not get hdparm v 7.7 (or earlier) to set my it8212f 
controlled raid array to use dma. 

>From past experience, I have learned that  my raid 1 array (using the it8212f 
raid controller present on my Gigabyte motherboard ) will not function 
properly unless it is set to use dma with hdparm. As a result, I execute 
hdparm -d1 /dev/hde in both the Gentoo boot and ordinary run levels. The 
system has worked fine with multiple 2.6.x kernels. The last kernel that I 
have successfully used is 2.6.20-gentoo-r7 (gentoo-sources).

I have checked linux kernel archives several times and have posted this 
problem on gentoo forums, but have not been able to find similar reports.

Perhaps related, but I doubt it, are boot messages that I initially received 
about disabling speeds > udma 33 due to failure to detect proper cabling on 
the host side of several ide interfaces (more details unfortunately vague).  
My cabling is definitely proper.  I haven't noted the cabling messages with 
recent boot attempts with the problem kernels  and I think (not 100% sure) 
they were abolished by using the "OBSOLETE" lilo boot loader append 
commands "ide0=ata66, ide2=ata66"

I compiled the kernel with these config parameters:
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_IDEPCI_PCIBUS_ORDER=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT8213 is not set
CONFIG_BLK_DEV_IT821X=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_BLK_DEV_HD is not set

These are corresponding boot messages from vanilla 2.6.23.12:
Kernel command line: BOOT_IMAGE=vanilla2.6.23 ro root=307 ide0=ata66 
ide2=ata66
ide_setup: ide2=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
IT8212: IDE controller at PCI slot 0000:03:0c.0
IT8212: chipset revision 17
it821x: controller in smart mode.
IT8212: 100% native mode on irq 21
    ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Integrated Technology Express Inc, ATA DISK drive
hde: IT8212 RAID 1 volume.
hde: selected mode 0x0
ide2 at 0xa810-0xa817,0xac02 on irq 21
Probing IDE interface ide3...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hde: max request size: 128KiB
hde: 312581806 sectors (160041 MB), CHS=19457/255/63
hde: cache flushes not supported
 hde: hde1
hde: selected mode 0x0
EXT3 FS on hde1, internal journal
hde: selected mode 0x0

Messages from hdparm after booting complete:
hdparm -V :   hdparm v7.7

hdparm /dev/hde:
/dev/hde:
 multcount     =  0 (off)
 IO_support    =  0 (default 16-bit)
 unmaskirq     =  0 (off)
 using_dma     =  0 (off)
 keepsettings  =  0 (off)
 readonly      =  0 (off)
 readahead     = 256 (on)
 geometry      = 19457/255/63, sectors = 312581806, start = 0
 
hdparm -d1 /dev/hde:
/dev/hde:
 setting using_dma to 1 (on)
HDIO_SET_DMA failed: Input/output error
 using_dma     =  0 (off)
