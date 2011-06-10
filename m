From: Mark Lord <mlord@pobox.com>
Subject: Re: Added advisement against marvell ATA controller in the ATA wiki
 page
Date: Fri, 10 Jun 2011 08:19:40 -0400
Message-ID: <4DF20BDC.5090109@pobox.com>
References: <20110610070030.GB15235@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65466 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756332Ab1FJM3S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Jun 2011 08:29:18 -0400
In-Reply-To: <20110610070030.GB15235@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Saeed Bishara <saeed@marvell.com>, Hubert Bailey <hbailey@marvell.com>

On 11-06-10 03:00 AM, Tejun Heo wrote:
..
> If anyone has _any_ better idea, please share.  As it currently
> stands, marvell controllers are the only problematic ones in ATA land
> and it would be AWESOME to see it somehow resolved.
..

It's only the Marvell AHCI controllers that are causing grief.
The ones supported by sata_mv are among the very best performing
SATA controllers that work with Linux.

So long as it clarifies that point, then great.
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
