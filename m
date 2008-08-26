From: "Grant Grundler" <grundler@google.com>
Subject: Re: SATA ALPM min_power causes > 10s delay on resume
Date: Mon, 25 Aug 2008 17:14:59 -0700
Message-ID: <da824cf30808251714na27f523r7a6155d5086b62b9@mail.gmail.com>
References: <1219598870.11057.2.camel@stinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:13153 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbYHZAPI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Aug 2008 20:15:08 -0400
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id m7Q0F1vU007122
	for <linux-ide@vger.kernel.org>; Tue, 26 Aug 2008 01:15:02 +0100
Received: from ug-out-1314.google.com (ugeu2.prod.google.com [10.66.172.2])
	by zps38.corp.google.com with ESMTP id m7Q0EXmG016155
	for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 17:15:00 -0700
Received: by ug-out-1314.google.com with SMTP id u2so666464uge.14
        for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 17:14:59 -0700 (PDT)
In-Reply-To: <1219598870.11057.2.camel@stinkpad>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Jeffrey W. Baker" <jwbaker@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, Aug 24, 2008 at 10:27 AM, Jeffrey W. Baker <jwbaker@gmail.com> wrote:
> I started using the min_power ALPM setting on my ThinkPad to save power
> (which works great, thanks!) but it causes a small problem.  When the
> machine resumes from suspend-to-ram it hangs for about 10s and then
> prints this on the console:
>
> ata1: COMRESET failed (errno=-16)
>
> It then proceeds normally.  The full messages are:
>
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/100
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: soft resetting link
> ata1: SATA link down (SStatus 611 SControl 300)
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: hard resetting link
> ata1: port is slow to respond, please be patient (Status 0x80)
> ata1: COMRESET failed (errno=-16)
> ata1: hard resetting link
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

Can you enable CONFIG_PRINTK_TIME in your kernel?

It sounds like the ahci driver is having problems spinning up
the disk after putting it into a "low power state" (which I
have no clue might be). Getting more accurate time
stamps might be a useful additional clue.

hth,
grant

>
> After which point the machine works normally.  The SATA controller is an
> Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) SATA AHCI Controller (rev
> 03) and the SATA target is a SAMSUNG MCBQE32G Rev: PS10.  The kernel is
> 2.6.24.  I haven't tried anything newer.
>
> If the ALPM setting is left at its default of max_performance then
> resume from suspend is instant.  Is there any way to work around this?
> ALPM is worth a solid 30 minutes of extra battery life, so obviously I'd
> like to use it.  If nothing else, it might be helpful to have a module
> parameter to shorten the timeout on known-working hardware.
>
> -jwb
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
