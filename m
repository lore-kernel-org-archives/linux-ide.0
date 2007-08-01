From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH UPDATED] libata: add support for ATA_16 on ATAPI
Date: Wed, 01 Aug 2007 10:00:20 -0400
Message-ID: <46B091F4.5070704@garzik.org>
References: <20070801075624.GD13674@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53994 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932214AbXHAOAX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Aug 2007 10:00:23 -0400
In-Reply-To: <20070801075624.GD13674@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca

Tejun Heo wrote:
> From: Mark Lord <liml@rtr.ca>
> 
> Add support for issuing ATA_16 passthru commands to ATAPI devices
> managed by libata.  It requires the previous CDB length fix patch.
> 
> A boot/module parameter, "atapi_scmd85=1" can be used to globally
> disable this feature, if ever desired.
> 
> tj: renamed ata16_passthru module param to atapi_scmd85 to reduce
>     confusion
> 
> tj: restructured __ata_scsi_queuecmd() according to Jeff's suggestion.
> 
> Signed-off-by: Mark Lord <liml@rtr.ca>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Jeff, Mark, are you guys okay with the modified version?

Close!  Thanks for revising!

My only comment now is that I dislike atapi_scmd85.  That means nothing 
to me.

I liked the old name better.  Or maybe use atapi_passthru16.

	Jeff





