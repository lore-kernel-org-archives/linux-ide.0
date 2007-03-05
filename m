From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] libata: warn if speed limited due to 40-wire cable (v2)
Date: Mon, 05 Mar 2007 10:32:22 -0500
Message-ID: <45EC3806.90509@tmr.com>
References: <45DA44B4.6000209@shaw.ca>	<45E8B42E.7010900@garzik.org> <20070303005433.714d75ad@lxorguk.ukuu.org.uk> <45E9DA80.2080109@tmr.com> <45EB0C95.1070505@seclark.us> <45EB4FA1.7020305@tmr.com> <45EB5B3A.2040009@seclark.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tmr.com ([64.65.253.246]:58267 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbXCEPau (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Mar 2007 10:30:50 -0500
In-Reply-To: <45EB5B3A.2040009@seclark.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen.Clark@seclark.us
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Stephen Clark wrote:
> Bill Davidsen wrote:
>
>> Stephen Clark wrote:
>>  
>>
>>> Bill Davidsen wrote:
>>>
>>>   
>>>> Alan Cox wrote:
>>>>
>>>>
>>>>     
>>>>>> it seems broken to manipulate xfer_mask after returning from the 
>>>>>> driver's ->mode_filter hook.
>>>>>>
>>>>>> this patch is more than just a speed-limited warning printk, afaics
>>>>>>            
>>>>> I actually suggested that order because the only way the printk 
>>>>> can be
>>>>> done correctly is for it to be the very last test made. Since the 
>>>>> mode
>>>>> filter is not told what mode will be used but just subtracts modes 
>>>>> that
>>>>> are not allowed this should be safe.
>>>>>  
>>>>>       
>>>> Far better to have a drive which works slowly than one which works 
>>>> unreliably.
>>>>
>>>>
>>>>
>>>>     
>>> That would be true if the 40 wire detection was 100% accurate!
>>>   
>> The statement is completely correct, even though the detection may 
>> not be. ;-)
>>
>> With the current set(s) of patches to do better detection, cable 
>> evaluation should be better. But even if not, a slow system is more 
>> useful than one which doesn't work, crashes because of swap i/o 
>> errors, etc.
>>
>>  
>>
> I have had problems with cable detection on my previous laptop and my 
> current laptop. It almost made
> my systems unusable. On my current laptop I was getting a thruput of a 
> little over 1 mbps instead
> of the 44 mbps I get with udma set to the correct value. It took hours 
> to upgrade my laptop from
> fc5 to fc6 because of this mis detection.
>
As far as I can see, if you are getting that low a speed, you have other 
problems. I have a system with old slow drives which are really on a 40 
pin cable, and they run at UDMA(33). One of the experts in this can 
undoubtedly tell us more, but your system should run faster than that, 
mine does, and I really HAVE a 40 pin cable (and drive).

If your system drops to PIO modes, I doubt cable is the only issue, I 
think there are other issues (acpi comes to mind).

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

