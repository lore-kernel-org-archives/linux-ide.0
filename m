From: Norman Diamond <n0diamond@yahoo.co.jp>
Subject: Is FBS (FIS) working on Silicon Image 3726 port multiplier?
Date: Wed, 17 Oct 2012 14:25:27 +0900 (JST)
Message-ID: <664301.29926.qm@web100020.mail.kks.yahoo.co.jp>
Reply-To: n0diamond@yahoo.co.jp
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web100020.mail.kks.yahoo.co.jp ([114.111.98.194]:22817 "HELO
	web100020.mail.kks.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751735Ab2JQFcL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2012 01:32:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm trying to use an SIL3726 with 5 SATA drives and an SIL3132.
FBS should work, right?  But performance looks like CBS.
Is there some way to check if FBS is actually enabled?
I'm trying to read some source code to figure it out.
The kernel is a little bit old by now but apparently not too old.

In file libata-pmp.c, the following is logged:
	if (print_info) {
		ata_dev_printk(dev, KERN_INFO, "Port Multiplier %s, "
			       "0x%04x:0x%04x r%d, %d ports, feat 0x%x/0x%x\n",
			       sata_pmp_spec_rev_str(gscr), vendor, devid,
			       sata_pmp_gscr_rev(gscr),
			       nr_ports, gscr[SATA_PMP_GSCR_FEAT_EN],
			       gscr[SATA_PMP_GSCR_FEAT]);
ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9

Good, the following is not logged:
		if (!(dev->flags & ATA_DFLAG_AN))
			ata_dev_printk(dev, KERN_INFO,
				"Asynchronous notification not supported, "
				"hotplug won't\n         work on fan-out "
				"ports. Use warm-plug instead.\n");

We have quirks but these shouldn't prevent FBS:
	if (vendor == 0x1095 && devid == 0x3726) {
		/* sil3726 quirks */
		ata_for_each_link(link, ap, EDGE) {
			/* Class code report is unreliable and SRST
			 * times out under certain configurations.
			 */
			if (link->pmp < 5)
				link->flags |= ATA_LFLAG_NO_SRST |
					       ATA_LFLAG_ASSUME_ATA;

			/* port 5 is for SEMB device and it doesn't like SRST */
			if (link->pmp == 5)
				link->flags |= ATA_LFLAG_NO_SRST |
					       ATA_LFLAG_ASSUME_SEMB;
		}

In file libata-core.c we have another quirk that shouldn't prevent FBS:
	/* Odd clown on sil3726/4726 PMPs */
	{ "Config  Disk",	NULL,		ATA_HORKAGE_DISABLE },

In file libahci.c something doesn't happen that maybe should happen.
static void ahci_enable_fbs(struct ata_port *ap)
{
	struct ahci_port_priv *pp = ap->private_data;
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 fbs;
	int rc;

	if (!pp->fbs_supported)
		return;

	fbs = readl(port_mmio + PORT_FBS);
	if (fbs & PORT_FBS_EN) {
		pp->fbs_enabled = true;
		pp->fbs_last_dev = -1; /* initialization */
		return;
	}

	rc = ahci_stop_engine(ap);
	if (rc)
		return;

	writel(fbs | PORT_FBS_EN, port_mmio + PORT_FBS);
	fbs = readl(port_mmio + PORT_FBS);
	if (fbs & PORT_FBS_EN) {
		dev_printk(KERN_INFO, ap->host->dev, "FBS is enabled.\n");
		pp->fbs_enabled = true;
		pp->fbs_last_dev = -1; /* initialization */
	} else
		dev_printk(KERN_ERR, ap->host->dev, "Failed to enable FBS\n");

	ahci_start_engine(ap);
}

We do not get a log of "FBS is enabled.".
We do not get a log of "Failed to enable FBS".
So is this function returning early for some reason?
Or is this function not called for some reason?

Should FBS be working?

Also it was pleasant to see this function:
void ahci_print_info(struct ata_host *host, const char *scc_s)
[...]
		cap & HOST_CAP_FBS ? "fbs " : "",
But is there a pseudofile in /proc or /sys to view the output?
My find-foo and Google-foo skill weren't good enough for this.
/sys/devices/pci0000:00/0000:00:04.0/0000:03:00.0/host4
contains stuff about the drives but not about the port multiplier.
