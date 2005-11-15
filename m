From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Buggy IDE / ATA drive on 2.6? DMA timeouts, 2.4 is fine
Date: Tue, 15 Nov 2005 13:58:04 +0100
Message-ID: <58cb370e0511150458t1748b396sd70c7a27d93111a5@mail.gmail.com>
References: <1132054925.4379c98d390e4@imp4-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.206]:54035 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932467AbVKOM6H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Nov 2005 07:58:07 -0500
Received: by nproxy.gmail.com with SMTP id c29so296587nfb
        for <linux-ide@vger.kernel.org>; Tue, 15 Nov 2005 04:58:05 -0800 (PST)
In-Reply-To: <1132054925.4379c98d390e4@imp4-g19.free.fr>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rahul Siddharthan <rsidd@online.fr>
Cc: linux-ide@vger.kernel.org

On 11/15/05, Rahul Siddharthan <rsidd@online.fr> wrote:
> Bartlomiej Zolnierkiewicz said on Nov 11, 2005 at 14:33:18:
> > On 11/8/05, Rahul Siddharthan <rsidd@online.fr> wrote:
> > > Bartlomiej Zolnierkiewicz said on Nov  8, 2005 at 14:17:13:
> > > > On 11/8/05, Rahul Siddharthan <rsidd@online.fr> wrote:
> [snip]
> > > > > hda: dma_timer_expiry: dma status == 0x21
> > > > > hda: DMA timeout error
> > > > > hda: dma timeout error: status=0xd0 (busy)
> > > > >
> > > > > ide: failed opcode was: unknown
> > > > > hda: DMA disabled
> > > > > ide0: reset: success
> [snip]
> > Does 2.4 kernel work reliably for you now?
>
> To the limited extent that I've been running it, yes.  Mainly I've been
> running BSD since then though, which also works reliably.  I haven't
> run linux 2.6 for several days now.
>
> > If so please do more testing and find the latest kernel version
> > which works for you, otherwise it is very unlikely that somebody
> > will be able to help you as going from 2.4.27->2.6.10 means going
> > through insane amount of changes.
>
> I'm pretty sure that I noticed this after upgrading from 2.6.8.1 to
> 2.6.12, but don't want to do a "binary search".  It looks like, after
> the symptoms appear under linux 2.6, they also appear for a while under
> linux 2.4 and BSD, and take a while to go away.  I'm worried about
> permanently damaging the machine.
>
> The other reports I see on the net also seem to refer to 2.6.10 and above,
> so perhaps something happened in 2.6.10.

Care to give some pointers?

> > > OK, smartctl -a says
> > > SMART overall-health self-assessment test result: PASSED
> > > and reports 14 errors, the most recent 2 at 7287 hours, (303 days + 15
> > > hrs) so the DMA timeout errors aren't here.  Do you need the full
> > > output?
> >
> > Yes.
>
> http://rsidd.online.fr/smartctl.out

It seems that your drive is failing (reallocated sectors) and you've noticed
it with linux-2.6 because it stresses the hardware the most...

Bartlomiej
