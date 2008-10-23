From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] cdrom: add TEAC CD-224E to the NO_AUTOCLOSE list
Date: Thu, 23 Oct 2008 22:50:03 +0200
Message-ID: <200810232250.03290.bzolnier@gmail.com>
References: <4900655E.7050906@freemail.hu> <9ea470500810230537u559fff3chda7c6f47927bf1b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.191]:1076 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbYJWVuI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Oct 2008 17:50:08 -0400
Received: by gv-out-0910.google.com with SMTP id e6so111620gvc.37
        for <linux-ide@vger.kernel.org>; Thu, 23 Oct 2008 14:50:07 -0700 (PDT)
In-Reply-To: <9ea470500810230537u559fff3chda7c6f47927bf1b0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: =?iso-8859-1?q?N=E9meth?= =?iso-8859-1?q?_M=E1rton?= <nm127@freemail.hu>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Thursday 23 October 2008, Boris Petkov wrote:
> On Thu, Oct 23, 2008 at 1:51 PM, N=E9meth M=E1rton <nm127@freemail.hu=
> wrote:
> > From: M=E1rton N=E9meth <nm127@freemail.hu>
> >
> > The "TEAC CD-ROM CD-224E" cannot close its tray, so add it to the N=
O_AUTOCLOSE list. This
> > will correct the "Can close tray" field of /proc/sys/dev/cdrom/info=
=2E
> >
> > Signed-off-by: M=E1rton N=E9meth <nm127@freemail.hu>
>=20
> Acked-by: Borislav Petkov <petkovbb@gmail.com>

applied
