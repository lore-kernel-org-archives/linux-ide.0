From: Tim Small <tim@seoss.co.uk>
Subject: Re: Added advisement against marvell ATA controller in the ATA wiki
 page
Date: Fri, 10 Jun 2011 17:05:08 +0100
Message-ID: <4DF240B4.1030901@seoss.co.uk>
References: <20110610070030.GB15235@htj.dyndns.org> <4DF20BDC.5090109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([78.47.234.210]:51756 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab1FJQFW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2011 12:05:22 -0400
In-Reply-To: <4DF20BDC.5090109@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Saeed Bishara <saeed@marvell.com>, Hubert Bailey <hbailey@marvell.com>

On 10/06/11 13:19, Mark Lord wrote:
> It's only the Marvell AHCI controllers that are causing grief.
> The ones supported by sata_mv are among the very best performing
> SATA controllers that work with Linux.
>   


It looks to me like Marvell have stopped further development on sata_mv
interface cards - does anyone know if it's the case?  I couldn't find
any SATA3 6GBps, or PCI-e 2.0 chips, so I assumed that Marvell has gone
for ahci or mvsas only for it's current/future product ranges?

That's why I chose the 88SE9123 - as they seemed to offer reasonable
performance/features etc. (albeit single lane PCI express only).

Cheers,

Tim.


-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.  
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

