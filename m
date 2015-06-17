From: Robert Richter <robert.richter@caviumnetworks.com>
Subject: [PATCH] ahci, msix: Fix build error for !PCI_MSI
Date: Wed, 17 Jun 2015 10:48:52 +0200
Message-ID: <20150617084852.GL4914@rric.localhost>
References: <1433526566-21136-1-git-send-email-rric@kernel.org>
 <20150616132434.GO10428@rric.localhost>
 <20150616201341.GD22637@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150616201341.GD22637@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Richter <rric@kernel.org>, Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org
List-Id: linux-ide@vger.kernel.org

=46rom fd984f3be22f27b8d3c4cf577dbbf0a39792ea89 Mon Sep 17 00:00:00 200=
1
=46rom: Robert Richter <rrichter@cavium.com>
Date: Wed, 17 Jun 2015 10:33:22 +0200
Subject: [PATCH] ahci, msix: Fix build error for !PCI_MSI
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

=46ixing a build error if PCI_MSI is unset:

 drivers/ata/ahci.c: In function =E2=80=98msix_get_desc=E2=80=99:
 drivers/ata/ahci.c:1210:2: error: =E2=80=98struct pci_dev=E2=80=99 has=
 no member named =E2=80=98msi_list=E2=80=99

Catched by Fengguang's build bot.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/ata/ahci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index bdedaa4f9d7b..99cc9526ae95 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1205,13 +1205,14 @@ static inline void ahci_gtf_filter_workaround(s=
truct ata_host *host)
=20
 static struct msi_desc *msix_get_desc(struct pci_dev *dev, u16 entry)
 {
+#ifdef CONFIG_PCI_MSI
 	struct msi_desc *desc;
=20
 	list_for_each_entry(desc, &dev->msi_list, list) {
 		if (desc->msi_attrib.entry_nr =3D=3D entry)
 			return desc;
 	}
-
+#endif
 	return NULL;
 }
=20
--=20
2.1.1
