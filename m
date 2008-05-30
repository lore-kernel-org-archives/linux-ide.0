From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 1/9] pcmcia: add an pata/ide ID
Date: Fri, 30 May 2008 23:31:11 +0200
Message-ID: <1212183079-30505-1-git-send-email-linux@dominikbrodowski.net>
References: <20080530212821.GA30197@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <20080530212821.GA30197@comet.dominikbrodowski.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: linux-pcmcia@lists.infradead.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matt Reimer <mreimer@vpop.net>, Dominik Brodowski <linux@dominikbrodowski.net>, Matt Reimer <mattjreimer@gmail.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Matt Reimer <mattjreimer@gmail.com>

Add an id for:

product info: "M-Systems", "CF300", ""
manfid: 0x000a, 0x0000
function: 4 (fixed disk)

Signed-off-by: Matt Reimer <mreimer@vpop.net>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-ide@vger.kernel.org
---
 drivers/ata/pata_pcmcia.c   |    1 +
 drivers/ide/legacy/ide-cs.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 3d39f9d..c97bc0c 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -414,6 +414,7 @@ static struct pcmcia_device_id pcmcia_devices[] = {
 	PCMCIA_DEVICE_PROD_ID12("IO DATA", "PCIDE", 0x547e66dc, 0x5c5ab149),
 	PCMCIA_DEVICE_PROD_ID12("IO DATA", "PCIDEII", 0x547e66dc, 0xb3662674),
 	PCMCIA_DEVICE_PROD_ID12("LOOKMEET", "CBIDE2      ", 0xe37be2b5, 0x8671043b),
+	PCMCIA_DEVICE_PROD_ID12("M-Systems", "CF300", 0x7ed2ad87, 0x7e9e78ee),
 	PCMCIA_DEVICE_PROD_ID12("M-Systems", "CF500", 0x7ed2ad87, 0x7a13045c),
 	PCMCIA_DEVICE_PROD_ID2("NinjaATA-", 0xebe0bd79),
 	PCMCIA_DEVICE_PROD_ID12("PCMCIA", "CD-ROM", 0x281f1c5d, 0x66536591),
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
index aa2ea3d..8387fc1 100644
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -440,6 +440,7 @@ static struct pcmcia_device_id ide_ids[] = {
 	PCMCIA_DEVICE_PROD_ID12("IO DATA", "PCIDE", 0x547e66dc, 0x5c5ab149),
 	PCMCIA_DEVICE_PROD_ID12("IO DATA", "PCIDEII", 0x547e66dc, 0xb3662674),
 	PCMCIA_DEVICE_PROD_ID12("LOOKMEET", "CBIDE2      ", 0xe37be2b5, 0x8671043b),
+	PCMCIA_DEVICE_PROD_ID12("M-Systems", "CF300", 0x7ed2ad87, 0x7e9e78ee),
 	PCMCIA_DEVICE_PROD_ID12("M-Systems", "CF500", 0x7ed2ad87, 0x7a13045c),
 	PCMCIA_DEVICE_PROD_ID2("NinjaATA-", 0xebe0bd79),
 	PCMCIA_DEVICE_PROD_ID12("PCMCIA", "CD-ROM", 0x281f1c5d, 0x66536591),
-- 
1.5.4.3
