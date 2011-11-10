From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: [PATCH 1/2] of/irq: Get rid of NO_IRQ usage
Date: Thu, 10 Nov 2011 19:25:41 +0400
Message-ID: <20111110152541.GA3207@oksana.dev.rtsoft.ru>
References: <20111110151852.GA7465@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111110151852.GA7465@oksana.dev.rtsoft.ru>
Sender: linux-next-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@redhat.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

PPC32/64 defines NO_IRQ to zero, so no problems expected.
ARM defines NO_IRQ to -1, but OF code relies on IRQ domains support,
which returns correct ('0') value in 'no irq' case. So everything
should be fine.

Other arches might break if some of their OF drivers rely on NO_IRQ
being not 0. If so, the drivers must be fixed, finally.

Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/of/irq.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 6d3dd39..2dd4937 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -26,11 +26,6 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 
-/* For archs that don't support NO_IRQ (such as x86), provide a dummy value */
-#ifndef NO_IRQ
-#define NO_IRQ 0
-#endif
-
 /**
  * irq_of_parse_and_map - Parse and map an interrupt into linux virq space
  * @device: Device node of the device whose interrupt is to be mapped
@@ -42,12 +37,23 @@
 unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
 {
 	struct of_irq oirq;
+	int ret = 0;
 
 	if (of_irq_map_one(dev, index, &oirq))
-		return NO_IRQ;
-
-	return irq_create_of_mapping(oirq.controller, oirq.specifier,
-				     oirq.size);
+		goto no_irq;
+
+	ret = irq_create_of_mapping(oirq.controller, oirq.specifier,
+				    oirq.size);
+no_irq:
+#ifdef NO_IRQ
+#if NO_IRQ != 0
+	if (ret == NO_IRQ)
+		pr_warn("Hit NO_IRQ case for your arch. Drivers might expect "
+			"NO_IRQ, but we return 0. If anything breaks, driver "
+			"have to be fixed.\n");
+#endif
+#endif
+	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
 
@@ -345,7 +351,7 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 
 	/* Only dereference the resource if both the
 	 * resource and the irq are valid. */
-	if (r && irq != NO_IRQ) {
+	if (r && irq) {
 		r->start = r->end = irq;
 		r->flags = IORESOURCE_IRQ;
 		r->name = dev->full_name;
@@ -363,7 +369,7 @@ int of_irq_count(struct device_node *dev)
 {
 	int nr = 0;
 
-	while (of_irq_to_resource(dev, nr, NULL) != NO_IRQ)
+	while (of_irq_to_resource(dev, nr, NULL))
 		nr++;
 
 	return nr;
@@ -383,7 +389,7 @@ int of_irq_to_resource_table(struct device_node *dev, struct resource *res,
 	int i;
 
 	for (i = 0; i < nr_irqs; i++, res++)
-		if (of_irq_to_resource(dev, i, res) == NO_IRQ)
+		if (!of_irq_to_resource(dev, i, res))
 			break;
 
 	return i;
-- 
1.7.5.3
