From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] ata: libahci: devslp fixes
Date: Mon,  2 Jul 2018 12:01:52 -0700
Message-ID: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, hdegoede@redhat.com
Cc: rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

Some minor fixes to be able to correctly set devslp register
to optimize power.

Srinivas Pandruvada (2):
  ata: libahci: Correct setting of DEVSLP register
  ata: libahci: Allow reconfigure of DEVSLP register

 drivers/ata/libahci.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.17.1
