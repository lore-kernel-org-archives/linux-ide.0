From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2] ide-cd: Fix signedness warning
Date: Tue, 31 May 2011 15:23:46 -0700 (PDT)
Message-ID: <20110531.152346.160925902.davem@davemloft.net>
References: <1306739612-29239-1-git-send-email-cmdkhh@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1306739612-29239-1-git-send-email-cmdkhh@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cmdkhh@gmail.com
Cc: bp@alien8.de, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

=46rom: Connor Hansen <cmdkhh@gmail.com>
Date: Mon, 30 May 2011 00:13:32 -0700

> One of the legit warnings 'make W=3D3 drivers/ide/ide-cd.o=B4 generat=
es is
>=20
> drivers/ide/ide-cd.c: In function .ide_cdrom_prep_fs.:
> drivers/ide/ide-cd.c:1314: warning: conversion to .unsigned int. from=
 .int. may change the sign of the result
>=20
> because queue_logical_block_size() returns unsigned short but hard_se=
ct
> is defined as int. Fix that no matter how low the potential for this
> becoming a bug is.
>=20
> Signed-off-by: Connor Hansen <cmdkhh@gmail.com>

An 'int' can always hold as large a value as an "unsigned short" can ev=
er
hold, so there is no real problem here.

I'm not applying this.
