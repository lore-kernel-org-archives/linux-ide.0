From: Komuro <komurojun-mbn@nifty.com>
Subject: Re: [KERNEL 2.6.26-rc4]  bugreport : pata_pcmcia with Sandisk
	Extreme III 8GB
Date: Mon, 7 Jul 2008 21:42:53 +0900
Message-ID: <20080707214253.2406f81a.komurojun-mbn@nifty.com>
References: <20080528225049.9a134e0d.Kristoffer.Ericson@Gmail.com>
	<20080528222740.GB20893@isilmar.linta.de>
	<20080530135728.be02d3dc.Kristoffer.Ericson@Gmail.com>
	<20080607223716.7d142072.komurojun-mbn@nifty.com>
	<20080611072029.GB28692@comet.dominikbrodowski.net>
	<20080614120055.ad8fbee0.komurojun-mbn@nifty.com>
	<48537149.4040102@garzik.org>
	<20080614213612.96873c25.komurojun-mbn@nifty.com>
	<4855D8E2.10409@gmail.com>
	<20080616221145.e3b069b9.komurojun-mbn@nifty.com>
	<485669A0.6000404@gmail.com>
	<20080617212345.c452d8c5.komurojun-mbn@nifty.com>
	<20080706103752.13935ffd.komurojun-mbn@nifty.com>
	<4870D46C.7000604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <4870D46C.7000604@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-pcmcia <linux-pcmcia@lists.infradead.org>, linux-kernel@vger.kernel.org, Brodowski <linux@dominikbrodowski.net>, rjw@sisk.pl, linux-ide@vger.kernel.org, Dominik, Kristoffer Ericson <kristoffer.ericson@gmail.com>, jgarzik@redhat.com
List-Id: linux-ide@vger.kernel.org


Hi,

> How come ap->lock can get set to bogus address?  Can you please printk
> &host->lock and ap->lock after ata_host_alloc() without the patch?

Here is the output of printk.
Strangely, without the patch, the pata_pcmcia problem happens again.


ata_piix 0000:00:1f.1: version 2.12
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
&host->lock = d6c288b4
ap->lock = d6c288b4
ap->lock = d6c288b4
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi0 : ata_piix
scsi1 : ata_piix
....

pcmcia: registering new device pcmcia1.0
&host->lock = d70ee534
ap->lock = d70ee534
scsi2 : pata_pcmcia


	host = devres_alloc(ata_host_release, sz, GFP_KERNEL);
	if (!host)
		goto err_out;

	devres_add(dev, host);
	dev_set_drvdata(dev, host);

	spin_lock_init(&host->lock);
	printk("&host->lock = %x\n", &host->lock);
	host->dev = dev;
	host->n_ports = max_ports;

	/* allocate ports bound to this host */
	for (i = 0; i < max_ports; i++) {
		struct ata_port *ap;

		ap = ata_port_alloc(host);
		if (!ap)
			goto err_out;

		ap->port_no = i;
		/*
		ap->lock = &ap->__lock;
		spin_lock_init(ap->lock);
		*/
		printk("ap->lock = %x\n", ap->lock);
		host->ports[i] = ap;
	}

Best Regards
Komuro
