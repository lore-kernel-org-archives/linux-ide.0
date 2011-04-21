From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] block: don't propagate unlisted DISK_EVENTs to userland
Date: Thu, 21 Apr 2011 10:25:35 -0700
Message-ID: <BANLkTinwPt=aRSsh_Ppb8hLOaURh6mL2GQ@mail.gmail.com>
References: <20110421170826.GC15988@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49605 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755156Ab1DUR0b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Apr 2011 13:26:31 -0400
In-Reply-To: <20110421170826.GC15988@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <jaxboe@fusionio.com>, Christoph Hellwig <hch@lst.de>, Neil Brown <neilb@suse.de>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kay.sievers@vrfy.org

Should I take these as patches, or through Jens/David/Who?

I'll happily take them as patches, but I'd also like to hear
confirmation from the people who saw the lock-up that it's gone now..

                        Linus

On Thu, Apr 21, 2011 at 10:08 AM, Tejun Heo <tj@kernel.org> wrote:
> DISK_EVENT_MEDIA_CHANGE is used for both userland visible event and
> internal event for revalidation of removeable devices. =A0Some legacy
> drivers don't implement proper event detection and continuously
> generate events under certain circumstances. =A0For example, ide-cd
> generates media changed continuously if there's no media in the drive=
,
> which can lead to infinite loop of events jumping back and forth
> between the driver and userland event handler.
>
> This patch updates disk event infrastructure such that it never
> propagates events not listed in disk->events to userland. =A0Those
> events are processed the same for internal purposes but uevent
> generation is suppressed.
>
> This also ensures that userland only gets events which are advertised
> in the @events sysfs node lowering risk of confusion.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> These two patches fix infinite MEDIA_CHANGE events problem reported w=
/
> ide-cd. =A0I tried an alternate patch to implement proper check_event=
s()
> for ide-cd but given the deprecated status of ide and the existence o=
f
> fallback userland event polling, this minimal approach seems better.
>
> Thank you.
>
> =A0block/genhd.c | =A0 =A08 ++++++--
> =A01 file changed, 6 insertions(+), 2 deletions(-)
>
> Index: work/block/genhd.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- work.orig/block/genhd.c
> +++ work/block/genhd.c
> @@ -1588,9 +1588,13 @@ static void disk_events_workfn(struct wo
>
> =A0 =A0 =A0 =A0spin_unlock_irq(&ev->lock);
>
> - =A0 =A0 =A0 /* tell userland about new events */
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Tell userland about new events. =A0Only the events=
 listed in
> + =A0 =A0 =A0 =A0* @disk->events are reported. =A0Unlisted events are=
 processed the
> + =A0 =A0 =A0 =A0* same internally but never get reported to userland=
=2E
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0for (i =3D 0; i < ARRAY_SIZE(disk_uevents); i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (events & (1 << i))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (events & disk->events & (1 << i))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0envp[nr_events++] =3D =
disk_uevents[i];
>
> =A0 =A0 =A0 =A0if (nr_events)
>
