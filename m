From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [janitor] use kernel min/max (2/2)
Date: Thu, 22 Apr 2004 02:36:34 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404220236.34329.bzolnier@elka.pw.edu.pl>
References: <20040316163520.048ce536.rddunlap@osdl.org> <20040421144605.517d5834.rddunlap@osdl.org> <40870462.5070807@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:52914 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263661AbUDVAgq
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Apr 2004 20:36:46 -0400
In-Reply-To: <40870462.5070807@gmx.net>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Michael Veeck <michael.veeck@gmx.net>, "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-ide@vger.kernel.org, Kernel-janitors@lists.osdl.org

On Thursday 22 of April 2004 01:31, Michael Veeck wrote:
> > Michael hasn't replied on this AFAIK.
>
> Sorry for being quiet, I'm busy right now looking for a new job.

No problem.

> Anyway, IIRC I choose 'long' because of the jiffies.h too, but I'm
> willing to change that back to 'unsigned long'.

I'll revert it for now.

> > | ide-timing.h:
> > | get rid of MIN()/MAX() macros, this should be done very carefully
> > | as they are used for calculating timings
>
> Where's the risk in that? An example would be very helpful.

Well... break something and kiss your data good bye... :-)
(If wrong timings get calculated and programmed)

Thanks,
Bartlomiej

