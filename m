From: Rado Vrbovsky <rvrbovsk@redhat.com>
Subject: [PATCH] ata_piix: Add MODULE_PARM_DESC to prefer_ms_hyperv
Date: Thu, 21 Feb 2013 12:43:01 -0500 (EST)
Message-ID: <693649786.7135156.1361468581077.JavaMail.root@redhat.com>
References: <1619122110.7061314.1361463977742.JavaMail.root@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1619122110.7061314.1361463977742.JavaMail.root@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff <jgarzik@redhat.com>
List-Id: linux-ide@vger.kernel.org

From: Andrew Brownfield <abrownfi@redhat.com>

In reference to the commit cd006086fa5d91414d8ff9ff2b78fbb593878e3c
this trivial patch adds a description to prefer_ms_hyperv.

[rvrbovsk@redhat.com: MODULE_PARM_DESC() string formatting modified]

Signed-off-by: Radomir Vrbovsky <rvrbovsk@redhat.com>

---
 drivers/ata/ata_piix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 174eca6..b9bf99a 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1530,6 +1530,10 @@ static bool piix_broken_system_poweroff(struct pci_dev *pdev)
 
 static int prefer_ms_hyperv = 1;
 module_param(prefer_ms_hyperv, int, 0);
+MODULE_PARM_DESC(prefer_ms_hyperv,
+       "Prefer Hyper-V paravirtualization drivers instead of ATA, "
+       "0 - Use ATA drivers, "
+       "1 (Default) - Use the paravirtualization drivers.");
 
 static void piix_ignore_devices_quirk(struct ata_host *host)
 {
-- 
1.7.11.7
