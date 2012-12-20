From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Shut up annoying native_sectors warning
Date: Thu, 20 Dec 2012 13:01:59 +0000
Message-ID: <20121220130159.7125e700@pyramind.ukuu.org.uk>
References: <1356006355-6819-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55153 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab2LTM43 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Dec 2012 07:56:29 -0500
In-Reply-To: <1356006355-6819-1-git-send-email-bp@alien8.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Thu, 20 Dec 2012 13:25:55 +0100
Borislav Petkov <bp@alien8.de> wrote:

> I'm getting this
>=20
> drivers/ata/libata-core.c: In function =E2=80=98ata_hpa_resize=E2=80=99=
:
> drivers/ata/libata-core.c:1397:3: warning: =E2=80=98native_sectors=E2=
=80=99 may be used uninitialized in this function [-Wmaybe-uninitialize=
d]
>=20
> for a couple of kernel releases now with gcc (Debian 4.7.2-4) 4.7.2.
>=20
> And the warning is bogus because ata_read_native_max_address either
> returns a sensible max_sectors aka native_sectors through its second
> arg pointer or an error value which is properly handled in its caller
> ata_hpa_resize().
>=20
> So shut up gcc already.

And ensure it won't be noticed if a real problem is found. So we go fro=
m
warning for a few people who ignore it, to silence for everyone if a re=
al
bug appears

Net lose IMHO - better to file a gcc bug report

Alan

