From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata/sata_sil24 cache alignment problem?
Date: Thu, 14 Feb 2008 00:21:35 +0000
Message-ID: <20080214002135.065dd322@core>
References: <20080212180254.GA28237@postdiluvian.org>
	<20080212221257.12eeab13@core>
	<20080213184702.GA13458@postdiluvian.org>
	<20080213202151.34b7e5bc@core>
	<20080213212549.GA14732@postdiluvian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37477 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S934651AbYBNA3b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 19:29:31 -0500
In-Reply-To: <20080213212549.GA14732@postdiluvian.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Mason <mason@postdiluvian.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

> I hadn't considered that approach due to the way the ata_port is allocated:
> 
> > libata-core.c:
> >         host = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
> > 
> > hosts.c:
> > struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
> > {
> >         shost = kzalloc(sizeof(struct Scsi_Host) + privsize, gfp_mask);
> > }
> 
> The ata_port allocation is tacked onto the end of the Scsi_Host
> allocation, so the start of ata_port will only be cache aligned if the
> end of the Scsi_Host struct is, although that would be easy enough to
> fix since it's currently aligned to an unsigned long boundary.

You are right.

> I like that approach better, since it's clearer what the intent is,
> and it's easier.  Is there any other way that the ata_port struct
> might be used that would invalidate this?  

I can't think of one. The object lifetime is right - the ata_port is
created before the port buffer is used and destroyed after it is finished
(obviously or embedding it in the struct wouldn't work either)

Alan
