From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 1/2] libata: allow sata_sil24 to opt-out of tag ordered
 submission
Date: Fri, 16 Jan 2015 15:13:02 -0800
Message-ID: <20150116231302.18771.62862.stgit@viggo.jf.intel.com>
References: <20150116231225.18771.75061.stgit@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20150116231225.18771.75061.stgit@viggo.jf.intel.com>
Sender: stable-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Ronny Hegewald <Ronny.Hegewald@online.de>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Ronny reports: https://bugzilla.kernel.org/show_bug.cgi?id=87101
    "Since commit 8a4aeec8d "libata/ahci: accommodate tag ordered
    controllers" the access to the harddisk on the first SATA-port is
    failing on its first access. The access to the harddisk on the
    second port is working normal.

    When reverting the above commit, access to both harddisks is working
    fine again."

Maintain tag ordered submission as the default, but allow sata_sil24 to
continue with the old behavior.

Cc: <stable@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Reported-by: Ronny Hegewald <Ronny.Hegewald@online.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/ata/libata-core.c |    5 ++++-
 drivers/ata/sata_sil24.c  |    2 +-
 include/linux/libata.h    |    1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5c84fb5c3372..e2085d4b5b93 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4748,7 +4748,10 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 		return NULL;
 
 	for (i = 0, tag = ap->last_tag + 1; i < max_queue; i++, tag++) {
-		tag = tag < max_queue ? tag : 0;
+		if (ap->flags & ATA_FLAG_LOWTAG)
+			tag = i;
+		else
+			tag = tag < max_queue ? tag : 0;
 
 		/* the last tag is reserved for internal command. */
 		if (tag == ATA_TAG_INTERNAL)
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index d81b20ddb527..ea655949023f 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -246,7 +246,7 @@ enum {
 	/* host flags */
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_NCQ | ATA_FLAG_ACPI_SATA |
-				  ATA_FLAG_AN | ATA_FLAG_PMP,
+				  ATA_FLAG_AN | ATA_FLAG_PMP | ATA_FLAG_LOWTAG,
 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2d182413b1db..aba87a3f60bc 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -231,6 +231,7 @@ enum {
 	ATA_FLAG_SW_ACTIVITY	= (1 << 22), /* driver supports sw activity
 					      * led */
 	ATA_FLAG_NO_DIPM	= (1 << 23), /* host not happy with DIPM */
+	ATA_FLAG_LOWTAG		= (1 << 24), /* host wants lowest available tag */
 
 	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
 
