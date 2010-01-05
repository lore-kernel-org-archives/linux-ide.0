From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] add PATA host controller support for Cirrus Logic's
	EP93xx CPUs
Date: Tue, 5 Jan 2010 19:56:50 +0100
Message-ID: <201001051956.50961.bzolnier@gmail.com>
References: <200911261651.40928.bzolnier@gmail.com>
	<4B26B0D6.4080809@bluewatersys.com> <4B26B6EA.8050403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4B26B6EA.8050403@garzik.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jeff Garzik <jeff@garzik.org>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Ryan Mallon <ryan@bluewatersys.com>, Sergei Shtylyov <sshtylyov@ru.montavista.com>, Joao Ramos <joao.ramos@inov.pt>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Monday 14 December 2009 11:06:34 pm Jeff Garzik wrote:
> On 12/14/2009 04:40 PM, Ryan Mallon wrote:
> > I have added some of my own debugging. The problem appears to be that
> > __pata_ep93xx_write gets called from probe (via ata_host_activate), but
> > ap->private_data (ata_timing) is still null. The timing private_data is
> > set by pata_ep93xx_set_piomode, but that needs adev->pio_mode set, but I
> > don't know where this happens. I assume the ATA core handles this. Do I
> > need to call pata_ep93xx_set_piomode from pata_ep93xx_probe before
> > ata_host_activate, or should the private_data timing be set to some
> > default in the probe?
> 
> 
> ap->private_data is traditionally initialized in the ->port_start() hook.

Ryan, this incremental patch should fix the OOPS (it adds ->port_start
implementation which sets the default 'port PIO mode' to PIO0 so we have
sane default setting before device probing takes place and ->set_piomode
takes over), please retest the driver once you have a minute..

[ Thanks for debugging the problem and sorry for the delay.. ]

---
 drivers/ata/pata_ep93xx.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: b/drivers/ata/pata_ep93xx.c
===================================================================
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -613,6 +613,15 @@ static void pata_ep93xx_postreset(struct
 	}
 }
 
+static int pata_ep93xx_port_start(struct ata_port *ap)
+{
+	const struct ata_timing *cmd_t = ata_timing_find_mode(XFER_PIO_0);
+
+	ap->private_data = (void *)cmd_t;
+
+	return ata_sff_port_start(ap);
+}
+
 static struct ata_port_operations pata_ep93xx_port_ops = {
 	.inherits		= &ata_sff_port_ops,
 
@@ -631,6 +640,8 @@ static struct ata_port_operations pata_e
 	.freeze			= pata_ep93xx_freeze,
 	.softreset		= pata_ep93xx_softreset,
 	.postreset		= pata_ep93xx_postreset,
+
+	.port_start		= pata_ep93xx_port_start,
 };
 
 static int __init pata_ep93xx_probe(struct platform_device *pdev)
