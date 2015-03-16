From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 14/35 linux-next] ide: pmac: constify of_device_id array
Date: Mon, 16 Mar 2015 20:20:30 +0100
Message-ID: <1426533651-25586-5-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533651-25586-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426533651-25586-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/ide/pmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index 2db803c..fcf860f 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1370,7 +1370,7 @@ static void pmac_ide_macio_mb_event(struct macio_dev* mdev, int mb_state)
 #endif /* CONFIG_PMAC_MEDIABAY */
 
 
-static struct of_device_id pmac_ide_macio_match[] = 
+static const struct of_device_id pmac_ide_macio_match[] =
 {
 	{
 	.name 		= "IDE",
-- 
2.1.0
