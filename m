From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] ATI IXP IDE support (was: Re: Support for ATI IXP150 Southbridge)
Date: Wed, 25 Feb 2004 21:08:37 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402252108.37225.bzolnier@elka.pw.edu.pl>
References: <200402232123.43989.phil@riverbankcomputing.co.uk> <200402232354.42308.bzolnier@elka.pw.edu.pl> <200402241808.22246.phil@riverbankcomputing.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:60383 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261287AbUBYUCN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2004 15:02:13 -0500
In-Reply-To: <200402241808.22246.phil@riverbankcomputing.co.uk>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Phil Thompson <phil@riverbankcomputing.co.uk>
Cc: Matthew Tippett <mtippett@ati.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 24 of February 2004 19:08, Phil Thompson wrote:
> On Monday 23 February 2004 22:54, Bartlomiej Zolnierkiewicz wrote:
> > On Monday 23 of February 2004 22:23, Phil Thompson wrote:
> > > Is anybody working on support for the ATI IXP150 Southbridge?
> > > Particularly the IDE and USB devices.
> >
> > IDE support should be added soon (thanks to ATI).
> >
> > --bart
>
> Great - is there someone I can contact to volunteer to help with testing?

You can find experimental (I have not tested it!) driver for 2.6.3 kernel at:
http://www.kernel.org/pub/linux/kernel/people/bart/atiixp_ide/atiixp_ide-2.6.3-1.patch

It was written by Hui Yu <hyu@ati.com>, additional fixes/cleanups by me.

Thanks,
--bart

