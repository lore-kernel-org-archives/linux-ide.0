From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [RFC PATCH 0/2] Introduce ACPI support for ahci_platform driver
Date: Wed, 17 Dec 2014 17:16:33 -0600
Message-ID: <1418858195-22857-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, arnd@arndb.de, mjg59@srcf.ucam.org
Cc: hanjun.guo@linaro.org, leo.duran@amd.com, graeme.gregory@linaro.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
List-Id: linux-ide@vger.kernel.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch series introduce ACPI support for non-PCI AHCI platform driver.
Existing ACPI support for AHCI assumes the device controller is a PCI device.

Also, since there is no ACPI _HID/_CID for generic AHCI controller, the driver
could not use them for matching devices. Therefore, this patch introduces a mechanism
for drivers to match devices using ACPI _CLS method.

This patch series is rebased from:

    http://git.linaro.org/leg/acpi/acpi.git acpi-5.1-v6

This topic was discussed earlier here (as part of introducing support for
AMD Seattle SATA controller):

    http://marc.info/?l=linux-arm-kernel&m=141083492521584&w=2

Suravee Suthikulpanit (2):
  ACPI / scan: Add support for ACPI _CLS device matching
  ata: ahci_platform: Add ACPI _CLS matching

 drivers/acpi/scan.c             | 73 +++++++++++++++++++++++++++++++++++++++++
 drivers/ata/Kconfig             |  2 +-
 drivers/ata/ahci_platform.c     | 10 ++++++
 include/acpi/acnames.h          |  1 +
 include/linux/acpi.h            | 12 ++++++-
 include/linux/device.h          |  1 +
 include/linux/mod_devicetable.h |  6 ++++
 7 files changed, 103 insertions(+), 2 deletions(-)

-- 
1.9.3
