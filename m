From: "Jeffrey W. Baker" <jwbaker@gmail.com>
Subject: Re: SATA ALPM min_power causes > 10s delay on resume
Date: Mon, 25 Aug 2008 21:04:55 -0700
Message-ID: <1219723495.19838.1.camel@stinkpad>
References: <1219598870.11057.2.camel@stinkpad>
	 <da824cf30808251714na27f523r7a6155d5086b62b9@mail.gmail.com>
	 <1219720475.18172.3.camel@stinkpad>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:4153 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbYHZEE6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2008 00:04:58 -0400
Received: by wa-out-1112.google.com with SMTP id j37so817844waf.23
        for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 21:04:57 -0700 (PDT)
In-Reply-To: <1219720475.18172.3.camel@stinkpad>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-ide@vger.kernel.org

On Mon, 2008-08-25 at 20:14 -0700, Jeffrey W. Baker wrote:
> On Mon, 2008-08-25 at 17:14 -0700, Grant Grundler wrote:
> > On Sun, Aug 24, 2008 at 10:27 AM, Jeffrey W. Baker <jwbaker@gmail.com> wrote:
> > > I started using the min_power ALPM setting on my ThinkPad to save power
> > > (which works great, thanks!) but it causes a small problem.  When the
> > > machine resumes from suspend-to-ram it hangs for about 10s and then
> > > prints this on the console:
> > >
> > > ata1: COMRESET failed (errno=-16)
> > >
> > > It then proceeds normally.  The full messages are:
> > >
> > > ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > > ata1.00: configured for UDMA/100
> > > ata1: failed to recover some devices, retrying in 5 secs
> > > ata1: soft resetting link
> > > ata1: SATA link down (SStatus 611 SControl 300)
> > > ata1: failed to recover some devices, retrying in 5 secs
> > > ata1: hard resetting link
> > > ata1: port is slow to respond, please be patient (Status 0x80)
> > > ata1: COMRESET failed (errno=-16)
> > > ata1: hard resetting link
> > > ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > 
> > Can you enable CONFIG_PRINTK_TIME in your kernel?
> 
> Output follows ...
> 
> > It sounds like the ahci driver is having problems spinning up
> > the disk after putting it into a "low power state" (which I
> > have no clue might be). Getting more accurate time
> > stamps might be a useful additional clue.
> 
> The disk is an SSD so there's no need for delay to allow it to spin
> up.

I just did an experiment, and a workaround for this problem is to enable
max_performance immediately before sleep and return to min_power during
resume.

-jwb

