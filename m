From: Tomas Szepe <szepe@pinerecords.com>
Subject: Re: [PATCH] Re: [TRIVIAL] kill surplus menu in IDE Kconfig
Date: Thu, 31 Jul 2003 11:03:52 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030731090352.GH12849@louise.pinerecords.com>
References: <20030730055725.GG4279@louise.pinerecords.com> <Pine.SOL.4.30.0307301823210.8913-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from louise.pinerecords.com ([213.168.176.16]:19868 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S268737AbTGaJEC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2003 05:04:02 -0400
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0307301823210.8913-100000@mion.elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Roman Zippel <zippel@linux-m68k.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> > > [B.Zolnierkiewicz@elka.pw.edu.pl]
> >
> > > - kill CONFIG_BLK_DEV_PDC202XX
> >
> > How do you mean?
> 
> It is not needed anymore.
> We have now CONFIG_BLK_DEV_PDC202XX_OLD and CONFIG_BLK_DEV_PDC202XX_NEW.

Oh, I was under the impression that this was already done.

> > > Does it sound sane?  If so I will later post patches for you review.
> >
> > Sounds good.  I can generate these patches if you're interested.
> 
> Patches are at:
> http://home.elka.pw.edu.pl/~bzolnier/ide-Kconfig/
> 
> They are against 2.6.0-test2.

Looks ok to me too.

-- 
Tomas Szepe <szepe@pinerecords.com>
