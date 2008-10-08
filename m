From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch][repost] ide-tape build fix
Date: Wed, 8 Oct 2008 20:37:04 +0200
Message-ID: <200810082037.05889.bzolnier@gmail.com>
References: <48D79ABD.8060805@ru.mvista.com> <20081008154552.GA3907@localhost> <9ea470500810080922x326821c5p47053afa7a1d261e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:22095 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbYJHT2v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2008 15:28:51 -0400
Received: by gv-out-0910.google.com with SMTP id e6so679820gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 08 Oct 2008 12:28:49 -0700 (PDT)
In-Reply-To: <9ea470500810080922x326821c5p47053afa7a1d261e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Mark de Wever <koraq@xs4all.nl>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Gadi Oxman <gadio@netvision.net.il>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 08 October 2008, Boris Petkov wrote:
> On Wed, Oct 8, 2008 at 5:45 PM, Mark de Wever <koraq@xs4all.nl> wrote:
> > On Wed, Oct 08, 2008 at 08:33:52AM +0200, Borislav Petkov wrote:
> > Hi,
> >> Bugger, I should be getting at least warnings when compiling this but I don't.
> >> This is because I don't have CONFIG_LBD enabled. However, the %ld and %d
> >> format specifiers are also not entirely correct but gcc doesn't warn about them
> >> - I guess it checks only size but not signedness...
> >
> > I guess so too.
> >
> >> Would you like to redo your patch and add a proper comment ontop?
> >
> > Here you go.
> >
> > @Boris do you want to add your Signed-off-by too?
> 
> no, just
> 
> Acked-by: Borislav Petkov <petkovbb@gmail.com>
> 
> > @Bart please apply this patch.
> >
> > --
> > Subject: ide-tape: Buildfix when IDETAPE_DEBUG_LOG is set to 1.
> >
> > The format specifier for rq->sector didn't specify the proper size and
> > signedness. Borislav Petkov discovered that the signedness for
> > rq->nr_sectors and rq->current_nr_sectors also were incorrect.
> >
> > Signed-off-by: Mark de Wever <koraq@xs4all.nl>

applied
