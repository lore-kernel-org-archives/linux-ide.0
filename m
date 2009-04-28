From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/3] mg_disk: fix CONFIG_LBD=y warning
Date: Tue, 28 Apr 2009 12:52:18 +0900
Message-ID: <1240890740-3462-3-git-send-email-tj@kernel.org>
References: <1240890740-3462-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46127 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755525AbZD1Dwh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Apr 2009 23:52:37 -0400
In-Reply-To: <1240890740-3462-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: axboe@kernel.dk, linux-kernel@vger.kernel.org, donari75@gmail.com, bzolnier@gmail.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <tj@kernel.org>

=46rom: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

drivers/block/mg_disk.c: In function =E2=80=98mg_dump_status=E2=80=99:
drivers/block/mg_disk.c:265: warning: format =E2=80=98%ld=E2=80=99 expe=
cts type =E2=80=98long int=E2=80=99, but
argument 2 has type =E2=80=98sector_t=E2=80=99

[ Impact: kill build warning ]

Cc: unsik Kim <donari75@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/block/mg_disk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/mg_disk.c b/drivers/block/mg_disk.c
index d3e72ad..f389835 100644
--- a/drivers/block/mg_disk.c
+++ b/drivers/block/mg_disk.c
@@ -79,7 +79,7 @@ static void mg_dump_status(const char *msg, unsigned =
int stat,
 			if (host->breq) {
 				req =3D elv_next_request(host->breq);
 				if (req)
-					printk(", sector=3D%ld", req->sector);
+					printk(", sector=3D%u", (u32)req->sector);
 			}
=20
 		}
--=20
1.6.0.2

