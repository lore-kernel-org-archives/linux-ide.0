From: jozwicki <jozwicki@aster.pl>
Subject: Acer Aspire 3682 with ICH7 can't be configured to use UDMA66 and higher
Date: Fri, 10 Nov 2006 01:19:45 +0100 (CET)
Message-ID: <537ECE143B86EB78CF020C3E1BDBB56E11631179808E38F5CD54641F3F30@webmail.aster.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail0.aster.pl ([212.76.33.39]:1610 "EHLO mail0.astercity.net")
	by vger.kernel.org with ESMTP id S1424303AbWKJATr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Nov 2006 19:19:47 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: alan@redhat.com

Hello,
Acer Aspire 3682 with ICH7 can't be configured to use UDMA66 and
higher. It appears that it has got short 40-pins ATA cable for hard
disk. Register 0x54 is 0.

I've looked at
http://marc.theaimsgroup.com/?l=linux-ide&m=115618757116620&w=2
and similary written fix for drivers/ide/pci/piix.c.
Because libata 2.0 is not in linux 2.6.18, this fix may be usefull for
some people.


Regards,
Jakub Jozwicki

--- CUT ---

--- linux-2.6.16.21SLERT10/drivers/ide/pci/piix.c	2006-04-25
23:03:47.000000000 +0200
+++ linux-2.6.16.21-0.25/drivers/ide/pci/piix.c	2006-11-10
00:47:27.223832134 +0100
@@ -431,8 +431,23 @@
*	out to be nice and simple
*/

+struct ich_laptop {
+	u16 device;
+	u16 subvendor;
+	u16 subdevice;
+};
+
+static const struct ich_laptop ich_laptop[] = {
+	/* devid, subvendor, subdev */
+        { 0x27df, 0x1025, 0x0110 },	/* ICH7 on Acer Aspire 3682 WLMi
*/
+	/* end marker */
+	{ 0, }
+};
+
static unsigned int __devinit init_chipset_piix (struct pci_dev *dev,
const char *name)
{
+	const struct ich_laptop *lap = &ich_laptop[0];
+
switch(dev->device) {
case PCI_DEVICE_ID_INTEL_82801EB_1:
case PCI_DEVICE_ID_INTEL_82801AA_1:
@@ -454,6 +469,19 @@
{
unsigned int extra = 0;
pci_read_config_dword(dev, 0x54, &extra);
+
+			/* Fix UDMA66 capabilities on Acer Aspire */
+			while (!extra && lap->device) {
+			    if (lap->device == dev->device &&
+				lap->subvendor == dev->subsystem_vendor &&
+				lap->subdevice == dev->subsystem_device)
+			    {
+				extra = 0xf0;
+				printk(KERN_WARNING "ICH7 laptop detected, setting register 0x54
to 0x4f0\n");
+			    }
+			    lap++;
+			}
+
pci_write_config_dword(dev, 0x54, extra|0x400);
}
default:

---- CUT -----

