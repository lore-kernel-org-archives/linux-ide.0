From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] ata: ahci: Enable DEVSLP by default on SLP_S0 support
Date: Thu, 19 Jul 2018 17:01:54 -0700
Message-ID: <20180720000156.77759-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, hdegoede@redhat.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan.cox@intel.com, Mario.Limonciello@dell.com, rjw@rjwysocki.net, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

One of the requirement for modern x86 system to enter lowest power mode
(SLP_S0) is SATA IP block to be off. This is true even during when
platform is suspended to idle and not only in opportunistic (runtime)
suspend.
This series is to enable DEVSLP by default.

-current (non-rfc) series
Implemented suggestions from Hans
- no override of policy set via module param
- Overide lpm policy per host not global policy
- changed the new policy name to "min_power_with_partial"

rfc-v2
- As suggested by Hans, it is possible to have ASP with DEVSLP, so
add a new state.
- Removed usage of mem_sleep_current, instead just rely on low power
idle flag. Don't feel good to EXPORT from core suspend code.
- Depending host policy to decide if we enable DEVSLP by default.

Srinivas Pandruvada (2):
  ata: ahci: Support state with min power but Partial low power state
  ata: ahci: Enable DEVSLP by default on x86 with SLP_S0

 drivers/ata/ahci.c        | 33 +++++++++++++++++++++++++++++----
 drivers/ata/libahci.c     |  6 +++++-
 drivers/ata/libata-core.c |  1 +
 drivers/ata/libata-scsi.c |  1 +
 include/linux/libata.h    |  3 ++-
 5 files changed, 38 insertions(+), 6 deletions(-)

-- 
2.17.1
