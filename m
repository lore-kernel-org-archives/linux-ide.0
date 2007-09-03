From: Tejun Heo <htejun@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Mon, 03 Sep 2007 11:45:48 +0900
Message-ID: <46DB755C.308@gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>	 <46DAB5DD.80807@gmail.com> <6f9550040709021129m63b143f5jdda365f6042560d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:22049 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbXICCpz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 22:45:55 -0400
Received: by rv-out-0910.google.com with SMTP id k20so846831rvb
        for <linux-ide@vger.kernel.org>; Sun, 02 Sep 2007 19:45:54 -0700 (PDT)
In-Reply-To: <6f9550040709021129m63b143f5jdda365f6042560d5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eddie Hung <eddie.hung@gmail.com>
Cc: linux-ide@vger.kernel.org

drivers/ata/Eddie Hung wrote:
> ATA device, with non-removable media
> 	Model Number:       SMI MODEL
> 	Serial Number:      SZAUSWIN    000006E5
> 	Firmware Revision:  20070709
> Standards:
> 	Likely used: 5
> Configuration:
> 	Logical		max	current
> 	cylinders	7866	7866
> 	heads		16	16
> 	sectors/track	63	63
> 	--
> 	CHS current addressable sectors:    7928928
> 	LBA    user addressable sectors:    7928928
> 	device size with M = 1024*1024:        3871 MBytes
> 	device size with M = 1000*1000:        4059 MBytes (4 GB)
> Capabilities:
> 	LBA, IORDY(may be)(cannot be disabled)
> 	bytes avail on r/w long: 4
> 	Standby timer values: spec'd by Vendor
> 	R/W multiple sector transfer: Max = 1	Current = 0
> 	DMA: mdma0 mdma1 *mdma2

Yeap, your device's best mode is mwdma2.

> [    4.504000] ata1.00: ATA-0: SMI MODEL, 20070709, max MWDMA2
> [    4.504000] ata1.00: 7928928 sectors, multi 0: LBA
> [    4.504000] ata1.00: applying bridge limits
> [    4.520000] ata1.00: configured for MWDMA2
[--snip--]
> [ 1301.836000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [ 1301.836000] ata1.00: cmd ca/00:80:50:55:1f/00:00:00:00:00/e0 tag 0
> cdb 0x0 data 65536 out
> [ 1301.836000]          res 40/00:00:00:00:00/00:00:00:00:00/e0 Emask
> 0x4 (timeout)
> ** End ***
> 
> I can see that it falls back from MWDMA2 to MWDMA1, but it doesn't
> fall back again to Single Word DMA?

libata doesn't use SWDMA.  SWDMA is pointless to support.  It buys
almost nothing over PIO modes.  The condition to fall back to PIO is
very strict to prevent premature fall back.  I think it needs some
relaxation and special handling for cases where DMA transfer has never
succeeded after configuration so that it can fall back more easily.

> What is very strange also is that I can mount the NTFS drive just
> fine, and copy 70Mb of files off it (pretty nippily, I might add =D) -
> without any timeouts, but as soon as I tried to do something
> "lowlevel" to the disk (i.e. as you may have spotted, I used gparted
> to try and resize the NTFS partition, so I could try and run mkfs.ext3
> again - which was what caused the timeouts when I originally tried to
> install.

Hmmm.. it could be that the timeouts occur only on write or are
dependent on transfer size.  You should be able to find out what causes
the timeouts by playing with dd with 'direct' added to iflag and oflag.

> I can confirm that my chipset does indeed support UDMA, here is the
> hdparm -I report on my original disk:

Yeah, it's really difficult to come by a controller which doesn't
support UDMA these days.

> In regards to Windows performance: I have been using the tool HDTune
> to see which mode the device is in - and it reports Multiword DMA 2.
> Also, the benchmark facility with HDTune reveals that the burst speed
> of the drive is 2MB - consistent with the hdparm -t speed when
> ide-generic is used.
> 
> Strangely enough, I've gone into Device Manager, and the transfer mode
> Windows claims it is using is PIO, which seems to be contradictory to
> what HDTune is telling me (and leads me to ask another question, I've
> included in my reply to Alan) I've also tried to various registry
> settings to try and force the device into UDMA or PIO, to no success -
> as far as I can tell MWDMA may well be the lowest speed Windows XP
> supports operating devices at?

WXP uses PIO modes just fine.  I dunno how HDTune determines the current
transfer mode but if it uses IDENTIFY to query the device setting, it's
possible that the device reports MWDMA while the OS drives it in PIO
mode.  The best way to tell is watching cpu usage while transferring
data from the device.  If you're using mwdma, you won't see too high cpu
usage; otherwise, you'll notice high spikes during data transfer.  Can
you please try that and report?

Thanks.

-- 
tejun
