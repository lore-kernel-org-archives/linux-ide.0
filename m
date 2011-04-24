From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot on
 parisc
Date: Sun, 24 Apr 2011 14:28:34 -0500
Message-ID: <1303673315.5231.9.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@mvista.com>
List-Id: linux-ide@vger.kernel.org

currently libata-sff is completely ignoring the enabled/disabled status
of the interfaces.  This is a real problem on parisc because if you
touch a non responding memory area (i.e. a disabled interface) you crash
the box.

Fix by checking the CNTRL bits to see if the port is enabled before
trying to poke it.

James

---

James Bottomley (2):
  pata_cm64x: fix boot crash on parisc
  libata-sff: prevent irq descriptions for dummy ports

 drivers/ata/libata-sff.c  |    9 +++++++--
 drivers/ata/pata_cmd64x.c |   42 ++++++++++++++++++++++++++++++++++++++----
 include/linux/pci_ids.h   |    2 ++
 3 files changed, 47 insertions(+), 6 deletions(-)

-- 
1.7.4.1



