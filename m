From: Wakko Warner <wakko@animx.eu.org>
Subject: Re: ASM1061 freeze with DVDRW (3.11.1 amd64)
Date: Mon, 30 Sep 2013 21:55:59 -0400
Message-ID: <20131001015559.GC18206@animx.eu.org>
References: <20130927231346.GA5662@animx.eu.org>
 <CAPVzhpzqs4VM6v59+XD-eR4aeh0GskQgonXZXKMY2Wwq31CL7Q@mail.gmail.com>
 <20130928122013.GA26951@animx.eu.org>
 <CAPVzhpy-n9dS0Gogy5om60R5xcQ3Gf9Ws5Ba4GqLZRZ2bwv=cw@mail.gmail.com>
 <20130929031101.GD11789@animx.eu.org>
 <20130930192731.GA2703@htj.dyndns.org>
Reply-To: Wakko Warner <wakko@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tn-76-7-162-101.sta.embarqhsd.net ([76.7.162.101]:50660 "EHLO
	animx.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755208Ab3JAB4F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Sep 2013 21:56:05 -0400
Content-Disposition: inline
In-Reply-To: <20130930192731.GA2703@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Reartes Guillermo <rtguille@gmail.com>, linux-ide@vger.kernel.org

Please keep me in CC.

Tejun Heo wrote:
> Hey, guys.
> 
> On Sat, Sep 28, 2013 at 11:11:01PM -0400, Wakko Warner wrote:
> > [  493.612957] ata4.00: detaching (SCSI 3:0:0:0)
> > [  516.314095] ata7.00: exception Emask 0x52 SAct 0x0 SErr 0xffffffff action 0xe frozen
> > [  516.314699] ata7: SError: { RecovData RecovComm UnrecovData Persist Proto HostInt PHYRdyChg PHYInt CommWake 10B8B Dispar BadCRC Handshk LinkSeq TrStaTrns UnrecFIS DevExch }
> 
> That's the controller going bonkers - all SErr bits are set.  It's not
> functioning correctly anymore.

I noticed there were alot of bits there, I didn't know that it was every one
of them.

> > [  516.315939] ata7.00: failed command: IDENTIFY PACKET DEVICE
> > [  516.316567] ata7.00: cmd a1/00:01:00:00:00/00:00:00:00:00/00 tag 0 pio 512 in
> > [  516.316567]          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x56 (ATA bus error)
> > [  516.317794] ata7.00: status: { DRDY }
> > [  516.318407] ata7: hard resetting link
> 
> On non other than IDENTIFY.

Honestly, I didn't pay any attention to this part.

> > Once this last line was printed, pings stopped working.  Computer was
> > completely frozen.  Keyboard lock keys won't toggle either.  SYSRQ non
> > functional.
> 
> Misbehaving controllers can hang machine without any software way to
> recover from it.  It could just hang in the middle of memory
> transaction.  Unless PCI bridge aborts it with timeout, the only way
> the system can get out of there is hard reset.  Unfortunately,
> controllers misbehaving this way weren't too uncommon way back with
> controllers with taskfile based interface.  Nowadays, it mostly
> disappeared but we apparently have one here.

Does it matter if it's PCIe?

> It could be a combination of bugs on the controller and the optical
> drive and there probably are some workarounds which can avoid it -
> avoid certain command sequence, take certain special steps during
> recovery, etc.  A good starting point would be finding out which
> command from udev makes it go bonkers and see whether we can avoid
> that.

Since hard drives and optical drives are all I have, I can't test anything
else.  I can try another optical drive, but it appears that others have the
same problem with optical drives on this controller.  Hard drives do not
have any problems on this controller.

If I add libata.atapi_passthru16=0 (as mentioned by another), I do not have
any errors and I can use the drive w/o problems.  I burned and verified a
disc on this controller with this parameter set to 0.  I'm not sure if a
quirk can be added for this controller or not.  Seems that this disables for
all libata controllers.  I'm not sure what the impact would be though.

-- 
 Microsoft has beaten Volkswagen's world record.  Volkswagen only created 22
 million bugs.
