From: uaca@alumni.uv.es
Subject: Re: 2.6.0-test9: BUG alim15x3.c
Date: Sun, 2 Nov 2003 16:54:23 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031102155423.GA15847@pusa.informat.uv.es>
References: <20031102150911.GB14148@pusa.informat.uv.es> <200311021645.54838.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pusa.informat.uv.es ([147.156.10.98]:3765 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP id S261743AbTKBPyZ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Nov 2003 10:54:25 -0500
Content-Disposition: inline
In-Reply-To: <200311021645.54838.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>


Hi Bartlemiej!

On Sun, Nov 02, 2003 at 04:45:54PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Sunday 02 of November 2003 16:09, uaca@alumni.uv.es wrote:
[...]
> Does it recognize drives correctly? =20

I will double check that

> Does ALI driver oops?

no

> Do you have support for your filesystem compiled-in (not as module).

yes

> Have you tried passing "root=3D/dev/hda" (or similar) boot parameter?

yes, and I pass it right :-)

when the systems boot, at the partition table check
it prints=20

"unknown partition table"

Thanks

	Ulisses

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------=
------
"Computers are useless. They can only give answers."            Pablo P=
icasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociaci=F3n Valenciana de Usuarios de Linux		<---
=20
