From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Add two missing chipsets to drivers/ide/ide-proc.c
Date: Thu, 24 May 2007 01:50:18 +0200
Message-ID: <200705240150.18878.bzolnier@gmail.com>
References: <20070518071141.GA2308@srv1-m700-lanp.koti>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:3542 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757490AbXEXBYH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 21:24:07 -0400
Received: by ug-out-1314.google.com with SMTP id 70so758457ugb
        for <linux-ide@vger.kernel.org>; Wed, 23 May 2007 18:24:04 -0700 (PDT)
In-Reply-To: <20070518071141.GA2308@srv1-m700-lanp.koti>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mikukkon@iki.fi
Cc: alan@redhat.com, linux-ide@vger.kernel.org

On Friday 18 May 2007, Mika Kukkonen wrote:
> Compiling with '-Wswitch-enum' I noticed following:
>=20
>   CC      drivers/ide/ide-proc.o
> drivers/ide/ide-proc.c: In function =E2=80=98proc_ide_read_imodel=E2=80=
=99:
> drivers/ide/ide-proc.c:54: warning: enumeration value =E2=80=98ide_et=
rax100=E2=80=99 not handled in switch
> drivers/ide/ide-proc.c:54: warning: enumeration value =E2=80=98ide_ac=
orn=E2=80=99 not handled in switch
>=20
> How about the following patch?
>=20
> Signed-off-by: Mika Kukkonen <mikukkon@iki.fi>

applied
