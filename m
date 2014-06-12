From: <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/2] ahci: Add support for 64-bit DMA mask driver
Date: Thu, 12 Jun 2014 12:40:22 -0500
Message-ID: <1402594824-4151-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, b.zolnierkie@samsung.com
Cc: hdegoede@redhat.com, lho@apm.com, tphan@apm.com, stripathi@apm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
List-Id: linux-ide@vger.kernel.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

V2:
	- Changes based on review comments from Hans and Bartlomiej.
	- Remove the logic in ahci_xgene as suggested by Bartlomiej.

Suravee Suthikulpanit (2):
  ata: Check and set 64-bit DMA mask for platform AHCI driver
  ahci/xgene: Remove logic to set 64-bit DMA mask

 drivers/ata/ahci_xgene.c       | 10 ----------
 drivers/ata/libahci_platform.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 10 deletions(-)

-- 
1.9.0
