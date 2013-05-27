From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 0/3] Optimize R-Car SATA driver
Date: Tue, 28 May 2013 02:38:17 +0400
Message-ID: <201305280238.17867.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

   Here's the set of 3 patches against the Tejun Heo's 'libata.git' repo's
'for-3.11' branch.
   They deal with some shortcomings in the R-Car SATA driver and generally
optimize it. I've come up with them while trying to add NCQ support to this
driver.

[1/3] sata_rcar: kill superfluous code in sata_rcar_bmdma_fill_sg()
[2/3] sata_rcar: correct 'sata_rcar_sht'
[3/3] sata_rcar: add 'base' local variable to some functions

MBR, Sergei
