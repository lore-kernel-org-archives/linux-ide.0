From: Connor Hansen <cmdkhh@gmail.com>
Subject: [PATCH 1/2] ide-cd: Fix signedness warning
Date: Mon, 30 May 2011 00:13:32 -0700
Message-ID: <1306739612-29239-1-git-send-email-cmdkhh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53891 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab1E3HNh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 May 2011 03:13:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: Borislav Petkov <bp@alien8.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Connor Hansen <cmdkhh@gmail.com>

One of the legit warnings 'make W=3D3 drivers/ide/ide-cd.o=C2=B4 genera=
tes is

drivers/ide/ide-cd.c: In function .ide_cdrom_prep_fs.:
drivers/ide/ide-cd.c:1314: warning: conversion to .unsigned int. from .=
int. may change the sign of the result

because queue_logical_block_size() returns unsigned short but hard_sect
is defined as int. Fix that no matter how low the potential for this
becoming a bug is.

Signed-off-by: Connor Hansen <cmdkhh@gmail.com>
---
 drivers/ide/ide-cd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 6e5123b..c1de54a 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1309,7 +1309,7 @@ static int ide_cdrom_probe_capabilities(ide_drive=
_t *drive)
 /* standard prep_rq_fn that builds 10 byte cmds */
 static int ide_cdrom_prep_fs(struct request_queue *q, struct request *=
rq)
 {
-	int hard_sect =3D queue_logical_block_size(q);
+	unsigned short hard_sect =3D queue_logical_block_size(q);
 	long block =3D (long)blk_rq_pos(rq) / (hard_sect >> 9);
 	unsigned long blocks =3D blk_rq_sectors(rq) / (hard_sect >> 9);
=20
--=20
1.7.4.4

