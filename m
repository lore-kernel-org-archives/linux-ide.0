From: Christophe Saout <christophe@saout.de>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Tue, 06 Jan 2004 16:21:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1073402495.6624.3.camel@leto.cs.pocnet.net>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net>
	 <200401060059.52833.bzolnier@elka.pw.edu.pl>
	 <20040106113330.GA5827@leto.cs.pocnet.net>
	 <200401061538.48904.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200401061538.48904.bzolnier@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Am Di, den 06.01.2004 schrieb Bartlomiej Zolnierkiewicz um 15:38:

> > > > Remember? Can bio be NULL somewhere? Or what do you mean? It's our
> > > > scratchpad and ide_multwrite never puts a NULL bio on it.
> > >
> > > After last sector of the whole transfer is processed ide_multwrite() will
> > > set it to NULL.
> >
> > No, it doesn't.
> 
> Yep, you are right, bio is NULL, but rq->bio is not set...

So, shall I resend the updated patch with the one line moved above the
comment?
