From: Borislav Petkov <bp@alien8.de>
Subject: Re: Possible bug in ide_cd_queue_pc() or ide_wait_stat() ?
Date: Thu, 29 Jul 2010 10:12:02 +0200
Message-ID: <20100729081202.GA22980@liondog.tnic>
References: <4C500A82.2040805@citrix.com>
 <20100728115107.GA1690@a1.tnic>
 <4C504B61.4050409@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:41972 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753914Ab0G2IMH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jul 2010 04:12:07 -0400
Content-Disposition: inline
In-Reply-To: <4C504B61.4050409@citrix.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dominic Curran <dominic.curran@citrix.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

From: Dominic Curran <dominic.curran@citrix.com>
Date: Wed, Jul 28, 2010 at 04:23:13PM +0100

> Borislav Petkov wrote:
> >>I have some TEAC DV-28E-V CDROM drives that after polling for status
> >>starts to timeout requests (the time it takes to do this varies
> >>between 5mins and 24hrs).
> >
> >Which kernel is that? Can we see a complete dmesg? Which tool does the
> >polling (udev... )?
> >
> We have cooked our own usermode tool (we dont use udev).
> Tool is very simple:
> 1) polls cdrom drive using ioctl CDROM_DRIVE_STATUS
> 2) Looks for a CDS_DISC_OK return
> 3) Once it sees that it tries to mount CD
> 
> The problem is that for this specific drive it starts timing out
> STATUS requests, and then returns CDS_DISC_OK.
> This cause the tools to try to mount (non existent disc), which then
> eats 100% cpu time.
> 
> So even if the drive goes bad, I'd like to get back a error status
> from the ioctl rather than CDS_DISC_OK.

Right, I think I see the issue after staring at your instrumentation
below and the code, however...

> Kernel is 2.6.27.  Based on CentOS I believe.

this is an awfully old kernel and Bart and I broke^W (cough) changed a
lot (cough) :) in ide since then so I'd like to verify your issue with a
recent kernel first (current 35-rc6 is stable enough, it seems) before
we get on with debugging it further.

Thanks.

-- 
Regards/Gruss,
    Boris.
