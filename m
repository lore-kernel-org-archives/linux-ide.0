From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Q: IDE->SATA adaptor
Date: Sat, 26 Nov 2005 12:28:44 +0100
Message-ID: <20051126112844.GA10006@midnight.suse.cz>
References: <438826A2.2020204@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:59566 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750828AbVKZL3F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Nov 2005 06:29:05 -0500
Content-Disposition: inline
In-Reply-To: <438826A2.2020204@eyal.emu.id.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: list linux-ide <linux-ide@vger.kernel.org>

On Sat, Nov 26, 2005 at 08:10:58PM +1100, Eyal Lebedinsky wrote:
> I am still looking for a working setup for adding more SATA
> disks to my machine. I acquired a small PCB that plugs into
> the IDE socket on the mobo and provides two SATA sockets.
> 
> It worked out of the box, except that it only does udma2. Not
> what I want.
> 
> If I try to set it to a higher mode I get the message
> 	hdc: Speed warnings UDMA 3/4/5 is not functional.
> 
> After some digging into the ide code I identified the problem
> as 'id->hw_config' being zero. In two places it is checked
> before allowing higher udma modes. One bit seems to be related
> to the 80c (which has no meaning here and should probably
> be hardwired on the board) and the other I am not sure.

What IDE controller are you using?

> I patched ide-iops.c to not check hw_config in the two funcs
> where it does so:
> 	eighty_ninty_three
> 	ide_ata66_check
> 
> 
> BTW my .config says:
> 	CONFIG_BLK_DEV_IDEDMA=y
> 	CONFIG_IDEDMA_IVB=y
> 	CONFIG_IDEDMA_AUTO=y
> 
> but the IVB is not enough here.
> 
> 
> Does anyone know what is the correct way to get this adapter going without
> a patch?

I think specifying "ide0=ata66" on the kernel command line could help.

> I should say that the disks do identify themselves correctly (see below)
> but the kernel only accept some modes:
> 
> # hdparm -i /dev/hdc
>   ==================
> /dev/hdc:
> 
>  Model=WDC WD3200JD-00KLB0, FwRev=08.05J08, SerialNo=WD-WCAMR1427570
>  Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2
>  AdvancedPM=no WriteCache=enabled
>  Drive conforms to: device does not report version:
> 
>  * signifies the current active mode
> 
> 
> # hdparm -I /dev/hdc
>   ==================
> /dev/hdc:
> 
> ATA device, with non-removable media
>         Model Number:       WDC WD3200JD-00KLB0
>         Serial Number:      WD-WCAMR1427570
>         Firmware Revision:  08.05J08
> Standards:
>         Supported: 6 5 4 3
>         Likely used: 6
> Configuration:
>         Logical         max     current
>         cylinders       16383   65535
>         heads           16      1
>         sectors/track   63      63
>         --
>         CHS current addressable sectors:    4128705
>         LBA    user addressable sectors:  268435455
>         LBA48  user addressable sectors:  625142448
>         device size with M = 1024*1024:      305245 MBytes
>         device size with M = 1000*1000:      320072 MBytes (320 GB)
> Capabilities:
>         LBA, IORDY(can be disabled)
>         bytes avail on r/w long: 4      Queue depth: 1
>         Standby timer values: spec'd by Standard, with device specific minimum
>         R/W multiple sector transfer: Max = 16  Current = 16
>         Recommended acoustic management value: 128, current value: 254
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4
>              Cycle time: no flow control=120ns  IORDY flow control=120ns
> Commands/features:
>         Enabled Supported:
>            *    READ BUFFER cmd
>            *    WRITE BUFFER cmd
>            *    Host Protected Area feature set
>            *    Look-ahead
>            *    Write cache
>            *    Power Management feature set
>                 Security Mode feature set
>                 SMART feature set
>            *    FLUSH CACHE EXT command
>            *    Mandatory FLUSH CACHE command
>            *    Device Configuration Overlay feature set
>            *    48-bit Address feature set
>                 Automatic Acoustic Management feature set
>                 SET MAX security extension
>            *    DOWNLOAD MICROCODE cmd
>            *    SMART self-test
>            *    SMART error logging
> Security:
>         Master password revision code = 65534
>                 supported
>         not     enabled
>         not     locked
>         not     frozen
>         not     expired: security count
>         not     supported: enhanced erase
> Checksum: correct
> 
> -- 
> Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
> 	attach .zip as .dat
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
