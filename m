From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 0/3] ide: /proc/ide/hd*/settings rework
Date: Tue, 29 Jul 2008 17:43:55 +0200
Message-ID: <87od4gn1ac.fsf@denkblock.local>
References: <20080727185602.4660.66530.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:53382 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753756AbYG2PoJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jul 2008 11:44:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> Hi,
>
> I finally dusted off /proc/ide/hd*/settings rework (this has been laying
> on my hdd and waiting for the better days for at least 1.5 year, draft
> version even longer like ~3 years... sigh).
>
> The main motivation for doing it is that with infrastructure for private
> IDE subsystem requests from Elias Oltmanns (which was merged recently)
> and this patchset it should be possible (by using private requests for
> device settings) to make IDE locking code a lot saner and get rid of
> of ide_spin_wait_hwgroup()-ugliness completely.
>
> Elias if you would like to take care of it please go ahead [ from a quick
> look it seems this would mostly require adding new request type, pointing
> rq->special to setting's ->get or ->set method and putting setting's type
> (read/write -> 1 bit) + argument (int) somewhere inside request but you
> probably know better ].

Yes, I'll have a go at it. I haven't quite figured out yet whether I can
(or should, for that matter) get rid of drive->special and convert the
rest accordingly.

Anyway, I probably won't get it done before next week.

Regards,

Elias
