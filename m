From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 14/14] ahci: add softreset
Date: Mon, 19 Dec 2005 16:13:38 +0900
Message-ID: <43A65DA2.2080402@gmail.com>
References: <20051218133305.GA31571@htj.dyndns.org> <20051218135149.GO31571@htj.dyndns.org> <43A646C7.3050503@pobox.com> <43A64F5A.1010002@gmail.com> <43A655C4.10300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:15803 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030275AbVLSHNo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 02:13:44 -0500
Received: by zproxy.gmail.com with SMTP id 13so1237089nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 23:13:44 -0800 (PST)
In-Reply-To: <43A655C4.10300@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, liml@rtr.ca, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Jeff Garzik wrote:
>>
>>> Tejun Heo wrote:
>>>
>>>> Now that libata is smart enought to handle both soft and hard resets,
>>>> add softreset method.
>>>
>>>
>>>
>>>
>>> I'm a bit skeptical that polling is what should be done here.  SATA 
>>> is inherently event-driven...
>>>
>>
>> Well, I'm a bit skeptical the other way around.  :-)
>>
>> What benefits would making softreset event-driven bring?
> 
> 
> The underlying operations are inherently event-driven, as I stated 
> above.  You send a packet, wait for the ACK.  Send another packet.  Wait 
> for the ACK.
> 

Okay.  Hmmm... I don't really see the point you're trying to make here. 
  I'll describe AHCI COMRESET sequence in detail to communicate myself 
better.

The following is mainly from section 10.4.1 of AHCI spec rev 1.1.

1. clear PxCMD.ST and wait for PxCMD.CR to clear to 0.  If PxCMD.CR 
doesn't clear within 500msec, the interface might be hung (fall back to 
hardreset).

	- no interrupt generated on CR clearing, polling required

2. if BSY or DRQ is set, they need to be cleared using PxCMD.CLO if 
supported.  CLO is performed by setting PxCMD.CLO and waiting for the 
controller to clear it.  The spec doesn't say how long it may take.

	- no interrupt generated on CLO clearing, polling required.

3. set PxCMD.ST

4. issue the first H2D Register FIS (SRST on).  This command needs to 
have CH[R] (SYNC escaping) and CH[C] (clear BSY on R_OK) set.  The CH[C] 
is needed because the device won't generate D2H Register FIS after 
receiving SRST.  The controller clears BSY when the device says it 
received the packet okay (R_OK).  This won't generate an interrupt.

	- no interrupt generated on BSY clearing, polling needed.

5. issue the second H2D Register FIS (SRST off).  The device will clear 
BSY when reporting signature with D2H FIS.  I cannot find whether the 
device is supposed to assert INTRQ on completion or not but it seems not.

	- (probably) no interrupt generated on signature reporting.


So, AFAICS, most steps need polling and some are rather long, too.  Am I 
missing something here?

Thanks.  :-)

-- 
tejun
