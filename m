From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH] ahci_xgene: Fix the error print invalid resource for APM X-Gene SoC AHCI SATA Host Controller driver.
Date: Fri, 12 Sep 2014 13:24:07 +0530
Message-ID: <1410508448-25111-1-git-send-email-stripathi@apm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>, Loc Ho <lho@apm.com>
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Suman Tripathi <stripathi@apm.com>
---

Suman Tripathi (1):
  ahci_xgene: Fix the error print invalid resource for APM X-Gene SoC
    AHCI SATA Host Controller driver.

 drivers/ata/ahci_xgene.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--
1.8.2.1

