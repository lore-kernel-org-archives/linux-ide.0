From: Jesper Juhl <juhl@dif.dk>
Subject: Re: [PATCH] tiny patch to kill warning in drivers/ide/ide.c
Date: Wed, 9 Jun 2004 16:39:00 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.56.0406091637510.26677@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0406090335260.25359@jjulnx.backbone.dif.dk>
 <200406091231.20049.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dif.dk ([193.138.115.101]:55765 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266138AbUFIOjo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2004 10:39:44 -0400
In-Reply-To: <200406091231.20049.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>

On Wed, 9 Jun 2004, Bartlomiej Zolnierkiewicz wrote:

> On Wednesday 09 of June 2004 03:38, Jesper Juhl wrote:
> > To kill this warning :
> >
> > drivers/ide/ide.c: In function `ide_unregister_subdriver':
> > drivers/ide/ide.c:2216: warning: implicit declaration of function
> > `pnpide_init'
> >
> > I added a simple declaration of pnpide_init to drivers/ide/ide.c
> >
> > Here's a patch against 2.6.7-rc3 - please consider including it (or if
> > that's not the way to do it, then don't) :)
>
> Thanks but the real bug is to call pnpide_init() from
> ide_unregister_subdriver(), I'll push ide-pnp update soon.
>

Ok, in that case I will leave it alone and just wait for your update.


--
Jesper Juhl <juhl@dif.dk>

