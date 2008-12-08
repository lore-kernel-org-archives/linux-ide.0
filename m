From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] libata: Add two more columns to the ata_timing table.
Date: Mon, 08 Dec 2008 21:55:29 +0300
Message-ID: <493D6DA1.3090801@ru.mvista.com>
References: <4939B402.9010004@caviumnetworks.com> <1228518561-16242-1-git-send-email-ddaney@caviumnetworks.com> <493ADE48.6050709@ru.mvista.com> <493D65C8.2060808@caviumnetworks.com> <493D6C0F.7070809@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:40120 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751192AbYLHSzc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Dec 2008 13:55:32 -0500
In-Reply-To: <493D6C0F.7070809@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org

Hello, I wrote:

>>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>>> index ed3f26e..95fa9f6 100644
>>>> --- a/include/linux/libata.h
>>>> +++ b/include/linux/libata.h

>>> [...]

>>>>  enum ata_xfer_mask {
>>>> @@ -864,6 +868,8 @@ struct ata_timing {
>>>>      unsigned short cyc8b;        /* t0 for 8-bit I/O */
>>>>      unsigned short active;        /* t2 or tD */
>>>>      unsigned short recover;        /* t2i or tK */
>>>> +    unsigned short write_hold;    /* t4 */
>>>> +    unsigned short read_holdz;    /* t6z */

>>>    Sorry for failing to notice this before but t6z is again the 
>>> timing that the host can't control. Therefore I'm seeig no sense in 
>>> its addition.

>> The host cannot control t6z, but in some cases (like ours) it needs to 
>> be aware of its value.  We cannot start driving the bus for access to 
>> other devices until the CF stops driving it.  We need to know how long 
>> to wait until it is safe to use the bus for other things.

>    Re-read the spec please, the timing you need is t9 and it's much 
> longer than t6 that your driver using instead.

    OK, t6z is yet longer than t9 but putting it into the table seems 
pointless anyway as it's fixed at 30 ns, at least for the standard 5 PIO modes 
(and for other two modes 30 ns would be good anyway).
    Though frankly speaking I don't quite understand your care for this 
timing, if the ATA standard permits -CE deasserted and data bus being driven 
to overlap. Remember that the minimum address setup time adds to that equation 
too.

MBR, Sergei
