From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Problem with PCMCIA IDE
Date: Thu, 22 Nov 2007 23:14:58 +0100
Message-ID: <200711222314.58742.bzolnier@gmail.com>
References: <20071118202309.GE15355@shallowsky.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:57239 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549AbXKVWHY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Nov 2007 17:07:24 -0500
Received: by ug-out-1314.google.com with SMTP id z38so409665ugc
        for <linux-ide@vger.kernel.org>; Thu, 22 Nov 2007 14:07:23 -0800 (PST)
In-Reply-To: <20071118202309.GE15355@shallowsky.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akkana Peck <akkana@shallowsky.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Sunday 18 November 2007, Akkana Peck wrote:
> I've been having problems getting PCMCIA IDE to work on my Vaio
> laptop on recent kernels (I've been working most with 2.6.23.1 and
> .8). I've been hesitant to report it as a kernel bug because it
> may very well be a problem with my .config parameters -- the CDROM
> worked in distro kernels back around 2.6.17 and .18, and self-built
> kernels even earlier than that, but the configuration has changed
> quite a bit since then so it's hard to compare directly and figure
> out if I'm missing something.

[...]

Is the problem still present in 2.6.24-rc3?

It would greatly help if you could narrow it down to the specific
commit which introduced the bug (using git-bisect), or (for a start)
to a specific kernel version.

Thanks,
Bart
