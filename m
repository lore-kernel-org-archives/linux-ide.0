From: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>
Subject: Re: [2.6] system is very slow during disk access
Date: Wed, 6 Aug 2003 21:29:26 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200308062129.26371.frank.vandamme@student.kuleuven.ac.be>
References: <200308062052.10752.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from guri.is.kpn.be ([193.74.71.22]:16302 "EHLO guri.is.kpn.be")
	by vger.kernel.org with ESMTP id S270882AbTHFT3O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Aug 2003 15:29:14 -0400
In-Reply-To: <200308062052.10752.fsdeveloper@yahoo.de>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Michael Buesch <fsdeveloper@yahoo.de>, linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org

On Wednesday 06 August 2003 20:51, Michael Buesch wrote:
> Hi.
>
> I have massive problems with linux-2.6.0-test2.
> When some process writes something to disk, it's very hard
> to go on working with the system.
>
> Some test-szenario:
> $ dd if=3D/dev/zero of=3D./test.file
>
> While dd is running, xmms skips playing every now and then
> and the mouse is near to be unusable. The Mouse-cursor
> behaves some kind of very lazy and some times it jumps
> from one point on the display to another.
> When I stop disk-access, it works again quite fine.
>
> Would be cool, if you could give me some point to start
> for tracking this down.
>
> Please CC me, as I'm not subscribed to linux-ide. Thanks.

Maybe you just didn't enable DMA on them. Use hdparm -v /dev/foo to fin=
d out.=20

--=20
=46rank Van Damme    http://www.openstandaarden.be=20
~~~~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"Je pense, donc je suis brevet=E9."

