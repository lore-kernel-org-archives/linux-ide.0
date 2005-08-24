From: Lukasz Kosewski <lkosewsk@gmail.com>
Subject: Re: [PATCH 3/3] Add disk hotswap support to libata RESEND #2
Date: Wed, 24 Aug 2005 22:03:05 +0800
Message-ID: <355e5e5e05082407031138120a@mail.gmail.com>
References: <355e5e5e05080103021a8239df@mail.gmail.com>
	 <4789af9e050823124140eb924f@mail.gmail.com>
	 <4789af9e050823154364c8e9eb@mail.gmail.com>
	 <430BA990.9090807@mvista.com> <430BCB41.5070206@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:28899 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750975AbVHXODG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Aug 2005 10:03:06 -0400
Received: by zproxy.gmail.com with SMTP id r28so64180nza
        for <linux-ide@vger.kernel.org>; Wed, 24 Aug 2005 07:03:05 -0700 (PDT)
In-Reply-To: <430BCB41.5070206@s5r6.in-berlin.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 8/24/05, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> >> Timers appear to operate in an atomic context, so timers should not be
> >> allowed to call scsi_remove_device, which eventually schedules.
> >>
> >> Any suggestions on the best way to fix this?
> >
> > Workqueue, perhaps.

Perhaps.  Actually, of course :)

The reason these aren't working is because they have never been
tested.  I sent in my not-entirely-finished patches the night before I
left for China for one month.

When I get back to Waterloo (Ontario) in September, I should send in
revised versions of these patches with the following fixes:

- mod_timer instead of delete_timer/change timeout/add_timer
- bunch of code cleanups
- proper error handling
- actually making the patches work.

For now, check the list archives for the very first send of the
patches (with a resend of patch #3), and use those.  Those patches do
not use a debounce timer, so can be prone to some failures.  However,
I wasn't able to get those failures while testing, so at least you can
help me test out the overall logic and robustness of my work.

Luke Kosewski
