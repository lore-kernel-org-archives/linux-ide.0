From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/6] libata: Report supported TRIM payload size
Date: Mon, 23 Aug 2010 15:50:24 +0200
Message-ID: <20100823135024.GA22554@lst.de>
References: <1282232941-9910-1-git-send-email-martin.petersen@oracle.com> <1282232941-9910-3-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:50492 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163Ab0HWNu2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Aug 2010 09:50:28 -0400
Content-Disposition: inline
In-Reply-To: <1282232941-9910-3-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, hch@lst.de

On Thu, Aug 19, 2010 at 11:48:57AM -0400, Martin K. Petersen wrote:
> ATA IDENTIFY DEVICE word 105 contains the number of 512-byte blocks of
> TRIM payload information the device can accept in one command.  Use this
> value to enable payloads > 512 bytes.

Currently ata_scsi_write_same_xlat passes uses a constant 512 for the
payload all over the place, so the larger payloads won't actually work yet.

I don't think advertising a larger size than we actually support is a
good idea.

