From: Christoph Hellwig <hch@infradead.org>
Subject: Re: RFC: moving drivers to a new drivers/ata directory
Date: Fri, 15 Oct 2004 08:46:27 +0100
Sender: linux-scsi-owner@vger.kernel.org
Message-ID: <20041015074627.GA18977@infradead.org>
References: <416F5757.8000306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <416F5757.8000306@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

On Fri, Oct 15, 2004 at 12:51:35AM -0400, Jeff Garzik wrote:
> 
> Eventually I would like to move libata, and a few non-libata driver like 
> 3ware, to drivers/ata.  It would appear in the makefile (and link order) 
> _after_ drivers/ide and drivers/scsi.
> 
> Comments/objections?

Only if your stop using the scsi subsystem.  The handfull scsi drivers outside
drivers/scsi are a pain already.

