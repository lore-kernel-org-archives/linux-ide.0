From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] ide: officially deprecated the legacy IDE driver
Date: Wed,  8 May 2019 20:01:40 +0200
Message-ID: <20190508180140.12364-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

After a recent chat with Dave we agreed to try to finally kill off the
legacy IDE code base.  Set a two year grace period in which we try
to move everyone over.  There are a few pieces of hardware not
supported by libata yet, but for many of them we aren't even sure
if there are any users.  For those that have users we have usually
found a volunteer to add libata support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 5aeaca24a28f..4ad824984581 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1437,6 +1437,9 @@ int ide_host_register(struct ide_host *host, const struct ide_port_info *d,
 	ide_hwif_t *hwif, *mate = NULL;
 	int i, j = 0;
 
+	pr_warn("legacy IDE will be removed in 2021, please switch to libata\n"
+		"Report any missing HW support to linux-ide@vger.kernel.org\n");
+
 	ide_host_for_each_port(i, hwif, host) {
 		if (hwif == NULL) {
 			mate = NULL;
-- 
2.20.1
