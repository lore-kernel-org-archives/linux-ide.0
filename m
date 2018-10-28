From: Joris Gutjahr <joris.gutjahr@gmail.com>
Subject: [PATCH] Malformatted switch statment
Date: Sun, 28 Oct 2018 17:45:46 +0100
Message-ID: <20181028164546.17178-1-joris.gutjahr@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joris Gutjahr <joris.gutjahr@gmail.com>
List-Id: linux-ide@vger.kernel.org

I fixed this coding style error I got after running
checkpatch --file on this file.
The problem was that the whole case block was on one line.

Signed-off-by: Joris Gutjahr <joris.gutjahr@gmail.com>
---
 drivers/ide/amd74xx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
index cbfe846911d1..fa39f279bf53 100644
--- a/drivers/ide/amd74xx.c
+++ b/drivers/ide/amd74xx.c
@@ -273,9 +273,15 @@ static int amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	amd_clock = (ide_pci_clk ? ide_pci_clk : 33) * 1000;
 
 	switch (amd_clock) {
-	case 33000: amd_clock = 33333; break;
-	case 37000: amd_clock = 37500; break;
-	case 41000: amd_clock = 41666; break;
+	case 33000:
+		amd_clock = 33333;
+		break;
+	case 37000:
+		amd_clock = 37500;
+		break;
+	case 41000:
+		amd_clock = 41666;
+		break;
 	}
 
 	if (amd_clock < 20000 || amd_clock > 50000) {
-- 
2.19.1
