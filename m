From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot on
 parisc
Date: Mon, 18 Apr 2011 13:42:27 -0500
Message-ID: <1303152147.7167.12.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

currently libata-sff is completely ignoring the enabled/disabled status
of the interfaces.  This is a real problem on parisc because if you
touch a non responding memory area (i.e. a disabled interface) you crash
the box.

Fix this up by restoring the enablebits logic to the pata_cmd64x driver.
To do this, libata-sff has to be modified not to probe both ports if we
don't have them.  This is done by reintroducing IDE_HFLAG_SINGLE flag as
ATA_HOST_SFF_SINGLE_PORT which drivers can use to condition libata-sff
port probing.

James

---

James Bottomley (2):
  libata-sff: remove hardcoded requirement for two ports
  pata_cmd64x: fix crash on boot with disabled secondary port

 drivers/ata/libata-sff.c  |   75 ++++++++++++++++++++++++++++++++------------
 drivers/ata/pata_cmd64x.c |   22 +++++++++++--
 include/linux/libata.h    |    1 +
 3 files changed, 74 insertions(+), 24 deletions(-)

-- 
1.7.4.1



