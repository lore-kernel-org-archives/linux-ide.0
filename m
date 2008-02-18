From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] libata-scsi: automatically use DMADIR if drive/bridge requires it
Date: Mon, 18 Feb 2008 17:20:44 -0500
Message-ID: <20080218222044.GA20041@devserv.devel.redhat.com>
References: <47B9D64C.3000705@rtr.ca> <47B9F05A.1060207@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:36542 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443AbYBRW1p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Feb 2008 17:27:45 -0500
Content-Disposition: inline
In-Reply-To: <47B9F05A.1060207@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Albert Lee <albertcc@tw.ibm.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>

On Mon, Feb 18, 2008 at 03:53:46PM -0500, Mark Lord wrote:
> +		/* some SATA bridges need us to indicate data xfer direction 
> */
> +		if (atapi_dmadir || (dev->id[62] & 0x8000))

The rest of the code uses ata_ inlines/defines in ata.h for things like this
and religiously checks validity bits and ATA versions.

