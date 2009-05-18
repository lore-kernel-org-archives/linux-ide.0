From: Richard Atterer <richard@2009.atterer.net>
Subject: Re: s2disk hangs with kernel >=2.6.29, SATA, Gigabyte EG45M-DS2H
	(bisected)
Date: Mon, 18 May 2009 17:00:37 +0200
Message-ID: <20090518150037.GA7891@arbonne.lan>
References: <20090516225153.GA7883@arbonne.lan> <200905180117.28413.bzolnier@gmail.com> <20090518141646.GA6460@arbonne.lan> <200905181629.33234.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39786 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752641AbZERPAj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 May 2009 11:00:39 -0400
Content-Disposition: inline
In-Reply-To: <200905181629.33234.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org

On Mon, May 18, 2009 at 04:29:33PM +0200, Bartlomiej Zolnierkiewicz wro=
te:
> Does the one commit before 295f00042aaf6b553b5f37348f89bab463d4a469
> (namely ebdab07dad3d3a008e519b0a028e1e1ad5ecaef0) work fine?

Yes, it does; I tried that one during bisecting, and then re-tried befo=
re=20
writing my first mail, just to ensure I hadn't messed something up.

IIRC I also tried to modify my 2.6.30-rc6 checkout to reinstate the cal=
ls=20
to spin_unlock() and local_irq_enable_in_hardirq() that were replaced w=
ith=20
spin_unlock_irq() by patch 295f000.  This also didn't cause the problem=
 to=20
go away. Anyway, I have no clue what all this code does, so that was ju=
st a=20
shot in the dark! :-)

Cheers,

  Richard

--=20
  __   _
  |_) /|  Richard Atterer
  | \/=AF|  http://atterer.net
  =AF '` =AF
