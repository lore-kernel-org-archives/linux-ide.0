From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] Re: AHCI: support for tf_read (RFC)
Date: Fri, 25 Feb 2005 18:19:14 -0500
Message-ID: <421FB272.4030502@pobox.com>
References: <20050224232413.4869514FC5@lns1032.lss.emc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040708070305060202030109"
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45786 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262794AbVBYXTe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Feb 2005 18:19:34 -0500
In-Reply-To: <20050224232413.4869514FC5@lns1032.lss.emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org, ric@emc.com

This is a multi-part message in MIME format.
--------------040708070305060202030109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Brett Russ wrote:
> I coded this because ata_pass_thru_cc() (in the dev branch) and other
> functions call tf_read() which is supported for most except ahci.
> I've been unable to test because I'm leaving on vacation and am in a
> last minute rush but wanted to get this out there for comments.
> 
> Signed-off-by: Brett Russ <russb@emc.com>

I checked the attached patch into a local repository, but haven't yet 
merged it into libata-dev-2.6, or tested it.

	Jeff



--------------040708070305060202030109
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/25 18:18:09-05:00 jgarzik@pobox.com 
#   [libata ahci] support ->tf_read hook
# 
# drivers/scsi/ahci.c
#   2005/02/25 18:18:03-05:00 jgarzik@pobox.com +11 -0
#   [libata ahci] support ->tf_read hook
# 
diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2005-02-25 18:18:23 -05:00
+++ b/drivers/scsi/ahci.c	2005-02-25 18:18:23 -05:00
@@ -177,6 +177,7 @@
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
 static void ahci_host_stop(struct ata_host_set *host_set);
+static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
 static u8 ahci_check_err(struct ata_port *ap);
@@ -209,6 +210,8 @@
 	.check_err		= ahci_check_err,
 	.dev_select		= ata_noop_dev_select,
 
+	.tf_read		= ahci_tf_read,
+
 	.phy_reset		= ahci_phy_reset,
 
 	.qc_prep		= ahci_qc_prep,
@@ -460,6 +463,14 @@
 	void *mmio = (void *) ap->ioaddr.cmd_addr;
 
 	return (readl(mmio + PORT_TFDATA) >> 8) & 0xFF;
+}
+
+static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
+
+	ata_tf_from_fis(d2h_fis, tf);
 }
 
 static void ahci_fill_sg(struct ata_queued_cmd *qc)

--------------040708070305060202030109--
