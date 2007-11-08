From: Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH 1/2 take #2] libata: Support PIO polling-only hosts.
Date: Thu, 8 Nov 2007 11:14:56 +0900
Message-ID: <20071108021456.GA30648@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxsh-dev>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxsh-dev-bounces@lists.sourceforge.net
Errors-To: linuxsh-dev-bounces@lists.sourceforge.net
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxsh-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

By default ata_host_activate() expects a valid IRQ in order to
successfully register the host. This patch enables a special case
for registering polling-only hosts that either don't have IRQs
or have buggy IRQ generation (either in terms of handling or
sensing), which otherwise work fine.

Hosts that want to use polling mode can simply set ATA_FLAG_PIO_POLLING
and pass in an invalid IRQ.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 drivers/ata/libata-core.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ec3ce12..89fd0e9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7178,6 +7178,10 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
  *	request IRQ and register it.  This helper takes necessasry
  *	arguments and performs the three steps in one go.
  *
+ *	An invalid IRQ skips the IRQ registration and expects the host to
+ *	have set polling mode on the port. In this case, @irq_handler
+ *	should be NULL.
+ *
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
  *
@@ -7194,6 +7198,12 @@ int ata_host_activate(struct ata_host *host, int irq,
 	if (rc)
 		return rc;
 
+	/* Special case for polling mode */
+	if (!irq) {
+		WARN_ON(irq_handler);
+		return ata_host_register(host, sht);
+	}
+
 	rc = devm_request_irq(host->dev, irq, irq_handler, irq_flags,
 			      dev_driver_string(host->dev), host);
 	if (rc)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
