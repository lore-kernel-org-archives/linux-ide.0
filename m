From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] libata: fix ata_id_logical_per_physical_sectors
Date: Wed, 3 Feb 2010 19:17:23 +0100
Message-ID: <20100203181723.GA23221@lst.de>
References: <20100128104234.GA25693@lst.de> <20100128123011.GA32001@lst.de> <20100203173721.GA21703@lst.de> <yq1bpg6mbk0.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:58134 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885Ab0BCSSx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Feb 2010 13:18:53 -0500
Content-Disposition: inline
In-Reply-To: <yq1bpg6mbk0.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, jgarzik@pobox.com, linux-ide@vger.kernel.org, stable@kernel.org

On Wed, Feb 03, 2010 at 01:14:23PM -0500, Martin K. Petersen wrote:
> >>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:
> 
> Christoph> Without this patch the minimum I/O size for 4k drives will be
> Christoph> reported incorrectly, which will make paritions misaligned on
> Christoph> modern distros.
> 
> I'm in total agreement with the patch (feel free to add my Acked-by:).
> 
> However, the minimum I/O size should still be reported correctly.  We
> don't allow min_io to be smaller than physical_block_size...

Indeed, I only verified it using sg_inq, not the sysfs files.

