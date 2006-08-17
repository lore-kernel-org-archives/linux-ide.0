From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: More ATA corner cases
Date: Thu, 17 Aug 2006 10:57:37 +0800
Message-ID: <44E3DB21.2050105@tw.ibm.com>
References: <1155731962.24077.346.camel@localhost.localdomain>	 <44E3A13D.20102@rtr.ca> <1155775118.15195.14.camel@localhost.localdomain> <44E3BDB8.2030502@rtr.ca>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:62096 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932377AbWHQC6G
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Aug 2006 22:58:06 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k7H2w5ER020449
	for <linux-ide@vger.kernel.org>; Wed, 16 Aug 2006 22:58:05 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7H2vpad217528
	for <linux-ide@vger.kernel.org>; Wed, 16 Aug 2006 20:57:51 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7H2vp5g030362
	for <linux-ide@vger.kernel.org>; Wed, 16 Aug 2006 20:57:51 -0600
In-Reply-To: <44E3BDB8.2030502@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Doug Maxey <dwm@enoyolf.org>, Unicorn Chang <uchang@tw.ibm.com>

Mark Lord wrote:
> Alan Cox wrote:
> 
>> Ar Mer, 2006-08-16 am 18:50 -0400, ysgrifennodd Mark Lord:
>>
>>> Alan Cox wrote:
>>>
>>>> Any objection to me adding a new cable type for "40 wire ATA66 capable"
>>>> to indicate the laptop vendor has been sneaky and we should do full
>>>> UDMA
>>>> ranges regardless of drive or other controller reporting.
>>>
>>> Good.  I'll need that feature for a little mini-ITX box here as well.
>>> It uses a *really short* 40W cable for UDMA4 operation.
>>
>>
>> Can you send me the dmidecode output and the lspci -vxxx for it so I can
>> find something to autodetect this.
> 
> 
> No autodetection possible here -- custom configuration.
> 
> All I need is a modparam or /sys attrib that I can set.
> 

This problem was also seen on the IBM JS20 blade server:
The on-board IDE wires are short enough and capable of UDMA/66, but the
cable detection limits the speed to UDMA/33.
It will be nice to have the "40 wire ATA66 capable" support.

Don't know whether the JS20 can be added to the whitelist automatically.
If Alan is ok, will ask Unicorn's help to sent Alan the dmidecode and
lspci -vxxx data of JS20 (and maybe other blades like HS20/HS40, etc).

--
albert




