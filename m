From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH] drivers/ata/pata_scc.c: compile error fix
Date: Wed, 09 May 2007 15:14:00 +0900
Message-ID: <200705090612.l496CGfm013469@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org

The previous change (ata_probe_ent -> ata_host) was incomplete
and generated compile error. This patch fix it.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

diff -purN -X linux-powerpc-git/Documentation/dontdiff linux-powerpc-git/drivers/ata/pata_scc.c linux-powerpc-git_mod/drivers/ata/pata_scc.c
--- linux-powerpc-git/drivers/ata/pata_scc.c	2007-05-08 09:41:52.000000000 +0900
+++ linux-powerpc-git_mod/drivers/ata/pata_scc.c	2007-05-09 14:13:15.000000000 +0900
@@ -1142,14 +1142,14 @@ static int scc_init_one (struct pci_dev 
 	static int printed_version;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	const struct ata_port_info *ppi[] = { &scc_port_info[board_idx], NULL };
-	struct device *dev = &pdev->dev;
+	struct ata_host *host;
 	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	host = ata_port_alloc_pinfo(&pdev->dev, ppi, 1);
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 1);
 	if (!host)
 		return -ENOMEM;
