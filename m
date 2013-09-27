From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [PATCH v1 0/1] ahci: imx: setup power saving methods
Date: Fri, 27 Sep 2013 16:07:44 +0800
Message-ID: <1380269265-10821-1-git-send-email-Hong-Xing.Zhu@freescale.com>
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
To: shawn.guo@linaro.org
Cc: tj@kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

In order to save power consumption amap.
* Disable sata phy internal pll reference clock when
sysetem enter into suspend mode, enable it after resume.
* Enter into test power down mode when there is no sata disk
detected on the port and 'AHCI_IMX_PHY_POWER_DOWN_MODE' is
enabled.

[v1] ahci: imx: setup power saving methods

drivers/ata/Kconfig    |    8 +++++
drivers/ata/ahci_imx.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++--
2 files changed, 83 insertions(+), 3 deletions(-)
