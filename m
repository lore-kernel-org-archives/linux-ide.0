From: Alban Browaeys <browaeys.alban@wanadoo.fr>
Subject: Re: Samsung SP0822N does not go over UDMA 33 (2.6.11)
Date: Mon, 06 Jun 2005 18:08:36 +0200
Message-ID: <pan.2005.06.06.16.08.35.934967@wanadoo.fr>
References: <pan.2005.06.03.13.18.36.818342@ree.hu> <pan.2005.06.06.08.12.11.7629@ree.hu>
Reply-To: browaeys.alban@wanadoo.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:47812 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261788AbVFGBEP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Jun 2005 21:04:15 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DfSRt-0004lv-2P
	for linux-ide@vger.kernel.org; Tue, 07 Jun 2005 03:00:09 +0200
Received: from atoulouse-152-1-32-252.w82-125.abo.wanadoo.fr ([82.125.30.252])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 07 Jun 2005 03:00:09 +0200
Received: from browaeys.alban by atoulouse-152-1-32-252.w82-125.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 07 Jun 2005 03:00:09 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Le Mon, 06 Jun 2005 10:12:18 +0200, Balazs Ree a =E9crit :


Sorry i am the most newby of kernel hackers , though i hope the pointer=
s
to documentation can help you (well and that you can go further than i =
did
with those)

> As I've received no reply for this help request, I can assume that no=
 one
> uses this particular model of Samsung. Perhaps it is a new model...? =
This
> means I am on my own.

Well i am also having issues with atapi and such a card though it looks
like "my" problem comes from drive. I am also waiting to see the end of
the ide/scsi transport layer redesign (though following it and learning
from the changesets).

> I would be willing to find out why this happens, but someone
could
> please give me a helping hand? It would be great if you could point m=
e
> to the exact location of the ide code where the limitation to udma2 i=
s
> made, this would save me an enormous amount of time. Then I guess I
> would make the code a bit more verbose and figure out something. You =
can
> also contact me directly about this.

I would suggest reading about the 2.6 driver model at linux weekly news
kernel section : http://lwn.net/Kernel/Index/ (for example Driver porti=
ng:
the gendisk interface http://lwn.net/Articles/25711/ )

and the "linux device drivers, third edition" http://lwn.net/Kernel/LDD=
3/=20
(though the book is worth to buy :) , sadly i only have the second edit=
ion


Cheers
Alban

