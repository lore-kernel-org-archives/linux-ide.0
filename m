From: TAKADA Yoshihito <takada@mbf.nifty.com>
Subject: Re: kernel 2.6.25 with ide driver cs5520 does not boot.
Date: Fri, 09 May 2008 21:56:01 +0900 (JST)
Message-ID: <20080509.215601.208967867.takada@mbf.nifty.com>
References: <58cb370e0805080607n4f5de192o5a7371fd0fb1e9f8@mail.gmail.com>
	<20080509.112220.74748072.takada@mbf.nifty.com>
	<200805091127.53737.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pxy2nd.nifty.com ([202.248.175.14]:35161 "HELO pxy2nd.nifty.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755595AbYEINI5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 May 2008 09:08:57 -0400
In-Reply-To: <200805091127.53737.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi.

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: kernel 2.6.25 with ide driver cs5520 does not boot.
Date: Fri, 9 May 2008 11:27:53 +0200

> On Friday 09 May 2008, TAKADA Yoshihito wrote:
> > Thanks for quick reply.
> > 
> > I tried 2.6.26rc1. It hangs same as 2.6.25.
> > kernel 2.6.26rc1 with cs5520 cannot boot. cs5520 scans ide0 and ide1.
> > It seems 2nd port DMA base issue was solved.
> 
> [...]
> 
> Thanks.
> 
> The following patch for 2.6.26-rc1 disables VDMA, please give it a try
> (I haven't time to fully audit VDMA support yet but lets see if it is
> the main source of the problems).

I applied the patch. But kernel was hung.
And I attempt to kill IDE_HFLAG_CS5520. It cannot boot, oo.

  kill IDE_HFLAG_VDMA  : hang  
  kill IDE_HFLAG_CS5520: hang
  kill both flags      : boot



