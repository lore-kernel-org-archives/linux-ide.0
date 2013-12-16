From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH 0/2] ahci: two fixes for ICH6
Date: Mon, 16 Dec 2013 11:32:22 +0100
Message-ID: <1387189942.9255.27.camel@x41.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

These two fixes were triggered by a warning printed by ahci on an
(outdated) ThinkPad X41. The first one silences that warning on ICH6-M
and ICH6R when running in "combined mode" (which disables ahci support).
The second one makes sure that ahci will only attach for ICH6-M if it's
running in SATA mode.

Tested on top of v3.13-rc4.

Paul Bolle (2):
  ahci: bail out on ICH6 before using AHCI BAR
  ahci: only attach ICH6-M if it's in SATA mode

 drivers/ata/ahci.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

-- 
1.8.1.4
