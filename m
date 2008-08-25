From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.27-rc3: IP: [<ffffffffa0038b77>] init_irq+0x18d/0x31c
	[ide_core]
Date: Mon, 25 Aug 2008 14:02:41 +0300
Message-ID: <20080825110241.GI2606@deprecation.cyrius.com>
References: <20080820173122.GA7335@deprecation.cyrius.com>
	<48AC71D7.8050604@lwfinger.net>
	<20080821161610.GA2640@deprecation.cyrius.com>
	<48ADA743.1070000@lwfinger.net>
	<20080821175215.GI2640@deprecation.cyrius.com>
	<48ADAC7C.7040003@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <48ADAC7C.7040003@lwfinger.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-ide@vger.kernel.org

* Larry Finger <Larry.Finger@lwfinger.net> [2008-08-21 12:57]:
> Do you have a git tree, or have you downloaded snapshots? If the
> former, a bisection would be useful.

I've bisected it down to this change: ide: set hwif->dev in ide_init_port_hw() (take 2)
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c56c5648a3bd15ff14c50f284b261140cd5b5472

I cannot revert this from current git because there were too many
changes but when I go to 5b664cb235e97afbf34db9c4d77f08ebd725335e (a
random point that shows the oops) and apply the following (which is
basically a partial revert of the c56c5648a3bd15ff14c50f284b261140cd5b5472)
then it works:

--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -284,7 +284,6 @@ void ide_init_port_hw(ide_hwif_t *hwif, hw_regs_t *hw)
 	memcpy(&hwif->io_ports, &hw->io_ports, sizeof(hwif->io_ports));
 	hwif->irq = hw->irq;
 	hwif->chipset = hw->chipset;
-	hwif->dev = hw->dev;
 	hwif->gendev.parent = hw->parent ? hw->parent : hw->dev;
 	hwif->ack_intr = hw->ack_intr;
 }
diff --git a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
index 65fc08b..187b7b1 100644
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -339,6 +339,8 @@ static ide_hwif_t *ide_hwif_configure(struct pci_dev *dev,
 
 	ide_init_port_hw(hwif, &hw);
 
+	hwif->dev = &dev->dev;
+
 	return hwif;
 }
 

-- 
Martin Michlmayr
http://www.cyrius.com/
