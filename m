From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] Add hook for custom xfer function in PATA Platform driver
Date: Sun, 09 May 2010 17:36:52 +0400
Message-ID: <4BE6BA74.10200@mvista.com>
References: <1273382493-5859-1-git-send-email-graeme.russ@gmail.com> <4BE6910D.9070504@ru.mvista.com> <4BE69C81.2070703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:50679 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab0EINhj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 May 2010 09:37:39 -0400
Received: by ewy20 with SMTP id 20so668947ewy.1
        for <linux-ide@vger.kernel.org>; Sun, 09 May 2010 06:37:37 -0700 (PDT)
In-Reply-To: <4BE69C81.2070703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Graeme Russ <graeme.russ@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Graeme Russ wrote:

> [Added linux-ide back onto distribution list]
>   

   Right, I didn't intend to exclude it -- probably didn't press all the 
keys at once for the reply-to-all function.

[...]
>
>>   You should have also taught the symmetric ide-platfrom driver the same
>> trick. However, IDE core's data transfer methods has a different prototype.
>>     
>
> I did think about the other drivers (OF Platform etc) but I have no way of
> testing them.
>   

   pata_of_platform is not easily extensible in this way. It gets all 
the information about the device from the device tree -- and you can't 
encode all your complications there, unless you invent a new OF device.

>> I suggest to rather add a new flag, indicating 8-bit data I/O, and have
>> the alternate sff_data_xfer() method defined inside the driver.
>>
>>     
>
> Well actually it goes beyond simply implementing 8-bit data transfers - On
> my particular board, the PATA devices (2x CF slots) are on a General
> Purpose Bus with a few other peripherals. The timing requirements for the
> bus when accessing the CF cards are very strict (and very slow compared to
> other devices on the bus). By overriding the data transfer function I can
> arbitrate access to the bus and switch the bus timings based on the
> peripheral being accessed. This cannot be done be a generic data transfer
> function.
>   

   I disagree with your approach of overriding the libata methods at the 
board level, so I suggest to write a new driver. This is too complicated 
stuff for poor old pata_platform. :-)

> Regards,
>
> Graeme

MBR, Sergei

