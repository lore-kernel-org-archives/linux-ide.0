From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] atapi request sense work
Date: Fri, 21 May 2004 21:08:55 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405212108.55936.bzolnier@elka.pw.edu.pl>
References: <1084717146.3576.3.camel@patibmrh9> <200405212036.08190.bzolnier@elka.pw.edu.pl> <1085166052.833.87.camel@vom>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6619 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264777AbUEUTIF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 15:08:05 -0400
In-Reply-To: <1085166052.833.87.camel@vom>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Danny Cox <Danny.Cox@ECWeb.com>
Cc: linux-ide@vger.kernel.org

On Friday 21 of May 2004 21:00, Danny Cox wrote:
> Bartlomiej,
>
> On Fri, 2004-05-21 at 14:39, Bartlomiej Zolnierkiewicz wrote:
> > You do 'goto abort' while not holding locks.
>
> 	Please disregard the previous email.  I figured it out.  Part of that
> patch came from an earlier version where I was doing the kmalloc() later
> in the routine.  I didn't reason very well when I still had the error
> flow going to the abort.

Good!

> 	Sorry about the wasted bandwidth!  Although it wasn't wasted entirely.
> I learned a thing or two.

No problem. :-)

