From: Mark Lord <liml@rtr.ca>
Subject: Re: Analysis of EH on Andi's dying disk and stuff to discuss about
Date: Sat, 29 Mar 2008 16:53:19 -0400
Message-ID: <47EEAC3F.2070004@rtr.ca>
References: <20080328093055.GA16736@basil.nowhere.org> <47EDECE5.50309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1975 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754251AbYC2UxU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Mar 2008 16:53:20 -0400
In-Reply-To: <47EDECE5.50309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>, ric@emc.com

Tejun Heo wrote:
..

>    So, to handle the common cases better, libata EH times out resets
>    quickly.  The first two tries are 10 seconds each and most devices
>    get reset properly before it hits the end of the second reset try
>    even if it needs to spin up.  What takes the longest is the third
..

I think that 10 seconds timeout is just *slightly* too short.
There are drives here somewhere, that always fail the first attempt
because they take about 12 seconds to spin-up and begin communicating.

Cheers
