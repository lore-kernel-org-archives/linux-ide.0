From: Joe Harvell <jharvell@dogpad.net>
Subject: Re: Problems with Promise SATAII TX4
Date: Thu, 31 Mar 2005 22:34:27 +0200
Message-ID: <424C5ED3.8010109@dogpad.net>
References: <20050330001007.GA16954@cebitec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:24724 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261811AbVCaUei (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Mar 2005 15:34:38 -0500
Received: from zrtpd0jn.us.nortel.com (zrtpd0jn.us.nortel.com [47.140.202.35])
	by zcars04e.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id j2VKYaH05400
	for <linux-ide@vger.kernel.org>; Thu, 31 Mar 2005 15:34:36 -0500 (EST)
In-Reply-To: <20050330001007.GA16954@cebitec.uni-bielefeld.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Earlier this month I repeatedly reported a data corruption issue (with
no trap) with the sata_promise support for this card, but got no
response whatsoever from the driver author.

I was able to work around this problem only by using Promise's driver,
but I had to revert from the 2.6 to 2.4 kernel.

Kim Roland Rasmussen wrote:

>Hi all,
>
>Together with a couple of others I have been bitten by problems with the
>Promise SATAII TX4 controller.
>
>Common to all is that at some point the kernel log contains the "irq
><SOME NUMBER>: nobody cared!" error message, followed by a call/stack
>trace. This is quickly followed up by a "Disabling IRQ #<SOME NUMBER>"
>which effectively kills the SATA controller and access to the disks.
>
>Although a somewhat unusual request, could I ask somebody to look at
>this
>
>    http://forums.gentoo.org/viewtopic-p-2247734.html
>
>developing thread in the Gentoo Forums. There's simply to much
>information there to repost here.
>
>In my case (posted under <rasmussen>) I temporarily seem to have gotten
>around it by replacing a driver with another of a different brand.
>However, this is not the case for others.
>
>Any idea of what's going on? To me it looks like some interrupt isn't
>cleared or something like that (but I'm just guessing).
>
>Cheers,
>  Kim
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>



