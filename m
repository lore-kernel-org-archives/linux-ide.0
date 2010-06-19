From: Erik Rull <erik.rull@rdsoftware.de>
Subject: Re: IRQ 15  not assigned, but still unable to use it - in MSDOS it
 works
Date: Sat, 19 Jun 2010 13:25:01 +0200
Message-ID: <4C1CA90D.9010800@rdsoftware.de>
References: <4C18B5CB.4060707@rdsoftware.de> <4C1AE1A2.405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56297 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048Ab0FSLY4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Jun 2010 07:24:56 -0400
In-Reply-To: <4C1AE1A2.405@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:
> On 06/16/2010 05:30 AM, Erik Rull wrote:
>>
>> I need some ideas where to continue my search - I think that it is
>> somewhere in the libata that blocks this interrupt. /proc/interrupts
>> shows up no interrupt neither that #15 is used.
>
> If no driver attaches to the device and nothing is reported in
> /proc/interrupts then nothing should be blocking the interrupt
> driver-wise. I suspect the problem might be elsewhere, like the IRQ
> routing or something..

Hm interesting. Is there a way to debug/see the IRQ routing somehow or 
somewhere? I've found another possiblity of watching incoming interrupts 
via /proc/stats but there is also nothing happening (The number that 
belongs to IRQ15 remains on 0).

Best regards,

Erik
