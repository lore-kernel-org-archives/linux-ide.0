From: Mark Mason <mason@postdiluvian.org>
Subject: Re: libata/sata_sil24 cache alignment problem?
Date: Wed, 13 Feb 2008 16:25:49 -0500
Message-ID: <20080213212549.GA14732@postdiluvian.org>
References: <20080212180254.GA28237@postdiluvian.org> <20080212221257.12eeab13@core> <20080213184702.GA13458@postdiluvian.org> <20080213202151.34b7e5bc@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from postdiluvian.org ([128.30.54.21]:37859 "EHLO
	porklips.postdiluvian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbYBMV0B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 16:26:01 -0500
Content-Disposition: inline
In-Reply-To: <20080213202151.34b7e5bc@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> O> I'm counting on kmalloc to return a cache aligned buffer.  I found
> > some reason to think it does, but I don't remember offhand what that
> 
> Its defined to
> 
> > reason was, or if it's configurable per-architecture.  The buffer has
> > to be both physically and virtually contiguous, I was tempted to just
> > allocate a page and waste some space but we've got 64K pages, so I'm a
> > bit more sensitive about that.
> 
> Ok I was expecting a different approach if you mark the field with the
> magic  ____cacheline_aligned tag after it (ie int foo ____blah_aligned;)
> the compiler should align it all for you , which is probably cleaner if
> it works.

I hadn't considered that approach due to the way the ata_port is allocated:

> libata-core.c:
>         host = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
> 
> hosts.c:
> struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
> {
>         shost = kzalloc(sizeof(struct Scsi_Host) + privsize, gfp_mask);
> }

The ata_port allocation is tacked onto the end of the Scsi_Host
allocation, so the start of ata_port will only be cache aligned if the
end of the Scsi_Host struct is, although that would be easy enough to
fix since it's currently aligned to an unsigned long boundary.

I like that approach better, since it's clearer what the intent is,
and it's easier.  Is there any other way that the ata_port struct
might be used that would invalidate this?  This one issue is the
extent of my knowledge of libata.
