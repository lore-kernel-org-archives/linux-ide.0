From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 07/64] pata_atiixp: enable parallel scan
Date: Mon, 18 Jan 2010 19:18:49 +0100
Message-ID: <201001181918.49304.bzolnier@gmail.com>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118171447.14623.47438.sendpatchset@localhost> <20100118175256.32096b44@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755881Ab0ARSXp@vger.kernel.org>
In-Reply-To: <20100118175256.32096b44@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 18 January 2010 06:52:56 pm Alan Cox wrote:
> >  	const struct ata_port_info *ppi[] = { &info, &info };
> > +	struct ata_host *host;
> > +	int rc;
> >  
> > -	return ata_pci_sff_init_one(pdev, ppi, &atiixp_sht, NULL);
> > +	/* enable device and prepare host */
> > +	rc = pcim_enable_device(pdev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = ata_pci_sff_prepare_host(pdev, ppi, &host);
> > +	if (rc)
> > +		return rc;
> > +
> > +	host->flags |= ATA_HOST_PARALLEL_SCAN;
> > +
> > +	pci_set_master(pdev);
> > +
> > +	return ata_pci_sff_activate_host(host, ata_sff_interrupt, &atiixp_sht);
> >  }
> 
> Adding a small essay to each host that activates parallel scan doesn't
> make sense. This should be a helper (ignore that if you make it a helper
> later in the patch set...)

Patch adding such helper would be probably a nice incremental improvement,
though 'a small essay' works just fine for the current needs as parallel
scanning functionality is added only to pata_atiixp and pata_efar hosts..

--
Bartlomiej Zolnierkiewicz
