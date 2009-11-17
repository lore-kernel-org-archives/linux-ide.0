From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] libata: add TRIM support
Date: Tue, 17 Nov 2009 09:30:35 -0500
Message-ID: <20091117143035.GA588@infradead.org>
References: <20091116154343.GA6672@infradead.org> <20091116160748.3c58218e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:37730 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbZKQOad (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 09:30:33 -0500
Content-Disposition: inline
In-Reply-To: <20091116160748.3c58218e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, "Martin K. Petersen" <mkp@mkp.net>, Matthew Wilcox <willy@wil.cx>

On Mon, Nov 16, 2009 at 04:07:48PM +0000, Alan Cox wrote:
> > +	min_io_sectors = 1;
> > +	if ((args->id[106] & 0xc000) == 0x4000 && (args->id[106] & (1 << 13)))
> > +		min_io_sectors *= args->id[106] & 0xf;
> 
> That magic probably wants to be an ata_id_foo helper of some sort but
> otherwise all looks sensible enough for ATA.

I've added two helpers for this.

