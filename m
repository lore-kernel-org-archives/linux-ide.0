From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/4] ide: don't disable interrupts during kmap_atomic()
Date: Fri,  4 May 2018 16:24:45 +0200
Message-ID: <20180504142446.30525-4-bigeasy@linutronix.de>
References: <20180504142446.30525-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180504142446.30525-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-ide@vger.kernel.org

ide_pio_bytes() disables interrupts around kmap_atomic(). This is a
leftover from the old kmap_atomic() implementation which relied on fixed
mapping slots, so the caller had to make sure that the same slot could not
be reused from an interrupting context.

kmap_atomic() was changed to dynamic slots long ago and commit 1ec9c5ddc17a
("include/linux/highmem.h: remove the second argument of k[un]map_atomic()")
removed the slot assignements, but the callers were not checked for now
redundant interrupt disabling.

Remove the conditional interrupt disable.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/ide/ide-taskfile.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index abe0822dd429..49f9b4739779 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -237,7 +237,6 @@ void ide_pio_bytes(ide_drive_t *drive, struct ide_cmd *=
cmd,
=20
 	while (len) {
 		unsigned nr_bytes =3D min(len, cursg->length - cmd->cursg_ofs);
-		int page_is_high;
=20
 		page =3D sg_page(cursg);
 		offset =3D cursg->offset + cmd->cursg_ofs;
@@ -248,10 +247,6 @@ void ide_pio_bytes(ide_drive_t *drive, struct ide_cmd =
*cmd,
=20
 		nr_bytes =3D min_t(unsigned, nr_bytes, (PAGE_SIZE - offset));
=20
-		page_is_high =3D PageHighMem(page);
-		if (page_is_high)
-			local_irq_save(flags);
-
 		buf =3D kmap_atomic(page) + offset;
=20
 		cmd->nleft -=3D nr_bytes;
@@ -270,9 +265,6 @@ void ide_pio_bytes(ide_drive_t *drive, struct ide_cmd *=
cmd,
=20
 		kunmap_atomic(buf);
=20
-		if (page_is_high)
-			local_irq_restore(flags);
-
 		len -=3D nr_bytes;
 	}
 }
--=20
2.17.0
