From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.6.0-test9: BUG alim15x3.c
Date: Sun, 2 Nov 2003 17:46:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200311021746.00852.bzolnier@elka.pw.edu.pl>
References: <20031102150911.GB14148@pusa.informat.uv.es> <200311021645.54838.bzolnier@elka.pw.edu.pl> <20031102155423.GA15847@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20031102155423.GA15847@pusa.informat.uv.es>
Content-Disposition: inline
To: uaca@alumni.uv.es
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Try "hda=3Dremap" and "hda=3Dremap63" and please don't ask me why it is=
 not
autodetected (not my fault)...

On Sunday 02 of November 2003 16:54, uaca@alumni.uv.es wrote:
> Hi Bartlemiej!
>
> On Sun, Nov 02, 2003 at 04:45:54PM +0100, Bartlomiej Zolnierkiewicz w=
rote:
> > On Sunday 02 of November 2003 16:09, uaca@alumni.uv.es wrote:
>
> [...]
>
> > Does it recognize drives correctly?
>
> I will double check that
>
> > Does ALI driver oops?
>
> no
>
> > Do you have support for your filesystem compiled-in (not as module)=
=2E
>
> yes
>
> > Have you tried passing "root=3D/dev/hda" (or similar) boot paramete=
r?
>
> yes, and I pass it right :-)
>
> when the systems boot, at the partition table check
> it prints
>
> "unknown partition table"
>
> Thanks
>
> 	Ulisses
>
>                 Debian GNU/Linux: a dream come true
> ---------------------------------------------------------------------=
------
>-- "Computers are useless. They can only give answers."            Pab=
lo
> Picasso
>
> --->	Visita http://www.valux.org/ para saber acerca de la	<---
> --->	Asociaci=F3n Valenciana de Usuarios de Linux		<---
