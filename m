From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] scsi: Add scsi_device max_cmd_len
Date: Wed, 29 Mar 2006 16:05:22 +0100
Message-ID: <20060329150522.GA14517@infradead.org>
References: <200603282217.k2SMHJTH032251@d03av04.boulder.ibm.com> <20060329091104.GB7940@infradead.org> <442A967C.8070805@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <442A967C.8070805@us.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Brian King <brking@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, jgarzik@pobox.com, James.Bottomley@steeleye.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Mar 29, 2006 at 08:15:24AM -0600, Brian King wrote:
> In that case, this patch can probably be dropped. Currently libata has
> some code that looks at all the devices attached to a port and sets
> the scsi_host's max_cmd_len to the max of these values. I was assuming
> this was due to some misbehaving ATA/ATAPI devices out there.

For ata devices the scsi cbds are translated to taskfiles anyway so it
doesn't matter.  For ATAPI there might be buggy devices but they should
be handled with the normal blacklist entry meachnisms if they really exist.

