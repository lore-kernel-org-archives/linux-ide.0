From: kelk1@comcast.net (Quel Qun)
Subject: Re: Boot fails on Intel SATA controller
Date: Thu, 02 Aug 2007 16:49:49 +0000
Message-ID: <080220071649.26639.46B20B2D00011D1D0000680F2206424613CE05040A05@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NextPart_Webmail_9m3u9jl4l_26639_1186073389_0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:43984 "EHLO
	rwcrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbXHBQtu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 12:49:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>, linux-ide@vger.kernel.org


--NextPart_Webmail_9m3u9jl4l_26639_1186073389_0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit


 -------------- Original message ----------------------
From: Tejun Heo <htejun@gmail.com>
> Quel Qun wrote:
> >  -------------- Original message ----------------------
> > From: Tejun Heo <htejun@gmail.com>
> >> Hello,
> >>
> >> Luiz Fernando N. Capitulino wrote:
> >>>  Hi there,
> >>>
> >>>  A Mandriva user is reporting that his machine hangs while booting
> >>> kernels 2.6.22.1 and 2.6.23-rc1.
> >>>
> >>>  But boots fine with 2.6.21.
> >>>
>
> Does the attached patch change anything?
> 

Hi and thanks for answering.

2.6.23-rc1 boots if I comment out these two lines. The drive does have the two original dell special partitions that were on it when I received the computer (sda1 and sda3).

Here is some info I could gather about the disk. Let me know if you need anything else.

Boot log:

ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)^M
ata1.00: ATA-7: HDS724040KLSA80, KFAOA20N, max UDMA/133^M
ata1.00: 781422768 sectors, multi 8: LBA48 ^M
ata1.00: configured for UDMA/133^M
scsi 0:0:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5^M
Loading ata_piixACPI: PCI Interrupt 0000:00:1f.1[A] -> .ko module^M

The disk partitions:

# fdisk -l /dev/sda

Disk /dev/sda: 400.0 GB, 400088457216 bytes
255 heads, 63 sectors/track, 48641 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1               1           6       48163+  de  Dell Utility
/dev/sda2   *           7        9440    75778605    7  HPFS/NTFS
/dev/sda3           48283       48641     2883667+  db  CP/M / CTOS / ...
/dev/sda4            9441       48282   311998365    5  Extended
/dev/sda5            9441       10068     5044378+   b  W95 FAT32
/dev/sda6           10069       10322     2040223+  83  Linux
/dev/sda7           10323       10462     1124518+  82  Linux swap / Solaris
/dev/sda8           10463       11736    10233373+  83  Linux
/dev/sda9           11737       29948   146287858+  83  Linux
/dev/sda10          29949       48282   147267823+  83  Linux

Partition table entries are not in disk order

And the hdparm output:

# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
powers-up in standby; SET FEATURES subcmd spins-up.
        Model Number:       HDS724040KLSA80                         
        Serial Number:      KRFS11RAGT2EZC
        Firmware Revision:  KFAOA20N
Standards:
        Used: ATA/ATAPI-7 T13 1532D revision 1 
        Supported: 7 6 5 4 
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  781422768
        device size with M = 1024*1024:      381554 MBytes
        device size with M = 1000*1000:      400088 MBytes (400 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 8
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 128, current value: 128
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                Advanced Power Management feature set
                Power-Up In Standby feature set
                SET_FEATURES required to spinup after power up
                Address Offset Reserved Area Boot
                SET_MAX security extension
           *    Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    64-bit World wide name
           *    SATA-I signaling speed (1.5Gb/s)
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        220min for SECURITY ERASE UNIT. 
Checksum: correct

Hope that helps,
--
kk1


--NextPart_Webmail_9m3u9jl4l_26639_1186073389_0
Content-Type: message/rfc822

From: Tejun Heo <htejun@gmail.com>
To: Quel Qun <kelk1@comcast.net>
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,  linux-ide@vger.kernel.org
Subject: Re: Boot fails on Intel SATA controller
Date: Wed, 1 Aug 2007 14:36:13 +0000
Content-Type: Multipart/mixed;
 boundary="NextPart_Webmail_9m3u9jl4l_26639_1186073389_1"

--NextPart_Webmail_9m3u9jl4l_26639_1186073389_1
Content-Type: text/x-patch;
 name="debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d8c6789..af5db69 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1915,8 +1915,8 @@ int ata_dev_configure(struct ata_device *dev)
 					dev->flags |= ATA_DFLAG_FLUSH_EXT;
 			}
 
-			if (ata_id_hpa_enabled(dev->id))
-				dev->n_sectors = ata_hpa_resize(dev);
+			//if (ata_id_hpa_enabled(dev->id))
+			//	dev->n_sectors = ata_hpa_resize(dev);
 
 			/* config NCQ */
 			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));

--NextPart_Webmail_9m3u9jl4l_26639_1186073389_1--

--NextPart_Webmail_9m3u9jl4l_26639_1186073389_0--
