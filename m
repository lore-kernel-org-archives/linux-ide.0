From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Tue, 6 Jan 2004 15:38:48 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200401061538.48904.bzolnier@elka.pw.edu.pl>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401060059.52833.bzolnier@elka.pw.edu.pl> <20040106113330.GA5827@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20172 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264353AbUAFOf7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jan 2004 09:35:59 -0500
In-Reply-To: <20040106113330.GA5827@leto.cs.pocnet.net>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Christophe Saout <christophe@saout.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 06 of January 2004 12:33, Christophe Saout wrote:
> On Tue, Jan 06, 2004 at 12:59:52AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Monday 05 of January 2004 23:51, Christophe Saout wrote:
> > > Remember? Can bio be NULL somewhere? Or what do you mean? It's our
> > > scratchpad and ide_multwrite never puts a NULL bio on it.
> >
> > After last sector of the whole transfer is processed ide_multwrite() will
> > set it to NULL.
>
> No, it doesn't.

Yep, you are right, bio is NULL, but rq->bio is not set...

--bart

