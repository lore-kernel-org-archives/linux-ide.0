From: Doug Berger <opendmb@gmail.com>
Subject: [PATCH 0/3] libata: prevent writes to read-only registers
Date: Wed, 21 Jun 2017 16:20:11 -0700
Message-ID: <20170621232014.27790-1-opendmb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:32962 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbdFUXUf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jun 2017 19:20:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>

Recent Broadcom SoCs allow for the trapping of write accesses to
read-only registers. This is only useful if such accesses are
exceptional, so it is desirable to prevent such accesses in normal
operation. To that end, this set of commits proposes adding two
flags to the libata core.

The first allows for a quirk that exists in some Broadcom devices
that are capable of supporting Aggresive Link Power Management even
though it is not reported by their read-only capability register.
This removes a need for the Broadcom driver to write to it's
read-only capability register.

The second is a notification to the libata-core that it should not
write to any standard registers that are defined to be read-only.

The Broadcom driver is then modified to use these two general 
purpose flags.

Doug Berger (3):
  libata: Add the AHCI_HFLAG_YES_ALPM flag
  libata: Add the AHCI_HFLAG_NO_WRITE_TO_RO flag
  ata: ahci_brcm: Avoid writing to read-only registers

 drivers/ata/ahci.h      |  3 +++
 drivers/ata/ahci_brcm.c | 12 ++++--------
 drivers/ata/libahci.c   |  8 +++++++-
 3 files changed, 14 insertions(+), 9 deletions(-)

-- 
2.13.0

