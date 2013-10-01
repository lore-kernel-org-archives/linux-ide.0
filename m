From: Tejun Heo <tj@kernel.org>
Subject: Re: ASM1061 freeze with DVDRW (3.11.1 amd64)
Date: Tue, 1 Oct 2013 10:39:24 -0400
Message-ID: <20131001143924.GC2736@htj.dyndns.org>
References: <20130927231346.GA5662@animx.eu.org>
 <CAPVzhpzqs4VM6v59+XD-eR4aeh0GskQgonXZXKMY2Wwq31CL7Q@mail.gmail.com>
 <20130928122013.GA26951@animx.eu.org>
 <CAPVzhpy-n9dS0Gogy5om60R5xcQ3Gf9Ws5Ba4GqLZRZ2bwv=cw@mail.gmail.com>
 <20130929031101.GD11789@animx.eu.org>
 <20130930192731.GA2703@htj.dyndns.org>
 <20131001015559.GC18206@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:43181 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab3JAOj1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Oct 2013 10:39:27 -0400
Received: by mail-qc0-f174.google.com with SMTP id n9so4742915qcw.5
        for <linux-ide@vger.kernel.org>; Tue, 01 Oct 2013 07:39:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131001015559.GC18206@animx.eu.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wakko Warner <wakko@animx.eu.org>
Cc: Reartes Guillermo <rtguille@gmail.com>, linux-ide@vger.kernel.org, Kay Sievers <kay@vrfy.org>

(cc'ing Kay)

Kay, udev *could* be a part of the issue.  The original thread can be
read from

  http://thread.gmane.org/gmane.linux.ide/55284

On Mon, Sep 30, 2013 at 09:55:59PM -0400, Wakko Warner wrote:
> Please keep me in CC.

That's the norm.  Everybody is supposed to reply-to-all here.  No need
to worry about that.

> > Misbehaving controllers can hang machine without any software way to
> > recover from it.  It could just hang in the middle of memory
> > transaction.  Unless PCI bridge aborts it with timeout, the only way
> > the system can get out of there is hard reset.  Unfortunately,
> > controllers misbehaving this way weren't too uncommon way back with
> > controllers with taskfile based interface.  Nowadays, it mostly
> > disappeared but we apparently have one here.
> 
> Does it matter if it's PCIe?

PCI tends to be worse probably because it's easier to get lost while
literally holding the bus but I'm sure there are multiple ways to
screw the whole system on pcie too.

> Since hard drives and optical drives are all I have, I can't test anything
> else.  I can try another optical drive, but it appears that others have the
> same problem with optical drives on this controller.  Hard drives do not
> have any problems on this controller.
> 
> If I add libata.atapi_passthru16=0 (as mentioned by another), I do not have
> any errors and I can use the drive w/o problems.  I burned and verified a
> disc on this controller with this parameter set to 0.  I'm not sure if a
> quirk can be added for this controller or not.  Seems that this disables for
> all libata controllers.  I'm not sure what the impact would be though.

Apparently, a command issued through SCSI passthrough from udev and
its minions is upsetting the device / controller, which then enters a
very catastrophic failure mode.  From the log, it looks like it's
IDENTIFY_PACKET_DEVICE but it'd be interesting if we can actually
isolate issuance of the single failing command.  It could be that the
userland is issuing something slightly off which usually works okay
but not for this one, or it could be the kernel passthrough code
failing to handle some command bits or alignment properly.

Do you happen to have a different optical drive?  It'd be interesting
to find out whether the problem is independent of the drive.

Thanks.

-- 
tejun
