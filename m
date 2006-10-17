From: Ryan Richter <ryan@tau.solarneutrino.net>
Subject: Re: DVD drive not recognized on Intel G965 (2.6.19-rc2)
Date: Tue, 17 Oct 2006 19:50:40 -0400
Message-ID: <20061017235040.GA25185__23834.6152277247$1161134070$gmane$org@tau.solarneutrino.net>
References: <20061017180420.GD24789@tau.solarneutrino.net> <453533AB.9020801@argo.co.il> <1161124349.5014.12.camel@localhost.localdomain> <20061017222310.GA24891@tau.solarneutrino.net> <1161127585.5014.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from solarneutrino.net ([66.199.224.43]:23310 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1751172AbWJQXus (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Oct 2006 19:50:48 -0400
Content-Disposition: inline
In-Reply-To: <1161127585.5014.27.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Avi Kivity <avi@argo.co.il>, "Dr. David Alan Gilbert" <dave@treblig.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Oct 18, 2006 at 12:26:25AM +0100, Alan Cox wrote:
> Ar Maw, 2006-10-17 am 18:23 -0400, ysgrifennodd Ryan Richter:
> > 02:00.0 IDE interface: Marvell Technology Group Ltd. Unknown device 6101 (rev b1) (prog-if 8f [Master SecP SecO PriP PriO])
> > 	Subsystem: Marvell Technology Group Ltd. Unknown device 6101
> 
> That should work with libata and the newest driver version I posted (the
> earlier one won't handle the 6101 just 6145). You need at least rev
> 0.0.4t.

OK, now it's doing a little better.  It seems to recognize the
controller and drive, but it's not getting assigned a /dev/[sh]d? device
(it doesn't show up in /proc/diskstats, e.g.).  Here's the relevant
portion of dmesg:


ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:02:00.0 to 64
ata5: PATA max UDMA/100 cmd 0x1018 ctl 0x1026 bmdma 0x1000 irq 17
scsi4 : pata_marvell
BAR5:00:00 01:7F 02:22 03:CA 04:00 05:00 06:00 07:00 08:00 09:00 0A:00 0B:00 0C:01 0D:00 0E:00 0F:00 
ata5.00: ATAPI, max UDMA/33
ata5.00: applying bridge limits
ata5.00: configured for UDMA/33
scsi 4:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-H10N  JL10 PQ: 0 ANSI: 5
scsi 4:0:0:0: Attached scsi generic sg0 type 5

Thanks,
-ryan
