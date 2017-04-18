From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] SATA: Fine-tuning for two function implementations
Date: Tue, 18 Apr 2017 22:00:37 +0200
Message-ID: <df754c7a-2100-7169-0d40-b981ccd952a1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 18 Apr 2017 21:54:32 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Use kcalloc() in ahci_platform_get_resources()
  Use devm_kcalloc() in ahci_platform_get_resources()
  Use devm_kcalloc() in mv_platform_probe()

 drivers/ata/libahci_platform.c | 11 ++++++-----
 drivers/ata/sata_mv.c          | 10 ++++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.12.2
