From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problems with Linux SATA driver and ARC-770 IDE Bridge chip
Date: Tue, 01 May 2007 08:01:50 +0200
Message-ID: <4636D7CE.9070702@gmail.com>
References: <5760903.1177441381244.JavaMail.root@wombat.diezmil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:44510 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423456AbXEAGDI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2007 02:03:08 -0400
Received: by an-out-0708.google.com with SMTP id b33so1524912ana
        for <linux-ide@vger.kernel.org>; Mon, 30 Apr 2007 23:03:07 -0700 (PDT)
In-Reply-To: <5760903.1177441381244.JavaMail.root@wombat.diezmil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sjackerman@comcast.net
Cc: linux-ide@vger.kernel.org, cmetz@inner.net, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, albertcc@tw.ibm.com

[cc'ing ATA gurus]
Hello, again.

Okay, there are two different problems here, so I was confused a bit,
but now I see what's going on.

sjackerman@comcast.net wrote:
> ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 10
> scsi2 : ata_piix
> ata1.00: CFA, max PIO4, 8005536 sectors: LBA
> ata1.00: ata1: dev 0 multi count 0
> ata1.00: qc timeout (cmd 0xef)
> ata1.00: failed to set xfermode (err_mask=0x4)
> ata1.00: limiting speed to PIO3
> ata1: failed to recover some devices, retrying in 5 secs
> ata1.00: qc timeout (cmd 0xef)
> ata1.00: failed to set xfermode (err_mask=0x4)
> ata1.00: limiting speed to PIO0
> ata1: failed to recover some devices, retrying in 5 secs
> ata1.00: qc timeout (cmd 0xef)
> ata1.00: failed to set xfermode (err_mask=0x4)
> ata1.00: disabled
> scsi3 : ata_piix
> ATA: abnormal status 0x7F on port 0xE407
>
> You can see that that our ARC-770 based adaptor with 4GB Sandisk CF
> card failed to respond to the ATA Identify command. However the
> BIOS, DOS and Windows can identify and use this same CF card and
> adaptor. The same CF card placed into a no-name adaptor that uses a
> Marvell 88SA8040 bridge chip works with no problems.

Command 0xef is not IDENTIFY, it's SETFEATURES. libata is trying to
configure transfer mode but the device isn't responding.  In the above
case, the device has successfully executed IDENTIFY but timed out on
SETXFERMODE.  It's okay for CFA devices to not implement SETXFERMODE
but it's supposed to abort the command not timeout on it.  Can you
please ask Acard about this too?

> Here is the customer's error attempting the same thing but on an Intel
> 875 based chipset:
>
> ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> scsi0 :
> ata_piix
> ATA: abnormal status 0x7F on port 0xC007
> scsi1 : ata_piix
> ata2: port is slow to respond, please be patient (Status 0xd0)
> ata2: port failed to respond (30 secs, Status 0xd0)
> ATA: abnormal status 0xD0 on port 0xC807
> ATA: abnormal status 0xD0 on port 0xC807
> ATA: abnormal status 0xD0 on port 0xC807
> ATA: abnormal status 0xD0 on port 0xC807
> ATA: abnormal status 0xD0 on port 0xC807
> ata2.00: qc timeout (cmd 0xec)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata2: port is slow to respond, please be patient (Status 0xd0)
> ata2: port failed to respond (30 secs, Status 0xd0)
> ATA: abnormal status 0xD0 on port 0xC807
> ATA: abnormal status 0xD0 on port 0xC807
> ATA: abnormal status 0xD0 on port 0xC807
> ATA: abnormal status 0xD0 on port 0xC807
> ATA: abnormal status 0xD0 on port 0xC807
> ata2.00: qc timeout (cmd 0xec)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata2: port is slow to respond, please be patient (Status 0xd0)
> ata2: port failed to respond (30 secs, Status 0xd0)
>
> According to the Acard technology support engineer who evaluated the
problem:
>
>  "Intel chipset assigns an "nIEN (interrupt)" value 1 (disable),
> which is not compliant with SATA spec, and causes device failure.
> Marvell chip has been revised for several versions, and it does
> something to ignore this assignment since a certain revision, prior
> to the directives of SATA authority.  That's why Marvel chip works
> regardless of MB chipset.  However, In ACARD, we follow the
> directives and spec from SATA authority, unless we receive the
> notification, we won't do anything against the rules."

Where does the SATA spec says it's okay to timeout when nIEN is set?
>From ATA8-AST section 7.5.1,

  N Variable. In ATA/ATAPI-7 parallel emulation, this bit corresponds to
        the nIEN bit. The bit is not used in the serial transport, and
        may be transmitted with a zero or a one value. It is
        recommended that it be cleared to zero.

It specifically says "_may_ be transmitted with a zero or a one value"
and not recommending setting this bit is very new thing.  In SATA,
raising an interrupt is the ATA controller's responsibility whears in
PATA it was the device's.  That's why it's meaningless at the SATA
_TRANSPORT_ level because an ATA device doens't and can't care whether
the controller raises interrupt for command completion or not.

But the bit still matters between the ATA controller and the host.
It's the only IRQ mask bit in the interface.  Actually, ATA8-AST talks
exactly about this in annex E.4 and how this transfer of IRQ masking
responsibility should be handled and what problems may arise from it.
The device can ignore nIEN and just set IRQ bit and the controller is
recommended to clear nIEN when transmitting command FIS but earlier
chips do transmit the bit as is.  Note that the implementation detail
is between the controller and the device.  That's why it's described
in AST not in ACS.  ie. The whole thing must be transparent to the
device driver.  After all, the whole idea is to emulate SFF PATA.

IN NO CASE, the device is allowed to timeout on a command because nIEN
is set.  I'm sorry but that's simply a broken device.

With all due respect, anyone who has the flimsiest idea about how SFF
interface works and how SATA command layer protocol descended from it
would know how broken it is to timeout on commands because it has nIEN
set.  I usually try not to rant but it's really frustrating because
this brokenness is whole new and means that we can't have any IRQ
masking on some controllers if we're gonna support this device, on top
of missing reliable IRQ pending bit.

> I have asked for additional clarification from Acard, but it has not
>  been forthcoming.
>
> In attempting to resolve this for our Linux customers, I sent an
> e-mail to Greg K-H in response to his Free Linux Driver
> Announcement:
>
> http://www.kroah.com/log/linux/free_drivers.html
>
> Greg responded and suggested that I post a request for assistance
> on this mailing list, so here it is.

Yeap, you've contacted the right place.

> I would be willing to supply one of our adaptors and a CF card to
> someone who can revise the driver to work with the Acard ARC-770 and
> have the corrected driver included in future Linux releases.

Yes, please.  The CF reader now looks far more interesting after
knowing how weirdly broken it is.  :-)

Jeff, Alan, Mark and Albert, do you have ideas how we should support
this one?  This thing locks up if nIEN is set in command FIS.  For
ahci and sata_sil24, we can and probably should stop setting nIEN when
polling, but what are we gonna do with all the SFF controllers?  I can
think of some dirty hacks along the line of polling with IRQ enabled
but I would love to be enlightened with something cleaner.

Thanks.

-- 
tejun
