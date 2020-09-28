Return-Path: <SRS0=nj0s=DF=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6C8C4727E
	for <linux-ide@archiver.kernel.org>; Mon, 28 Sep 2020 17:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE68214D8
	for <linux-ide@archiver.kernel.org>; Mon, 28 Sep 2020 17:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgI1R51 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Sep 2020 13:57:27 -0400
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:48790 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726327AbgI1R50 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Sep 2020 13:57:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 387CF182CF665;
        Mon, 28 Sep 2020 17:57:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: smell94_24172cc27183
X-Filterd-Recvd-Size: 3389
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Sep 2020 17:57:23 +0000 (UTC)
Message-ID: <25aa56e1f7943f9ac535fa184465a752aa00a4b4.camel@perches.com>
Subject: Re: [PATCH 03/18] [ARM] pata_icside: use semicolons rather than
 commas to separate statements
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 28 Sep 2020 10:57:22 -0700
In-Reply-To: <alpine.DEB.2.22.394.2009281909000.2650@hadrien>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
         <1601233948-11629-4-git-send-email-Julia.Lawall@inria.fr>
         <8cf2fad1659acd756703deb106d55483bd1e1eb9.camel@perches.com>
         <alpine.DEB.2.22.394.2009281909000.2650@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, 2020-09-28 at 19:11 +0200, Julia Lawall wrote:
> 
> On Mon, 28 Sep 2020, Joe Perches wrote:
> 
> > On Sun, 2020-09-27 at 21:12 +0200, Julia Lawall wrote:
> > > Replace commas with semicolons.  What is done is essentially described by
> > > the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):
> > 
> > Hi Julia.
> > 
> > How did you decide on this patch subject header line?
> > 
> > It's certainly reasonable, but not what I would expect
> > from any automation.
> 
> Most of the patches on this file touch other files as well.  There are
> four that only touch this file.  One has no subsystem.  One has dma as the
> subsystem.  Two have pata_icside, so that was chosen.

So did you select the patch subject without any automation
or did you create a tool that looks only at commits for
individual files?

> > $ git log --no-merges --format='%s' drivers/ata/pata_icside.c | \
> >   cut -f1 -d":" | sort | uniq -c | sort -rn
> >      10 libata
> >       5 libata-sff
> >       2 [ARM] pata_icside
> >       2 [ARM] ecard
> >       2 [ARM] dma

Yeah...

Something like the script below and some examples of its use?

$ cat find_best_header.sh
#!/bin/bash

# Show possible patch subject prefixes for a file in git

# use commits that modify only the single file argument and
# emit up to the 5 most common commit prefixes

git log --no-merges --format='%h' -- $1 |
    while read commit ; do
	if [[ $(git log --format='%h' --name-only -1 $commit | wc -l) == 3 ]] ; then
	    git log --format='%s' -1 $commit
	fi
    done |
    cut -f1 -d":" | cut -f1-3 -d" " | sort | uniq -c | sort -rn | head -5

$ ./find_best_header.sh drivers/ata/pata_icside.c
      2 [ARM] pata_icside
      1 Fix pata_icside build
      1 [ARM] dma

$ ./find_best_header.sh kernel/fork.c
     36 fork
     14 kernel/fork.c
      6 mm
      4 pidns
      4 [PATCH] unshare system

$ ./find_best_header.sh kernel/sched/core.c
    150 sched
    110 sched/core
     12 sched/uclamp
     12 sched/debug
     10 sched/deadline

$ ./find_best_header.sh drivers/iio/pressure/mpl115.c
      3 iio


