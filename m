From: Dave <dave.jiang@gmail.com>
Subject: Re: [PATCH] updates to Vitesse SATA driver
Date: Wed, 22 Sep 2004 10:09:03 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <8746466a04092210094f859468@mail.gmail.com>
References: <8746466a04092114163b3c0618@mail.gmail.com>
	 <20040922020614.GA148273@sgi.com>
	 <8746466a0409220859ed0682f@mail.gmail.com>
Reply-To: Dave <dave.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.205]:24144 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266349AbUIVRJL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Sep 2004 13:09:11 -0400
Received: by mproxy.gmail.com with SMTP id 73so1692066rnk
        for <linux-ide@vger.kernel.org>; Wed, 22 Sep 2004 10:09:04 -0700 (PDT)
In-Reply-To: <8746466a0409220859ed0682f@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Wed, 22 Sep 2004 08:59:06 -0700, Dave <dave.jiang@gmail.com> wrote:
> On Tue, 21 Sep 2004 19:06:14 -0700, Jeremy Higdon <jeremy@sgi.com > wrote:
> > On Tue, Sep 21, 2004 at 02:16:46PM -0700, Dave wrote:
> > > After getting that working I noticed that the last_ctl value gets
> > > changed back by the LIBATA core and the Vitesse SATA driver depends on
> > > the previous value in order to unmask the interrupt. So it seems that
> > > there's no need to set/unset the interrupt masks in the first place if
> > > we set the CTL register with ATA_NIEN directly, which I believe is
> > > probably the way LIBATA intended the driver to do. After doing that
> > > everything seems to be working great. So I suppose
> > > vsc_intr_mask_update() is no longer needed probably.
> >
> > The chip specification says not to set it that way.  Are you using
> > the chip in DPA mode or PCI-IDE mode?  The driver assumes the former.  I
> > don't know why anyone would use the chip in PCI-IDE mode.
> 
> Hmmm...I did not see it in the spec. Can you provide the pointer to
> the spec please? Thanks! I am using it in DPA mode. If you are in
> PCI-IDE mode, all registers would reside in different BARs and the
> card wouldn't work anyways with that driver. I copied the section from
> sata_svw.c. And it seems to work just fine. I don't see how the
> previous method would be working. In vsc_sata_tf_load a compare is
> done between the tf->ctl and the ap->last_ctl. However, if I do it
> with the current method, I continue to see ap->last_ctl with ATA_NIEN
> cleared even though the previous value was set. Therefore the driver
> never unmask the IDE interrupt and thus hang.  What happened was, host
> 1, dev 0 was probed and was okay. Then it attempted to probe host 1,
> dev 1, which of course does not exist, so at exit, ata_irq_on() was
> called. With that the last_ctl was reset with ATA_NIEN cleared.
> Therefore when the driver does the compare of ctl with last_ctl, it
> sees no difference, and therefore interrupt mask never changed.

I see what you mean by the spec regarding the ATA_NIEN bit. ATA_NIEN
is reserved bit in DPA mode. I guess it still works. But to do the
things the right way now this becomes a problem since as I mentioned
above, libata-core can change the last_ctl value without the driver's
knowledge. So really we cannot always depend on last_ctl to be the
last_ctl the driver has set. I'm not exactly sure yet why the driver
works on IA in the current state. Everything tells me it shouldn't....
Unless there's something that I'm suppose to configure to force it not
probe device 1 since in SATA there's never device 1?
