From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Tue, 05 Aug 2008 16:49:47 +0900
Message-ID: <4898061B.6010406@gmail.com>
References: <fa.nx0yFPJm+aNXPHgykUrOzZXvvIs@ifi.uio.no> <fa.NfEr7Ik6e8oextyWICW/jR5emeE@ifi.uio.no> <fa.zGvATZImeUo0tHJe4hzlk5+mTiM@ifi.uio.no> <4897D433.5040409@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:64016 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbYHEHuY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 03:50:24 -0400
Received: by ti-out-0910.google.com with SMTP id b6so669053tic.23
        for <linux-ide@vger.kernel.org>; Tue, 05 Aug 2008 00:50:22 -0700 (PDT)
In-Reply-To: <4897D433.5040409@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Elias Oltmanns <eo@nebensachen.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Robert Hancock wrote:
>> However, SATA or not, there simply isn't a way to abort commands in ATA.
>>  Issuing random command while other commands are in progress simply is
>> state machine violation and there will be many interesting results
>> including complete system lockup (ATA controller dying while holding the
>> PCI bus).  The only reliable way to abort in-flight commands are by
>> issuing hardreset.  However, ATA reset protocol is not designed for
>> quick recovery.  The machine is gonna hit the ground hard way before the
>> reset protocol is complete.
> 
> How long does hardreset have to take? I only see a 1ms delay in the
> COMRESET process (sata_link_hardreset). I'd think it would be feasible
> to do something like:
> 
> -stop the queue to prevent new commands from being issued
> -wait a certain amount of time (20ms or so?) for existing command(s) to
> complete, if they do then issue the idle command
> -if time runs out, trigger a hardreset and then issue the idle command
> 
> The drive is going to take a little while to actually unload the heads
> anyway, so a few milliseconds delay doesn't seem like a big deal..

Two major areas of delays are...

- Post-hardreset PHY readiness delay.  It depends on both the controller
and drive.  Some combination might take pretty short while there are
combinations which are known to take in the order of few seconds.  It's
determined by sata_deb_timing_* arrays in libata-core.c.  In most cases,
sata_deb_timing_normal works fine.  Currently, sil24 needs the long
variant.  Using the normal one, the shortest possible timing would be a
bit above 100ms as libata determines PHY is online only after the link
state hasn't oscillate for that long.

- Device readiness (the initial TF w/ signature).  It depends on how the
drive implementation.  If the drive is spinning, it's usually pretty
quick but there's no guarantee.  Also, there's another problem that some
controllers just can't wait for device readiness after hardreset and
thus needs to perform softreset after hard one, which adds to the delay.

Missing either of the above two can jam the reset sequence forcing a
retry.  It might work with some combinations of devices but given that
we wouldn't get too much test coverage I don't really think the overhead
and risk are justifiable.

>> The only way to solve this nicely is either to build the accelerometer
>> into the drive and let the drive itself protect itself or implement a
>> sideband signal to tell it to duck for cover.  For SATA, this sideband
>> signal can be another OOB sequence.  If it's ever implemented this way,
>> it will be in SControl, I guess.
>>
>> Well, short of that, all we can do is to wait for the currently
>> in-flight commands to drain and hope that it happens before the machine
>> hits the ground.  Also, that the harddrive is not going through one of
>> the longish EH recovery sequences when it starts to fall.  :-(
> 
> Well, Lenovo (and others?) have implemented this in Windows somehow.. It
> would be interesting to know what solution they used there (either
> hardreset, issue the command even when busy, or just wait for the
> commands to hopefully finish in time).

I think just waiting till the currently pending commands are complete
and then issuing IDLE_IMMEDIATE would cover most of the cases.  Longer
term, I really think there needs to be an out-of-band signal if this is
gonna get done right.

-- 
tejun
