From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] pata_platform: Fix NULL pointer dereference
Date: Tue, 17 Jul 2007 17:42:52 +0900
Message-ID: <20070717084252.29884.24167.sendpatchset@clockwork.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxsh-dev>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxsh-dev-bounces@lists.sourceforge.net
Errors-To: linuxsh-dev-bounces@lists.sourceforge.net
To: linuxsh-dev@lists.sourceforge.net
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

pata_platform: Fix NULL pointer dereference

The platform-specific structures may leave pdev->dev.platform_data as NULL.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested on a Solution Engline 7722
 Applies to git linux-2.6 a5fcaa210626a79465321e344c91a6a7dc3881fa

 drivers/ata/pata_platform.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- 0001/drivers/ata/pata_platform.c
+++ work/drivers/ata/pata_platform.c	2007-07-17 15:01:09.000000000 +0900
@@ -213,8 +213,9 @@ static int __devinit pata_platform_probe
 	pata_platform_setup_port(&ap->ioaddr, pp_info);
 
 	/* activate */
-	return ata_host_activate(host, platform_get_irq(pdev, 0), ata_interrupt,
-				 pp_info->irq_flags, &pata_platform_sht);
+	return ata_host_activate(host, platform_get_irq(pdev, 0), 
+				 ata_interrupt, pp_info ? pp_info->irq_flags
+				 : 0, &pata_platform_sht);
 }
 
 /**

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
