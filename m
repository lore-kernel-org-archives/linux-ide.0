From: Ric Wheeler <ric@emc.com>
Subject: Re: error handling - DMA to PIO step down sequence
Date: Thu, 21 Sep 2006 12:50:08 -0400
Message-ID: <4512C2C0.9010503@emc.com>
References: <4511907F.1010104@emc.com> <4512AB17.7040907@gmail.com>	 <4512BD19.5010401@emc.com> <1158858264.11109.159.camel@localhost.localdomain>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:51627 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751319AbWIUQ4v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Sep 2006 12:56:51 -0400
In-Reply-To: <1158858264.11109.159.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Mark Lord <mlord@pobox.com>

Alan Cox wrote:
> Ar Iau, 2006-09-21 am 12:26 -0400, ysgrifennodd Ric Wheeler:
> 
>>>>Would this be a reasonable thing for a config option? Better to add 
>>>>yet another blacklist for devices that might have a justified need for 
>>>>this derating?
> 
> 
> I think so. I've got "Adding a set of flags to blacklist entries" on my
> todo list so that we can indicate and deal with different kinds of
> horkage.
> 

That could be very useful - flag specific drives to disable NCQ 
(regardless of the internal setting for drive queue depth) and so on.

ric

