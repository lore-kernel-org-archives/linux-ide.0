From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH v3 0/2] ahci: imx: software workaround for phy reset issue
Date: Sun, 4 May 2014 21:48:04 +0800
Message-ID: <1399211286-8624-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Shawn Guo <shawn.guo@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Changes since v2:
 - Have comment for register definition
 - Use IMX_ instead of IMX_SATA_ for prefix to make it a bit shorter

Shawn Guo (2):
  ahci: imx: add namespace for register enums
  ahci: imx: software workaround for phy reset issue in resume

 drivers/ata/ahci_imx.c | 177 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 170 insertions(+), 7 deletions(-)

-- 
1.8.3.2
