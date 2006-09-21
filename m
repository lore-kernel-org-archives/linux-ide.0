From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: error handling - DMA to PIO step down sequence
Date: Thu, 21 Sep 2006 18:04:23 +0100
Message-ID: <1158858264.11109.159.camel@localhost.localdomain>
References: <4511907F.1010104@emc.com> <4512AB17.7040907@gmail.com>
	 <4512BD19.5010401@emc.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4236 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751321AbWIUQmX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Sep 2006 12:42:23 -0400
In-Reply-To: <4512BD19.5010401@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ric@emc.com
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Mark Lord <mlord@pobox.com>

Ar Iau, 2006-09-21 am 12:26 -0400, ysgrifennodd Ric Wheeler:
> >> Would this be a reasonable thing for a config option? Better to add 
> >> yet another blacklist for devices that might have a justified need for 
> >> this derating?

I think so. I've got "Adding a set of flags to blacklist entries" on my
todo list so that we can indicate and deal with different kinds of
horkage.


