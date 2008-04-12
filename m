From: "Mike Snitzer" <snitzer@gmail.com>
Subject: Re: Western Digital GreenPower drives and Linux
Date: Fri, 11 Apr 2008 23:19:33 -0400
Message-ID: <170fa0d20804112019h73928c99paadcc363539fea9c@mail.gmail.com>
References: <234148243@web.de> <200804112200.28854.tvrtko@ursulin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:11377 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756815AbYDLDTe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Apr 2008 23:19:34 -0400
Received: by wf-out-1314.google.com with SMTP id 28so754616wff.4
        for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2008 20:19:33 -0700 (PDT)
In-Reply-To: <200804112200.28854.tvrtko@ursulin.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Cc: devzero@web.de, lkml@metanurb.dk, pernegger@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>

On Fri, Apr 11, 2008 at 5:00 PM, Tvrtko A. Ursulin <tvrtko@ursulin.net> wrote:
>
>  > >I got back from WD's tech support and received a DOS utility which can
>  > > control this drive feature, apparently using vendor specific commands.
>  > > With it head unload timer can be disabled or set to a period between
>  > > 100ms and 25.5s.
>
>  Followup with some good news.
>
>  Head unload timer settings seems to be persistent across powering off. Having
>  set it to a maximum value of 25.5 seconds my disk is now behaving much more
>  reasonable.
>
>  To actually do it I used FreeDOS floppy image burnt on a CD-RW as a bootable
>  image plus wdidle3.exe in the filesystem itself.
>
>  BTW, WD's tech support has gone silent so chances for an easier solution are
>  not so great.

Any chance you could make your iso available for the freedos w/
wdidle3.exe bootable cd?

I can't track down wdidle3.exe on wdc.com; they have "Data Lifeguard"
and such but I have no idea if the wdidle3.exe is buried in those
downloads.

thanks,
Mike
