From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] scsi: Add scsi_device max_cmd_len
Date: Wed, 29 Mar 2006 18:19:16 -0500
Message-ID: <442B15F4.30506@pobox.com>
References: <200603282217.k2SMHJTH032251@d03av04.boulder.ibm.com> <20060329091104.GB7940@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20060329091104.GB7940@infradead.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Brian King <brking@us.ibm.com>, James.Bottomley@steeleye.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

James Bottomley wrote:
> This really doesn't look correct.  What you want is a sata transport
> class with a max command length in the host device.

Christoph Hellwig wrote:
> this sounds wrong to me.  cdb length is a limitation of the host (driver).
> A target will reject unknown commands, no matter what length they have.


In practice, CDB length may be limited by both the host and the device. 
  This applies to ATAPI, and some USB storage too IIRC.  For ATAPI, you 
read the CDB length from the device's IDENTIFY PACKET DEVICE info page.

	Jeff



