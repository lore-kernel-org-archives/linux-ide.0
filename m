From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] libata: warn if speed limited due to 40-wire cable (v2)
Date: Sun, 04 Mar 2007 18:00:49 -0500
Message-ID: <45EB4FA1.7020305@tmr.com>
References: <45DA44B4.6000209@shaw.ca>	<45E8B42E.7010900@garzik.org> <20070303005433.714d75ad@lxorguk.ukuu.org.uk> <45E9DA80.2080109@tmr.com> <45EB0C95.1070505@seclark.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tmr.com ([64.65.253.246]:57398 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbXCDW7K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Mar 2007 17:59:10 -0500
In-Reply-To: <45EB0C95.1070505@seclark.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen.Clark@seclark.us
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Stephen Clark wrote:
> Bill Davidsen wrote:
>
>> Alan Cox wrote:
>>  
>>
>>>> it seems broken to manipulate xfer_mask after returning from the 
>>>> driver's ->mode_filter hook.
>>>>
>>>> this patch is more than just a speed-limited warning printk, afaics
>>>>     
>>> I actually suggested that order because the only way the printk can be
>>> done correctly is for it to be the very last test made. Since the mode
>>> filter is not told what mode will be used but just subtracts modes that
>>> are not allowed this should be safe.
>>>   
>>
>> Far better to have a drive which works slowly than one which works 
>> unreliably.
>>
>>  
>>
> That would be true if the 40 wire detection was 100% accurate!
The statement is completely correct, even though the detection may not 
be. ;-)

With the current set(s) of patches to do better detection, cable 
evaluation should be better. But even if not, a slow system is more 
useful than one which doesn't work, crashes because of swap i/o errors, etc.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

