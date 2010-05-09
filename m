From: Graeme Russ <graeme.russ@gmail.com>
Subject: Re: [PATCH] Add hook for custom xfer function in PATA Platform driver
Date: Sun, 09 May 2010 21:29:05 +1000
Message-ID: <4BE69C81.2070703@gmail.com>
References: <1273382493-5859-1-git-send-email-graeme.russ@gmail.com> <4BE6910D.9070504@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51819 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab0EIL3K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 May 2010 07:29:10 -0400
Received: by pva18 with SMTP id 18so1227468pva.19
        for <linux-ide@vger.kernel.org>; Sun, 09 May 2010 04:29:09 -0700 (PDT)
In-Reply-To: <4BE6910D.9070504@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org

[Added linux-ide back onto distribution list]

Sergei Shtylyov wrote:
> Hello.
> 
> Graeme Russ wrote:
> 
>> +    /*
>> +     * Assign custom data transfer function (if defined)
>> +     */
>> +    if (pp_info)
>> +        if (unlikely(pp_info->data_xfer))
>>   
> 
>   Could be folded into a signle *if* statement.

I thought so - I didn't exactly know what the linux coding standards are in
regards to this shortcut though.

> 
>   You should have also taught the symmetric ide-platfrom driver the same
> trick. However, IDE core's data transfer methods has a different prototype.

I did think about the other drivers (OF Platform etc) but I have no way of
testing them.

> I suggest to rather add a new flag, indicating 8-bit data I/O, and have
> the alternate sff_data_xfer() method defined inside the driver.
> 

Well actually it goes beyond simply implementing 8-bit data transfers - On
my particular board, the PATA devices (2x CF slots) are on a General
Purpose Bus with a few other peripherals. The timing requirements for the
bus when accessing the CF cards are very strict (and very slow compared to
other devices on the bus). By overriding the data transfer function I can
arbitrate access to the bus and switch the bus timings based on the
peripheral being accessed. This cannot be done be a generic data transfer
function.

Regards,

Graeme

