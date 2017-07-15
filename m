From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 08/11] ata: Drop unnecessary static
Date: Sat, 15 Jul 2017 22:07:43 +0200
Message-ID: <1500149266-32357-9-git-send-email-Julia.Lawall@lip6.fr>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Drop static on a local variable, when the variable is initialized before
any possible use.  Thus, the static has no benefit.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@bad exists@
position p;
identifier x;
type T;
@@
static T x@p;
...
x = <+...x...+>

@@
identifier x;
expression e;
type T;
position p != bad.p;
@@
-static
 T x@p;
 ... when != x
     when strict
?x = e;
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
These patches are all independent of each other.

 drivers/ata/sata_gemini.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -305,7 +305,7 @@ static int gemini_sata_probe(struct plat
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct sata_gemini *sg;
-	static struct regmap *map;
+	struct regmap *map;
 	struct resource *res;
 	enum gemini_muxmode muxmode;
 	u32 gmode;
