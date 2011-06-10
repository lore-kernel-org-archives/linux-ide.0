From: Mark Lord <mlord@pobox.com>
Subject: Re: Added advisement against marvell ATA controller in the ATA wiki
 page
Date: Fri, 10 Jun 2011 13:30:48 -0400
Message-ID: <4DF254C8.4040404@pobox.com>
References: <20110610070030.GB15235@htj.dyndns.org>
 <4DF20BDC.5090109@pobox.com> <4DF240B4.1030901@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107Ab1FJRbC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Jun 2011 13:31:02 -0400
In-Reply-To: <4DF240B4.1030901@seoss.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@seoss.co.uk>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Saeed Bishara <saeed@marvell.com>, Hubert Bailey <hbailey@marvell.com>

On 11-06-10 12:05 PM, Tim Small wrote:
>
> It looks to me like Marvell have stopped further development on sata_mv
> interface cards - does anyone know if it's the case?

Those are known as "EDMA" cards.  I don't know that they've "stopped"
anything there -- their latest EDMA chips are still widely used on
boards in the shops today.  And the same core appears in their embedded
products (eg. the plug computers).

But if I were developing new SATA chips, I'd used an industry standard
interface if at all possible: AHCI.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
