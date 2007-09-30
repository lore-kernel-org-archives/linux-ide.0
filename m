From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] blacklist NCQ on Seagate Barracuda ST380817AS
Date: Sun, 30 Sep 2007 15:01:36 -0400
Message-ID: <46FFF290.2090005@rtr.ca>
References: <20070930160548.235be972@localhost>	<20070930152908.1f58d39d@the-village.bc.nu> <20070930164610.20818867@localhost> <46FFBB2D.6060004@garzik.org> <46FFDC5A.7070509@rtr.ca> <46FFDCE5.4060900@gmail.com> <46FFE047.7030102@rtr.ca> <46FFE218.5000607@gmail.com> <46FFF0F4.7040809@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4911 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbXI3TBf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Sep 2007 15:01:35 -0400
In-Reply-To: <46FFF0F4.7040809@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Paolo Ornati <ornati@fastwebnet.it>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
>> Mark Lord wrote:
>>> Tejun Heo wrote:
>>>> Mark Lord wrote:
>>>> If there was such a bug, the aborted commands list should contain both
>>>> FPDMA commands and FLUSH commands.  I don't think command filtering
>>>> itself is broken.  Possibly another quirky firmware but it's strange
>>>> that this is the only Seagate drive showing this problem.
>>> Yeah, that's the strange bit.
>>>
>>> Surely someone at SuSE must have a drive like that,
>>> which they could set up with XFS and reproduce the same results?
>>
>> I wish we had a detailed hardware catalog.  I'll give a shot at the
>> internal mailing list.
> 
> Or pick up a new one (only about $78 here) and expense it!

Mmm.. $66 for "open box".  But the drive itself has been discontinued by Seagate,
and once claimed to be "World's first SATA desktop drive with NCQ.".

Probably buggy firmware after all.

-ml
