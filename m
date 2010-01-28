From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] libata: fix ata_id_logical_per_physical_sectors
Date: Thu, 28 Jan 2010 11:59:27 +0100
Message-ID: <20100128105927.GA26711@lst.de>
References: <20100128104234.GA25693@lst.de> <4B616D55.6080802@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:54606 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753805Ab0A1LC1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jan 2010 06:02:27 -0500
Content-Disposition: inline
In-Reply-To: <4B616D55.6080802@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Christoph Hellwig <hch@lst.de>, jgarzik@pobox.com, linux-ide@vger.kernel.org, stable@kernel.org

On Thu, Jan 28, 2010 at 01:56:21PM +0300, Sergei Shtylyov wrote:
> > static inline u8 ata_id_logical_per_physical_sectors(const u16 *id)
> > {
> >-	return id[ATA_ID_SECTOR_SIZE] & 0xf;
> >+	return 1 << (id[ATA_ID_SECTOR_SIZE] & 0xf);
> >  
> 
>   Will this still fit into u8?

Right now the only value we get in practice is 8 for 4k sector drivers
which still fits fine into an u8.  But it might indeed be safer to use a
large value.

