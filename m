From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 Resend 1/3] ata: pata_arasan: Add clk_{un}prepare() support
Date: Mon, 27 Aug 2012 10:37:17 +0530
Message-ID: <5c456890071e05817fa762e3e52ed5aa90f06bcd.1346042344.git.viresh.kumar@linaro.com>
References: <cover.1346042344.git.viresh.kumar@linaro.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33940 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab2H0FH0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Aug 2012 01:07:26 -0400
In-Reply-To: <cover.1346042344.git.viresh.kumar@linaro.com>
In-Reply-To: <cover.1346042344.git.viresh.kumar@linaro.com>
References: <cover.1346042344.git.viresh.kumar@linaro.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com, spear-devel@list.st.com, viresh.linux@gmail.com, Viresh Kumar <viresh.kumar@linaro.com>

From: Viresh Kumar <viresh.kumar@linaro.com>

clk_{un}prepare is mandatory for platforms using common clock framework. Si=
nce
this driver is used by SPEAr platform, which supports common clock framewor=
k,
add clk_{un}prepare() support for it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.com>
---
 drivers/ata/pata_arasan_cf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index bfaa5cb..d82c6dc 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -310,7 +310,7 @@ static int cf_init(struct arasan_cf_dev *acdev)
 =09unsigned long flags;
 =09int ret =3D 0;
=20
-=09ret =3D clk_enable(acdev->clk);
+=09ret =3D clk_prepare_enable(acdev->clk);
 =09if (ret) {
 =09=09dev_dbg(acdev->host->dev, "clock enable failed");
 =09=09return ret;
@@ -340,7 +340,7 @@ static void cf_exit(struct arasan_cf_dev *acdev)
 =09writel(readl(acdev->vbase + OP_MODE) & ~CFHOST_ENB,
 =09=09=09acdev->vbase + OP_MODE);
 =09spin_unlock_irqrestore(&acdev->host->lock, flags);
-=09clk_disable(acdev->clk);
+=09clk_disable_unprepare(acdev->clk);
 }
=20
 static void dma_callback(void *dev)
--=20
1.7.12.rc2.18.g61b472e


