From: Tejun Heo <tj@kernel.org>
Subject: Re: Long delay when booting with SATA DVD on Marvell 88SE6121
Date: Mon, 31 Aug 2009 23:02:07 +0900
Message-ID: <4A9BD7DF.8030606@kernel.org>
References: <20090817002918.GA2805@gozer.dminteractive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57626 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbZHaOCM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Aug 2009 10:02:12 -0400
In-Reply-To: <20090817002918.GA2805@gozer.dminteractive.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Hokenson <logan+kernel@gozer.org>
Cc: linux-ide@vger.kernel.org

Mike Hokenson wrote:
> Hi list,
> 
> I've got a MSI P35 Platinum with a Marvell 88SE6121 (one PATA, one SATA)
> controller and when I have a SATA DVD drive connected to the port, my
> system takes a good 30+ seconds longer to boot. The HDD activity LED is
> solid the whole time and I see a series of messages like this:
> 
> [    6.312129] ata2.00: qc timeout (cmd 0xa1)
> [    6.312135] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   11.352006] ata2: link is slow to respond, please be patient (ready=0)
> [   16.336009] ata2: device not ready (errno=-16), forcing hardreset
> [   21.532007] ata2: link is slow to respond, please be patient (ready=0)
> [   26.348009] ata2: SRST failed (errno=-16)
> [   31.544008] ata2: link is slow to respond, please be patient (ready=0)
> [   36.360014] ata2: SRST failed (errno=-16)
> [   36.544307] ata2.00: ATAPI: ASUS    DRW-2014L1T, 1.02, max UDMA/66
> [   36.560317] ata2.00: configured for UDMA/66
> [   36.576547] scsi 1:0:0:0: CD-ROM            ASUS     DRW-2014L1T     
> 1.02 PQ: 0 ANSI: 5
> 
> And then the system boots normally. I don't have any problems reading or
> writing and I've seen the same issues with another DVD drive. However,
> there are some messages that appear when writing a disc (from an older
> /var/log/messages):
> 
> [2136249.058984] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
> driverbyte=DRIVER_SENSE
> [2136249.058987] sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current]
> [2136249.058990] sr 1:0:0:0: [sr0] Add. Sense: Logical block address out
> of range
> [2136249.059891] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
> driverbyte=DRIVER_SENSE
> [2136249.059893] sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current]
> [2136249.059896] sr 1:0:0:0: [sr0] Add. Sense: Logical block address out
> of range
> 
> These messages don't really concern me, because the discs always test
> fine. The only reason I mention it is in case there's some relation to
> the first issue.
> 
> The slow boot issue doesn't occur when I'm using my Intel ICH9R
> controller (not sure anymore about the errors while writing), but all 4
> ports are now in use by hard drives and I'd like to keep them on the
> ICH9R since the controller has been rock solid. This has been happening
> for as long as I've had this motherboard - January of 2008. It's more of
> a nuisance than anything else..
> 
> I'm not sure if there's an option I could pass to the libata module to
> help with issues on this port, forcing a specific mode or speed or
> something, but I thought I'd ask.

"libata.force=2:udma33" would force it to udma/33 but I don't think
that would be the problem here.  IDENTIFY doesn't use udma anyway.
Does the problem go away if you do "libata.force=2:pio0"?

Thanks.

-- 
tejun

