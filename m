From: "Jeffrey W. Baker" <jwbaker@gmail.com>
Subject: Re: SATA ALPM min_power causes > 10s delay on resume
Date: Mon, 25 Aug 2008 20:14:35 -0700
Message-ID: <1219720475.18172.3.camel@stinkpad>
References: <1219598870.11057.2.camel@stinkpad>
	 <da824cf30808251714na27f523r7a6155d5086b62b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:2069 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640AbYHZDOh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Aug 2008 23:14:37 -0400
Received: by wa-out-1112.google.com with SMTP id j37so811199waf.23
        for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 20:14:37 -0700 (PDT)
In-Reply-To: <da824cf30808251714na27f523r7a6155d5086b62b9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-ide@vger.kernel.org

On Mon, 2008-08-25 at 17:14 -0700, Grant Grundler wrote:
> On Sun, Aug 24, 2008 at 10:27 AM, Jeffrey W. Baker <jwbaker@gmail.com> wrote:
> > I started using the min_power ALPM setting on my ThinkPad to save power
> > (which works great, thanks!) but it causes a small problem.  When the
> > machine resumes from suspend-to-ram it hangs for about 10s and then
> > prints this on the console:
> >
> > ata1: COMRESET failed (errno=-16)
> >
> > It then proceeds normally.  The full messages are:
> >
> > ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > ata1.00: configured for UDMA/100
> > ata1: failed to recover some devices, retrying in 5 secs
> > ata1: soft resetting link
> > ata1: SATA link down (SStatus 611 SControl 300)
> > ata1: failed to recover some devices, retrying in 5 secs
> > ata1: hard resetting link
> > ata1: port is slow to respond, please be patient (Status 0x80)
> > ata1: COMRESET failed (errno=-16)
> > ata1: hard resetting link
> > ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> 
> Can you enable CONFIG_PRINTK_TIME in your kernel?

Output follows ...

> It sounds like the ahci driver is having problems spinning up
> the disk after putting it into a "low power state" (which I
> have no clue might be). Getting more accurate time
> stamps might be a useful additional clue.

The disk is an SSD so there's no need for delay to allow it to spin up.
Here are the messages from a normal resume, pipe grep ata:

[    0.699797] ata5: port disabled. ignoring.
[    2.028774] ata3: SATA link down (SStatus 0 SControl 300)
[    2.028792] ata2: SATA link down (SStatus 0 SControl 0)
[    2.192670] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.193535] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 succeeded
[    2.193537] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
[    2.194998] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 succeeded
[    2.195381] ata1.00: configured for UDMA/100
[    2.209049] ata1.00: configured for UDMA/100
[    2.209051] ata1: EH complete

And here are the messages on a slow resume:

[    0.700191] ata5: port disabled. ignoring.
[    2.029795] ata2: SATA link down (SStatus 0 SControl 0)
[    2.029814] ata3: SATA link down (SStatus 0 SControl 300)
[    2.193770] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.194631] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 succeeded
[    2.194634] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
[    2.196161] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 succeeded
[    2.196545] ata1.00: configured for UDMA/100
[    2.197289] ata1: failed to recover some devices, retrying in 5 secs
[    3.644507] ata1: soft resetting link
[    3.644518] ata1: SATA link down (SStatus 611 SControl 300)
[    3.644530] ata1: failed to recover some devices, retrying in 5 secs
[    4.430864] ata1: hard resetting link
[    5.298009] ata1: port is slow to respond, please be patient (Status 0x80)
[    6.010843] ata1: COMRESET failed (errno=-16)
[    6.010847] ata1: hard resetting link
[    6.085653] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    6.086267] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 succeeded
[    6.086269] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
[    6.086380] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 succeeded
[    6.087124] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 succeeded
[    6.087128] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
[    6.087350] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 succeeded
[    6.087550] ata1.00: configured for UDMA/100
[    6.088119] ata1.00: configured for UDMA/100
[    6.088122] ata1: EH complete

I don't know how accurate these times are supposed to be.  On my
wallclock it takes substantially more than 6 seconds.

-jwb

