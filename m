From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH libata-dev-2.6:upstream] libata EH document update
Date: Wed, 28 Sep 2005 09:25:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509280924350.14803@shark.he.net>
References: <20050926022847.GA9724@htj.dyndns.org> <433AC282.6010000@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:32686 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751304AbVI1QZ7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Sep 2005 12:25:59 -0400
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Wed, 28 Sep 2005 09:25:57 -0700
In-Reply-To: <433AC282.6010000@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, tali@admingilde.org

On Wed, 28 Sep 2005, Jeff Garzik wrote:

> Tejun Heo wrote:
> >  Hello, Jeff.
> >
> >  Here's DocBook'fied libata_eh document.  Sorry it took so long.
>
> thanks, applied.
>
>
> >  To whine a little bit, I still think it's better to go plain text
> > with ata docs under Documentation/ata.  I don't really see the
> > benefits of DocBook as it currently stands.  It's so much less
> > accessible.  make pdf/ps docs still don't work and although it's been
> > broken for quite a while now, nobody really cares.

Same problem here, and I care.

> It depends on your distro whether it works or not :(
>
> For me, I just 'make xmldocs' then use db2pdf to convert the documents,
> since xmlto fails miserably.

Thanks for the hint.
I'll see what I can do for this in my spare time.

-- 
~Randy
