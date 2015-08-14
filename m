From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] arm: cerfcube_defconfig: disable IDE subsystem
Date: Fri, 14 Aug 2015 19:04:19 +0200
Message-ID: <1439571876-13758-4-git-send-email-b.zolnierkie@samsung.com>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, b.zolnierkie@samsung.com, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>
List-Id: linux-ide@vger.kernel.org

This patch disables deprecated IDE subsystem in cerfcube_defconfig
(no IDE host drivers are selected in this config so there is no
valid reason to enable IDE subsystem itself).

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/cerfcube_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/cerfcube_defconfig b/arch/arm/configs/cerfcube_defconfig
index dce912d..57a2a18 100644
--- a/arch/arm/configs/cerfcube_defconfig
+++ b/arch/arm/configs/cerfcube_defconfig
@@ -39,7 +39,6 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_SA1100=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_RAM=m
-CONFIG_IDE=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_NET_PCI=y
-- 
1.9.1
