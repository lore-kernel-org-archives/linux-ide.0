From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: fix SCSI/ATA device association during hotplug
Date: Tue, 28 Nov 2006 09:12:15 -0500
Message-ID: <456C43BF.4060807@rtr.ca>
References: <20061120092534.GP2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:34322 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S935091AbWK1OMS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 09:12:18 -0500
In-Reply-To: <20061120092534.GP2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
..
> +		/* Try to attach new SCSI device.  SCSI midlayer
> +		 * doesn't supply separate interfaces for allocating
> +		 * and probing, so in this function, we can associate
> +		 * new SCSI device with its target ATA device only
> +		 * after probing is complete.
..

I'm not necessarily disagreeing with the code, but rather that comment.

Mmm.. isn't slave_alloc() for allocating?  It gets invoked before
the INQUIRY, and then slave_configure() is invoked after a successful
device INQUIRY (otherwise slave_destroy() is invoked to clean up).

??
