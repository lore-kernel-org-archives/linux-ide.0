From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v2 0/1] ata: ahci_xgene: Enable native NCQ and FBS for second generation of X-Gene SoC.
Date: Mon, 13 Apr 2015 15:02:39 +0530
Message-ID: <1428917560-9142-1-git-send-email-stripathi@apm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>
List-Id: linux-ide@vger.kernel.org

V2 change:
 * Drop the MIDR based implementation as it is wrong.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---

Suman Tripathi (1):
  ata: ahci_xgene: Add AHCI Support for second generation of APM X-Gene
    SoC

 drivers/ata/ahci_xgene.c | 96 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 18 deletions(-)

--
1.8.2.1

