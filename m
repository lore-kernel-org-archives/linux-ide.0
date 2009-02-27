From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: ahci fails with SATA DVD drive, IDE mode works
Date: Fri, 27 Feb 2009 17:57:46 -0500
Message-ID: <20090227175746.44acdbfa@dhcp-100-2-144.bos.redhat.com>
References: <20090211174558.505354fe@dhcp-100-2-144.bos.redhat.com>
	<499D2202.7070503@kernel.org>
	<20090221181705.0b5f9ed3@dhcp-100-2-144.bos.redhat.com>
	<49A4DFD4.3030206@kernel.org>
	<20090225181530.1c575a30@dhcp-100-2-144.bos.redhat.com>
	<49A5EB45.6050202@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:35593 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbZB0W57 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Feb 2009 17:57:59 -0500
In-Reply-To: <49A5EB45.6050202@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Thu, 26 Feb 2009 10:07:17 +0900
Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> Chuck Ebbert wrote:
> >> How did it go?
> > 
> > I found another machine with the same chipset and a different ATAPI SATA
> > drive; that one works okay in ahci mode.
> 
> Well, there's no way all ICH9Ms are broken, so I'm afraid 'the same
> chipset' is a tad bit too wide unless it was the same board/machine.

The other machine has what seems to be a "real" SATA DVD writer in it.
It reports udma5 as the connect speed. This one seems to be a PATA drive
with an internal SATA bridge and is connecting as mwdma2.

> > There are no messages at all between "EH complete" and the string of SCSI
> > error messages:
> ...
> > ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> > ata2.00: cmd a0/01:00:00:00:02/00:00:00:00:00/a0 tag 0 dma 512 in
> >          cdb a1 08 2e 00 00 00 00 00  40 ec 00 00 00 00 00 00
> >          res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> > ata2.00: status: { DRDY }
> > ata2: hard resetting link
> > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > ata2.00: configured for MWDMA2
> > ata2: EH complete
> 
> Here, BLANK has timed out but the device was recovered okay.
> 

I ran 'hdparm -I' here. Why would it send BLANK to the drive??
(There was a 1.4 GB DVD-RW in the drive when I did that.)

Also there is no "applying bridge limits" message here when it resets
like there is when the system boots.

> > sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
> > sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current] 
> > sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range
> > end_request: I/O error, dev sr0, sector 0
> 
> And after that, the media can't be read, so this one seems normal.
> 

The media wasn't blanked -- rebooting lets me read it again.

Also, running 'hdparm -I' with no disk in the drive outputs:

/dev/sr0:
 HDIO_DRIVE_CMD(identify) failed: Invalid exchange

And strangely enough, I get the same message with a normal DVD disk in
the drive too...
