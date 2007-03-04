From: Stephen Clark <Stephen.Clark@seclark.us>
Subject: Re: [PATCH] libata: warn if speed limited due to 40-wire cable (v2)
Date: Sun, 04 Mar 2007 13:14:45 -0500
Message-ID: <45EB0C95.1070505@seclark.us>
References: <45DA44B4.6000209@shaw.ca>	<45E8B42E.7010900@garzik.org> <20070303005433.714d75ad@lxorguk.ukuu.org.uk> <45E9DA80.2080109@tmr.com>
Reply-To: Stephen.Clark@seclark.us
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752179AbXCDSOq@vger.kernel.org>
In-Reply-To: <45E9DA80.2080109@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

Bill Davidsen wrote:

>Alan Cox wrote:
>  
>
>>>it seems broken to manipulate xfer_mask after returning from the 
>>>driver's ->mode_filter hook.
>>>
>>>this patch is more than just a speed-limited warning printk, afaics
>>>      
>>>
>>I actually suggested that order because the only way the printk can be
>>done correctly is for it to be the very last test made. Since the mode
>>filter is not told what mode will be used but just subtracts modes that
>>are not allowed this should be safe.
>>    
>>
>
>Far better to have a drive which works slowly than one which works 
>unreliably.
>
>  
>
That would be true if the 40 wire detection was 100% accurate!

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)
