From: Tejun Heo <htejun@gmail.com>
Subject: Re: [smartmontools-support] inactive SATA drives won't stay in standby
 or sleep, PATA models did. (fwd)
Date: Mon, 13 Oct 2008 16:08:20 +0900
Message-ID: <48F2F3E4.4030800@gmail.com>
References: <D73D40172004714D95D7A84AC3E68EC802282133@wdscexbe03.sc.wdc.com>	<48EBFE9B.9070503@gmail.com>	<18674.4081.839329.116533@harpo.it.uu.se>	<48F2D9A8.1030502@gmail.com> <18674.62170.845285.407281@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:31527 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbYJMHJw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 03:09:52 -0400
Received: by ti-out-0910.google.com with SMTP id b6so809306tic.23
        for <linux-ide@vger.kernel.org>; Mon, 13 Oct 2008 00:09:50 -0700 (PDT)
In-Reply-To: <18674.62170.845285.407281@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Christian Mueller <Christian.Mueller@wdc.com>, Bruce Allen <ballen@gravity.phys.uwm.edu>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mikael Pettersson wrote:
> Tejun Heo writes:
>  > > - hardreset in sata_promise seems broken. I'll take a closer look
>  > >   at that in about a week's time (I'll be busy with other work the
>  > >   next couple of days).
>  > 
>  > This looks like a rather serious problem, so please take a look at
>  > this.  Also, after the drive went down, does unplugging and replugging
>  > the signal cable fix the problem, if not does doing the same thing
>  > with the power cable make any difference?
> 
> I couldn't bring the port back up with any combination of signal/power
> cable hotplugging.

Heh.. that rules out drive firmware stuck in wonderland.

> Even rmmod sata_promise; modprobe sata_promise failed to bring the
> port back up. Hence my suspicion that hardreset is borked or doesn't
> kick in.

It looks like the controller requires harder or more proper kick in
the ass to return to sane state.  :-)

-- 
tejun
