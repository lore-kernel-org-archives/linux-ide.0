From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 6/7] drivers/ata/pata_pcmcia.c: adjust suspicious bit operation
Date: Wed,  6 Jun 2012 23:41:40 +0200
Message-ID: <1339018901-28439-7-git-send-email-Julia.Lawall@lip6.fr>
References: <1339018901-28439-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339018901-28439-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, joe@perches.com, Julia Lawall <julia@diku.dk>
List-Id: linux-ide@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

IO_DATA_PATH_WIDTH_8 is 0, so a bit-and with it is always false.  The
value IO_DATA_PATH_WIDTH covers the bits of the IO_DATA_PATH constants, so
first pick those bits and then make the test using !=.

This problem was found using Coccinelle (http://coccinelle.lip6.fr/).

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/ata/pata_pcmcia.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index a808ba0..776e749 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -170,7 +170,8 @@ static int pcmcia_check_one_config(struct pcmcia_device *pdev, void *priv_data)
 {
 	int *is_kme = priv_data;
 
-	if (!(pdev->resource[0]->flags & IO_DATA_PATH_WIDTH_8)) {
+	if ((pdev->resource[0]->flags & IO_DATA_PATH_WIDTH)
+	    != IO_DATA_PATH_WIDTH_8) {
 		pdev->resource[0]->flags &= ~IO_DATA_PATH_WIDTH;
 		pdev->resource[0]->flags |= IO_DATA_PATH_WIDTH_AUTO;
 	}
