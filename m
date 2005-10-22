From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: command error: error=0x54 { AbortedCommand LastFailedSense=0x05
 }
Date: Sat, 22 Oct 2005 08:33:03 +0200
Message-ID: <4359DD1F.9010507@gmx.de>
References: <435994C2.6090701@ravelox.co.uk>
Reply-To: linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.de ([213.165.64.20]:31452 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751298AbVJVGdP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Oct 2005 02:33:15 -0400
In-Reply-To: <435994C2.6090701@ravelox.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Kelly <dave@ravelox.co.uk>
Cc: linux-ide@vger.kernel.org

Dave Kelly wrote:
> Hi,
> 
> I originally sent this to linux-kernel but it may have got lost in the
> number of messages.
> 
> I have a large number of CD-Rs that I burned using Nero under Windows on
> a CD writer that I no longer have ( and can't remember the model ). I'm
> now having problems reading them with my Sony DRU-810A DVD+/-RW drive
> using 2.6.13.4.

forget 2.6.13.4, wait for patches, it has countless bugs. complain about
reading? try to burn something... kde+k3b lock up for 5 min. intervalls
with cdrecord/cdrdao as root at full load with ide-cd. will test
ide-scsi next, depreceated or not.

and nvidia ide is new stuff, isnt it?

> 
> /var/log/messages starts to fill with:
> 
> Oct 15 02:30:03 desktop kernel: end_request: I/O error, dev hdc, sector
> 5028
> Oct 15 02:30:03 desktop kernel: hdc: command error: status=0x51 {
> DriveReady SeekComplete Error }
> Oct 15 02:30:03 desktop kernel: hdc: command error: error=0x54 {
> AbortedCommand LastFailedSense=0x05 }

> Oct 15 02:30:03 desktop kernel: ide: failed opcode was: unknown
> 
(busmaster dma transfer?)

try disabling dma and/or try the ide-scsi driver and report

> /dev/hdc:
> 
>  Model=SONY DVD RW DRU-810A, FwRev=1.0a, SerialNo=815005574810A U30507

this is a lite-on OEM? got a SOHW-832 reporting some "drive confused"
messages but no problems with reading, maybe nvidia driver code bugs.

latest stable manufacturer firmware on the drive? use such rpc-1 cracks
on your own risk.

> Cheers
> 
> Dave

y
tom
