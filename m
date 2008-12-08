From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 1/2] libata: Add two more columns to the ata_timing table.
Date: Mon, 08 Dec 2008 10:22:00 -0800
Message-ID: <493D65C8.2060808@caviumnetworks.com>
References: <4939B402.9010004@caviumnetworks.com> <1228518561-16242-1-git-send-email-ddaney@caviumnetworks.com> <493ADE48.6050709@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:57546 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbYLHS3K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Dec 2008 13:29:10 -0500
In-Reply-To: <493ADE48.6050709@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org

Sergei Shtylyov wrote:
> Hello.
> 
> David Daney wrote:
> 
>> The forthcoming OCTEON SOC Compact Flash driver needs a few more
>> timing values than were available in the ata_timing table.  I add new
>> columns for write_hold and read_holdz times.  The values were obtained
>> from the Compact Flash specification Rev 4.1.
> 
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> 
> NAK.
> 
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index ed3f26e..95fa9f6 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
> [...]
>>  enum ata_xfer_mask {
>> @@ -864,6 +868,8 @@ struct ata_timing {
>>      unsigned short cyc8b;        /* t0 for 8-bit I/O */
>>      unsigned short active;        /* t2 or tD */
>>      unsigned short recover;        /* t2i or tK */
>> +    unsigned short write_hold;    /* t4 */
>> +    unsigned short read_holdz;    /* t6z */
> 
>    Sorry for failing to notice this before but t6z is again the timing 
> that the host can't control. Therefore I'm seeig no sense in its 
> addition.

The host cannot control t6z, but in some cases (like ours) it needs to 
be aware of its value.  We cannot start driving the bus for access to 
other devices until the CF stops driving it.  We need to know how long 
to wait until it is safe to use the bus for other things.


> I don't know how your driver is going to use it -- but most 
> probably incorrectly...

Thanks for that vote of confidence.


David Daney
