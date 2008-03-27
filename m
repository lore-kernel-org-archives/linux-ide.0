From: Ric Wheeler <ric@emc.com>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Thu, 27 Mar 2008 16:23:54 -0400
Message-ID: <47EC025A.1070004@emc.com>
References: <12066128663306-git-send-email-htejun@gmail.com> <47EBAE2B.8070102@rtr.ca> <47EBDF36.5080504@emc.com> <47EBED0A.8020201@garzik.org>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:43468 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760136AbYC0Ube (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 16:31:34 -0400
In-Reply-To: <47EBED0A.8020201@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk


Jeff Garzik wrote:
> Ric Wheeler wrote:
>> I think that the 30 seconds was meant to be that worst case time for 
>> the drive to respond to a command. We try to push vendors to respond 
>> in much less time than that (it's important to get things like the 
>> fast fail path for RAID working correctly), say something like 10-15 
>> seconds.
> 
> 
> Multiple vendors say the FLUSH CACHE worst case can exceed 30 seconds 
> though...
> 
>     Jeff

That might be true, but in that case, I still think we should never retry the 
flush ;-)

ric
