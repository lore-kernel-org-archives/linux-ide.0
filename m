From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Mon, 5 Jan 2004 18:08:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200401051808.49010.bzolnier@elka.pw.edu.pl>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401032302.32914.bzolnier@elka.pw.edu.pl> <20040105035219.GA6393@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040105035219.GA6393@leto.cs.pocnet.net>
Content-Disposition: inline
To: Christophe Saout <christophe@saout.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 05 of January 2004 04:52, Christophe Saout wrote:

> BTW, what was ide_multwrite expected to return? These if clauses in
> multwrite_intr are never executed.

Dunno.  It can't fail so it should be made void.

Please also add bio->bi_idx restoring for failed requests.
Put it before DRIVER(drive)->error() (and remember about if (bio) check).

Otherwise I patch is OK for me.

--bart
