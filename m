From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 6/7] sata_mv: endian fix
Date: Mon, 22 May 2006 02:36:38 -0400
Message-ID: <44715BF6.1040506@pobox.com>
References: <9FCDBA58F226D911B202000BDBAD467306382E46@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:18055 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932501AbWEVGgl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2006 02:36:41 -0400
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306382E46@zch01exm40.ap.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Zang Roy-r61911 wrote:
>> Zang Roy-r61911 wrote:
>>>> This fixes a byte-swap issue on PPC, found by Zang Roy-r61911
>>>> on the powerpc platform.  His original patch also had some other
>>>> platform-specific changes in #ifdef's, but I'm not sure yet how to
>>>> incorporate them.  Look for another patch for those (soon).
>>>>
>>>> Signed-off-by: Mark Lord <liml@rtr.ca>
>>>>
>>>> ---
>>>> --- linux/drivers/scsi/sata_mv.c	2006-05-19 
>>>> 15:44:11.000000000 -0400
>>>> +++ linux/drivers/scsi/sata_mv.c	2006-05-19 
>>>> 15:58:21.000000000 -0400
>>>> @@ -1030,8 +1030,9 @@
>>>>  
>>>>  static inline void mv_crqb_pack_cmd(u16 *cmdw, u8 data, u8 
>>>> addr, unsigned last)
>>>>  {
>>>> -	*cmdw = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
>>>> +	u16 tmp = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
>>>>  		(last ? CRQB_CMD_LAST : 0);
>>>> +	*cmdw = cpu_to_le16(tmp);
>>>>  }
>>>>  
>>>>  /**
>>>>
>>>
>>> Does this patch will affect other platform except powerpc?
>> This patch affects all platforms (as it should).  Most Linux code is 
>> intentionally written in a cross-platform, portable manner 
>> without ifdefs.
>>
>> 	Jeff
>>
>>
>>
> I can see it work on powerpc platform, while does it work for other 
> platform such as i386?

Yes.  Look at the definition of the function in question:  for little 
endian platforms, it is a simple assignment.  For big endian platforms, 
it does the expected byte swap.

This is also the standard for Linux code:  one function Does The Right 
Thing, regardless of platform.

	Jeff



