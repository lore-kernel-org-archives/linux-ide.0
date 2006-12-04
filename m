From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] add delay around sl82c105_reset_engine calls
Date: Mon, 4 Dec 2006 13:40:26 +0100 (MET)
Message-ID: <20061204124026.GB28159@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20061130165202.GA23205@aepfle.de>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org



the hald media changed polling does really confuse things.
noone knows why the delays are needed, but they give us access to
the CD.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/scsi/pata_sl82c105.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/scsi/pata_sl82c105.c
+++ b/drivers/scsi/pata_sl82c105.c
@@ -187,7 +187,9 @@ static void sl82c105_bmdma_start(struct 
 {
 	struct ata_port *ap = qc->ap;
 
+	udelay(50);
 	sl82c105_reset_engine(ap);
+	udelay(50);
 
 	/* Set the clocks for DMA */
 	sl82c105_configure_dmamode(ap, qc->dev);
@@ -216,6 +218,7 @@ static void sl82c105_bmdma_stop(struct a
 
 	ata_bmdma_stop(qc);
 	sl82c105_reset_engine(ap);
+	udelay(50);
 
 	/* This will redo the initial setup of the DMA device to matching
 	   PIO timings */
