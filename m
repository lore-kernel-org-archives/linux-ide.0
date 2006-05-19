From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 04/14] libata-hp-prep: update ata_scsi_find_dev() and
 friends
Date: Fri, 19 May 2006 11:03:29 -0400
Message-ID: <446DDE41.9040900@pobox.com>
References: <11480445841836-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:26534 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932333AbWESPDp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 11:03:45 -0400
In-Reply-To: <11480445841836-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Separate out ata_find_dev() and __ata_scsi_find_dev() from
> ata_scsi_find_dev().  ata_find_dev() checks ATA_FLAG_SLAVE_POSS for
> id==1 case, so all three functions return NULL if id==1 is specified
> for !SLAVE_POSS port.  These will be used by later hotplug
> implementation.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK with future comment:

Once we have a better way to sequence simplex + master/slave + normal 
SATA, libata-scsi should move to exporting one Scsi_Host per controller, 
with each physical ATA bus being a scsi channel.

libata abuses Scsi_Host currently, to make master/slave + normal SATA 
sequencing work.  (note to self: need to review that area WRT NCQ, too)

	Jeff



