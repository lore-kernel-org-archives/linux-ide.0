From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Subject should be [PATCHSET libata-dev#upstream-fixes] libata:
 prefer hardreset, take #3
Date: Mon, 17 Mar 2008 09:19:03 +0100
Message-ID: <18398.10615.977550.334382@harpo.it.uu.se>
References: <12052096544056-git-send-email-htejun@gmail.com>
	<47D60A9E.1060609@gmail.com>
	<18397.39466.462694.412688@harpo.it.uu.se>
	<47DDB898.6050001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:41728 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbYCQITR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Mar 2008 04:19:17 -0400
In-Reply-To: <47DDB898.6050001@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, jeff@garzik.org, linux-ide@vger.kernel.org

Tejun Heo writes:
 > Hello, Mikael.
 > 
 > Thanks for testing.
 > 
 > Mikael Pettersson wrote:
 > > Tejun Heo wrote (in first mail with wrong Subject):
 > >> It still needs Mikael's ack regarding behavior
 > >> change on sata_promise.
 > > 
 > > Unfortunately it breaks sata_promise:
 > > 
 > > ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
 > > ata5.00: ATA-7: ST3120813AS, 3.AAD, max UDMA/133
 > > ata5.00: 234441648 sectors, multi 0: LBA48 NCQ (depth 0/32)
 > > ata5.00: configured for UDMA/133
 > > ata5: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
 > > ata5: hotplug_status 0x10
 > > ata5: hard resetting link
 > 
 > Eeeek, this means that ->hardreset is already broken on sata_promise
 > which gotta be fixed as it will lead to hardreset loops whenever
 > softreset fails.

Yes. I even have a recent bug report where the symptom was stray
hotplug interrupts. At the time nothing would explain why they
occurred, but now it seems that it probably was hardreset.

 > > What happens is that a hard reset triggers cable sensing and
 > > reporting, so we get stray hotplug events which confuses things.
 > > 
 > > One solution is to mask/unmask a port's hotplug events around
 > > calls to sata_std_hardreset(). (This also matches what Promise's
 > > reference driver does, except their hard reset fiddles with
 > > Promise specific registers.) The patch below is a draft which
 > > implements that solution.
 > 
 > That can be done in either ->freeze/->thaw or ->postreset depending on
 > symmetry of things.  If ->freeze plugs hotplug interrupts too, it's
 > probably best to clear hotplug events in ->thaw before unblocking
 > hotplug events.
 > 
 > > A problem is that Promise SATA chips implement per-port hotplug
 > > control using port-specific bits in a single global register.
 > > So I have to map the link to the corresponding ata engine number:
 > > this mapping doesn't seem to be present anywhere, so in this
 > > draft patch I'm resorting to searching the host's ports[] array.
 > 
 > Hmmm....
 > 
 > > Also, since the ports share a global register it's important that
 > > at most one port goes through a hard reset sequence at a time.
 > > Can I assume that libata EH guarantees mutual exclusion?
 > 
 > There currently is no cross-port synchronization but you can always grab
 > host->lock for that.

Ok.

 > > With this patch in place the hard reset conversion does seem to
 > > work Ok on a SATA300 TX4 card.
 > [--snip--]
 > > +	for(i = 0; i < 4/*XXX: how to detect # ports?*/ && host->ports[i] != ap; ++i)
 > 
 > host->n_ports?
 > 
 > > +		;
 > > +	if (i >= 4) {
 > > +		printk(KERN_ERR "%s: unable to map ap to ata_no\n", __FUNCTION__);
 > > +		return sata_std_hardreset(link, class, deadline);
 > > +	}
 > > +	ata_no = pdc_port_no_to_ata_no(i, is_sataii_tx4);
 > > +
 > > +	hotplug_status = readl(mmio_base + hotplug_offset);
 > > +
 > > +	/* clear hotplug flags, mask hotplug ints */
 > > +	hotplug_status |= (0x11 << ata_no);
 > > +	hotplug_status |= (0x11 << ata_no) << 16;
 > > +	writel(hotplug_status, mmio_base + hotplug_offset);
 > > +	readl(mmio_base + hotplug_offset); /* flush */
 > 
 > I think this belongs to ->freeze().
 > 
 > > +	ret = sata_std_hardreset(link, class, deadline);
 > > +
 > > +	/* clear hotplug flags, unmask hotplug ints */
 > > +	hotplug_status &= ~((0x11 << ata_no) << 16);
 > > +	writel(hotplug_status, mmio_base + hotplug_offset);
 > > +	readl(mmio_base + hotplug_offset); /* flush */
 > 
 > And this to ->thaw().

Thanks, I'll try these suggestions. Expect a new patch in a couple of days.

/Mikael
