From: Mark Mason <mason@postdiluvian.org>
Subject: Re: libata/sata_sil24 cache alignment problem?
Date: Wed, 13 Feb 2008 13:51:59 -0500
Message-ID: <20080213185159.GA13584@postdiluvian.org>
References: <20080212180254.GA28237@postdiluvian.org> <20080212221257.12eeab13@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from postdiluvian.org ([128.30.54.21]:60159 "EHLO
	porklips.postdiluvian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648AbYBMSwF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 13:52:05 -0500
Content-Disposition: inline
In-Reply-To: <20080212221257.12eeab13@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > Has anyone else reported a problem like this?  It requires
> > non-coherent DMA, and a lack of a cache invalidate instruction, and
> > one of the drivers that has this problem (it looks like sata_qstor
> > does too, I haven't looked at others), so maybe that doesn't cover
> > any other architectures.
> 
> Nobody has, not even PA-RISC which is normally guaranteed to make life
> miserable in the caching area but I agree entirely with your diagnosis
> and that buffer should indeed be marked cache aligned
> 
> > I can provide a patch if you're interested.
> 
> Please do.

Oops, sorry, I left a file out of that diff.  Here it is again...

*** drivers/scsi/libata-core.c	2008-02-13 13:34:32.141489000 -0500
--- drivers/scsi/libata-core.c.orig	2008-02-13 13:29:35.620360000 -0500
***************
*** 5335,5369 ****
  	}
  
  	host = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
  	if (!host)
  		return NULL;
  
  	host->transportt = &ata_scsi_transport_template;
  
  	ap = ata_shost_to_port(host);
  
- 	ap->sector_buf = kmalloc(ATA_SECT_SIZE, GFP_KERNEL);
- 	if (!ap->sector_buf)
- 		goto err_out;
- 
  	ata_host_init(ap, host, host_set, ent, port_no);
  
  	rc = ap->ops->port_start(ap);
  	if (rc)
  		goto err_out;
  
  	return ap;
  
  err_out:
- 	if (ap->sector_buf)
- 		kfree(ap->sector_buf);
  	scsi_host_put(host);
  	return NULL;
  }
  
  /**
   *	ata_device_add - Register hardware device with ATA and SCSI layers
   *	@ent: Probe information describing hardware device to be registered
   *
   *	This function processes the information provided in the probe
   *	information struct @ent, allocates the necessary ATA and SCSI
--- 5335,5363 ----
***************
*** 5602,5645 ****
   *	Unregister all objects associated with this host set. Free those
   *	objects.
   *
   *	LOCKING:
   *	Inherited from calling layer (may sleep).
   */
  
  void ata_host_set_remove(struct ata_host_set *host_set)
  {
  	unsigned int i;
- 	u8 *sector_buf;
  
  	for (i = 0; i < host_set->n_ports; i++)
  		ata_port_detach(host_set->ports[i]);
  
  	free_irq(host_set->irq, host_set);
  
  	for (i = 0; i < host_set->n_ports; i++) {
  		struct ata_port *ap = host_set->ports[i];
  
  		ata_scsi_release(ap->host);
  
  		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
  			struct ata_ioports *ioaddr = &ap->ioaddr;
  
  			if (ioaddr->cmd_addr == 0x1f0)
  				release_region(0x1f0, 8);
  			else if (ioaddr->cmd_addr == 0x170)
  				release_region(0x170, 8);
  		}
  
- 		sector_buf = ap->sector_buf;
  		scsi_host_put(ap->host);
- 		kfree(sector_buf);
  	}
  
  	if (host_set->ops->host_stop)
  		host_set->ops->host_stop(host_set);
  
  	kfree(host_set);
  }
  
  /**
   *	ata_scsi_release - SCSI layer callback hook for host unload
--- 5596,5636 ----
*** include/linux/libata.h	2008-02-13 10:51:39.151202000 -0500
--- include/linux/libata.h.orig	2008-02-13 13:50:26.531572000 -0500
***************
*** 550,570 ****
  
  	u32			msg_enable;
  	struct list_head	eh_done_q;
  	wait_queue_head_t	eh_wait_q;
  
  	pm_message_t		pm_mesg;
  	int			*pm_result;
  
  	void			*private_data;
  
! 	u8			*sector_buf; /* owned by EH */
  };
  
  struct ata_port_operations {
  	void (*port_disable) (struct ata_port *);
  
  	void (*dev_config) (struct ata_port *, struct ata_device *);
  
  	void (*set_piomode) (struct ata_port *, struct ata_device *);
  	void (*set_dmamode) (struct ata_port *, struct ata_device *);
  	unsigned long (*mode_filter) (const struct ata_port *, struct ata_device *, unsigned long);
--- 550,570 ----
  
  	u32			msg_enable;
  	struct list_head	eh_done_q;
  	wait_queue_head_t	eh_wait_q;
  
  	pm_message_t		pm_mesg;
  	int			*pm_result;
  
  	void			*private_data;
  
! 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
  };
  
  struct ata_port_operations {
  	void (*port_disable) (struct ata_port *);
  
  	void (*dev_config) (struct ata_port *, struct ata_device *);
  
  	void (*set_piomode) (struct ata_port *, struct ata_device *);
  	void (*set_dmamode) (struct ata_port *, struct ata_device *);
  	unsigned long (*mode_filter) (const struct ata_port *, struct ata_device *, unsigned long);
