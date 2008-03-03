From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide_register_hw(): buggy code
Date: Mon, 3 Mar 2008 23:29:31 +0100
Message-ID: <200803032329.32020.bzolnier@gmail.com>
References: <20080302151924.GJ25835@cs181133002.pp.htv.fi> <804dabb00803030803v1dbbb33fh6779b8c4d072a908@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:52687 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbYCCWXl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2008 17:23:41 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2294527ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 03 Mar 2008 14:23:39 -0800 (PST)
In-Reply-To: <804dabb00803030803v1dbbb33fh6779b8c4d072a908@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Teoh <htmldeveloper@gmail.com>
Cc: Adrian Bunk <bunk@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Monday 03 March 2008, Peter Teoh wrote:
> On Sun, Mar 2, 2008 at 11:19 PM, Adrian Bunk <bunk@kernel.org> wrote:
> > The Coverity checker spotted the following bogus change to
> >  ide_register_hw() in commit 9e016a719209d95338e314b46c3012cc7feaaeec:
> >
> >  <--  snip  -->
> >
> >  ...
> >  +               hwif = ide_deprecated_find_port(hw->io_ports[IDE_DATA_OFFSET]);
> >  +               index = hwif->index;
> >  +               if (hwif)
> >  +                       goto found;
> >                 for (index = 0; index < MAX_HWIFS; index++)
> >  ...
> >
> >  <--  snip  -->
> >
> >  It's impossible to reach the for() loop without Oopsing before.

[ iff free hwif is not found (unlikely case) ]

> >  Can you either fix this for 2.6.25 or push your patch that removes
> >  ide_register_hw() for 2.6.25?
> >
> 
> My question is:
> 
> a.   why is "retry=1", and then the do while loop always end up the
> loop being one round executed only?   Why not just remove the while
> loop entirely?

the whole ide_register_hw() is already gone in IDE tree
(these patches are scheduled for 2.6.26)

> b.   not sure if your statement above implied this, but checking for
> hwif!=0 should be before index.  ???
> 
> c.   "index = hwif->index;" should not be there, but after "found".
> Is that correct?

Yes, could you please re-do your patch to contain:

- only 'hwif->index' change
- proper patch description
- Signed-off-by: line

so I could merge it?

Thanks,
Bart
