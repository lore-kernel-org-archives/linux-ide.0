From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/32] ide-tape redux v1
Date: Wed, 30 Jan 2008 01:29:55 +0100
Message-ID: <200801300129.56003.bzolnier@gmail.com>
References: <1201423312-2460-1-git-send-email-bbpetkov@yahoo.de> <200801272045.40712.bzolnier@gmail.com> <20080128054343.GB3074@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:56309 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756925AbYA3AQe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 19:16:34 -0500
Received: by fg-out-1718.google.com with SMTP id e21so21168fga.17
        for <linux-ide@vger.kernel.org>; Tue, 29 Jan 2008 16:16:30 -0800 (PST)
In-Reply-To: <20080128054343.GB3074@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Monday 28 January 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> [...]
> 
> > > the BKL in idetape_write_release() with finer-grained locking etc, probably also
> > > some pipeline improvements, removal of OnStream support, etc. but that'll come
> > > later.
> > 
> > On-Stream support has been long gone but it seems that deprecation
> > warning etc. managed to survive.
> > 
> > w.r.t. to the pipeline-mode: it should be pipelined into /dev/null
> > 
> > rationale:
> > - it is _very_ complex
> > - causes errors to be deferred till the next user-space access
> > - direct I/O using blk_rq_map_user() will offer superior performance
> > 
> > the only question is whether to remove it...
> 
> Well, on the one hand, since the driver is only being maintained we should not
> remove code that works. Also, i don't know how many users ide-tape really has
> but, would it be worth the trouble at all? Because if nobody's using it, we
> could just as well pipe the whole thing into /dev/null.. On the other hand, the

This may be the other alternative... [ there is always libata PATA... ]

If you want to give ide-tape removal a try, go ahead (I suggest starting
with adding warning printk() and keeping patch in -mm for some time)...

> pipelining part _is_ kinda big and, right, it is not that straightfoward to
> look at it and know what it actually does - it truly is a student project :)

I have pipelining code figured out to some degree but reworking it is a rather
low-prio on my TODO list...

[...]

> Anyway, resending #23 to you in a private mail.

Thanks.

Bart
