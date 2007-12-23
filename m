From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 00/63] ide-cd: redux
Date: Sun, 23 Dec 2007 07:55:25 +0100
Message-ID: <20071223065525.GA5003@gollum.tnic>
References: <200712200148.49690.bzolnier@gmail.com> <20071220121157.GA7162@gollum.tnic> <200712212057.49502.bzolnier@gmail.com>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp113.plus.mail.re1.yahoo.com ([69.147.102.76]:30571 "HELO
	smtp113.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751352AbXLWG6D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Dec 2007 01:58:03 -0500
Content-Disposition: inline
In-Reply-To: <200712212057.49502.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 21, 2007 at 08:57:49PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Thursday 20 December 2007, Borislav Petkov wrote:
> > On Thu, Dec 20, 2007 at 01:48:49AM +0100, Bartlomiej Zolnierkiewicz=
 wrote:
> > Hi Bart,
> > Hi all,
> >=20
> > > PS ide-cd Maintainer position is still open...
> > i'd like to take that position if nobody objects. I've done some wo=
rk around the
> > kernel here and there and i think its time for me to get serious.
>=20
> Great!
>=20
> Please send me a patch for MAINTAINERS file updating ide-cd entry.

Sure, there it is:

---

Reopen ide-cd for maintainership.

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

--
diff --git a/MAINTAINERS b/MAINTAINERS
index 3c7db62..fb59941 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1870,8 +1870,10 @@ T:	quilt kernel.org/pub/linux/kernel/people/bart=
/pata-2.6/
 S:	Maintained
=20
 IDE/ATAPI CDROM DRIVER
+P:	Borislav Petkov
+M:	bbpetkov@yahoo.de
 L:	linux-ide@vger.kernel.org
-S:	Unmaintained
+S:	Maintained
=20
 IDE/ATAPI FLOPPY DRIVERS
 P:	Paul Bristow
--=20
Regards/Gru=DF,
    Boris.
