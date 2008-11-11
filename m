From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: Bug 11581
Date: Tue, 11 Nov 2008 08:11:07 +0100
Message-ID: <20081111071107.GB31576@gollum.tnic>
References: <Pine.LNX.4.64.0810141314590.2555@cantor.unex.es> <9ea470500810140453m6e1f7eb6raf179ee78414e19e@mail.gmail.com> <Pine.LNX.4.64.0810141709450.4529@cantor.unex.es> <20081026154657.GA2578@gollum.tnic> <Pine.LNX.4.64.0810281202010.24944@cantor.unex.es> <20081110063443.GA17946@gollum.tnic> <Pine.LNX.4.64.0811101258580.12415@cantor.unex.es>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:25478 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbYKKHLO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Nov 2008 02:11:14 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2617247fgg.17
        for <linux-ide@vger.kernel.org>; Mon, 10 Nov 2008 23:11:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0811101258580.12415@cantor.unex.es>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Santiago Vila <sanvila@unex.es>
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

On Mon, Nov 10, 2008 at 01:02:02PM +0100, Santiago Vila wrote:
> On Mon, 10 Nov 2008, Borislav Petkov wrote:
> 
> > Ok, so it looks like your drive gets puzzled again by a
> > GET_CONFIGURATION command despite 2.6.18 which used to work, as you say.
> > But I think it fails this time because you've updated to debian testing
> > and, correct me if I'm wrong, but the udev utility cdrom_id came with
> > the update and it sends all those GET_CONFIGURATION commands. Have you
> > thought of updating the drive's firmware - that helps sometimes?
> 
> Ok, I tried that today, using Wine and the root account, but the unit
> is not detected by the firmware updating utility. Which of the multiple
> patched kernels should I try? Neither 2.6.18 or 2.6.26 from Debian
> seem to work this time.

I'm afraid that you need to boot into Windoze in order for the firmware
update utility to recognize your drive. I'm pretty sure there are some
ways to that without windows but they could be risky and damage your
drive permanently. I'll think of something better and get back to you.

-- 
Regards/Gruss,
    Boris.
