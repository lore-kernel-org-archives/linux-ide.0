From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/10] libata: power down controller only on PMSG_SUSPEND
Date: Tue, 13 Jun 2006 00:50:28 +0900
Message-ID: <11501274283030-git-send-email-htejun@gmail.com>
References: <11501274284082-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:56440 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752076AbWFLPue (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 11:50:34 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1663627nze
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 08:50:34 -0700 (PDT)
In-Reply-To: <11501274284082-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

The controller only needs to be powered down on PMSG_SUSPEND.  Skip
powering down for all other messages.  This makes disk suspend prep
cycle more efficient and helps controllers which have problems waking
up from D3hot without intervening power removal.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

85016ad86323924d10dc99ac9d7e9e5c0b967b8e
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9a3bd15..51d3b4b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5661,7 +5661,10 @@ int ata_pci_device_suspend(struct pci_de
 {
 	pci_save_state(pdev);
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, PCI_D3hot);
+
+	if (state.event == PM_EVENT_SUSPEND)
+		pci_set_power_state(pdev, PCI_D3hot);
+
 	return 0;
 }
 
-- 
1.3.2


