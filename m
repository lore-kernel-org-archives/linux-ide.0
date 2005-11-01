From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC PATCH] pmac ide doesn't properly cleanup hwif when releasing controller
Date: Tue, 1 Nov 2005 17:20:51 +0100
Message-ID: <58cb370e0511010820p77bd47c9wa566f3d356291733@mail.gmail.com>
References: <20051029044852.1a518908@Tatooine.r3z0>
	 <1130623795.29054.179.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.203]:45997 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750911AbVKAQUw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Nov 2005 11:20:52 -0500
Received: by nproxy.gmail.com with SMTP id q29so394726nfc
        for <linux-ide@vger.kernel.org>; Tue, 01 Nov 2005 08:20:51 -0800 (PST)
In-Reply-To: <1130623795.29054.179.camel@gaston>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, linux-ide@vger.kernel.org

On 10/29/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Sat, 2005-10-29 at 04:48 +0200, Thibaut VARENE wrote:
>
> > I've been investigating the IDE code a bit, and it seems that it generally
> > assumes that an interface cannot be released once claimed. Cleaning up the
> > hwif without knowing its previous state in pmac.c is a big and potentially
> > dangerous job, and there seems to be no generic code interface that would
> > provide either a way to properly release an hwif or to clean it up.
> >
> > The rationale behind this is related to the value of MAX_HWIFS, which is
> > usually pretty low (usually between 2 and 10).
> >
> > So the question is "what should be done (and how)"?
>
> Bart, the problem here is indeed the code in pmac IDE that tries to
> "release" HWIFs to the core if they are probed empty. For some reason,
> it used to work (I think ide-dma used to unconditionally override the
> callbacks) but not any more.
>
> Thus my question: Should I
>
>  - Manually in ide-pmac clean up all callbacks & revert everything in
> the HWIF when I want to hand it back
>
>  - Call init_hwif_data() despite the nasty comment on top
>
>  - Just don't release the interface...

Just don't release it - it is the simplest solution and also
as the easiest to maintain in future (hotplug).

Bartlomiej
