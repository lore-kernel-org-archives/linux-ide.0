From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH 1/2] ahci: bail out on ICH6 before using AHCI BAR
Date: Mon, 16 Dec 2013 11:34:21 +0100
Message-ID: <1387190061.9255.30.camel@x41.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The check for "combined mode" (which disables ahci support) on ICH6 is
done after the first use of AHCI BAR. But if ahci is not enabled AHCI
BAR is initialized to 0x00000000. (At least it is on the ICH6-M I tested
this on. If I understand the datasheet correctly it should also be on
ICH6R.) This apparently makes the call of
pcim_iomap_regions_request_all() return -EINVAL. And we end up with
    ahci: probe of 0000:00:1f.2 failed with error -22

(at warning level) in the logs.

So check for "combined mode" before calling
pcim_iomap_regions_request_all().

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested on a laptop that always uses ICH6-M in "combined mode" (so with
ahci support disabled). I don't think I have any hardware with an ICH6R.

 drivers/ata/ahci.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b55c88d..4ba3bde 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1238,15 +1238,6 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	/* AHCI controllers often implement SFF compatible interface.
-	 * Grab all PCI BARs just in case.
-	 */
-	rc = pcim_iomap_regions_request_all(pdev, 1 << ahci_pci_bar, DRV_NAME);
-	if (rc == -EBUSY)
-		pcim_pin_device(pdev);
-	if (rc)
-		return rc;
-
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 	    (pdev->device == 0x2652 || pdev->device == 0x2653)) {
 		u8 map;
@@ -1264,6 +1255,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
+	/* AHCI controllers often implement SFF compatible interface.
+	 * Grab all PCI BARs just in case.
+	 */
+	rc = pcim_iomap_regions_request_all(pdev, 1 << ahci_pci_bar, DRV_NAME);
+	if (rc == -EBUSY)
+		pcim_pin_device(pdev);
+	if (rc)
+		return rc;
+
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv)
 		return -ENOMEM;
-- 
1.8.1.4
