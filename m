From: "Norman Diamond" <n0diamond@yahoo.co.jp>
Subject: Re: Off-by-one in both LIBATA and IDE drivers
Date: Thu, 12 Mar 2009 06:03:33 +0900
Message-ID: <065A106FBB5F41B18A030BD2C87570FA@DIAMOND8600>
References: <20090311032805.3120.qmail@web4114.mail.ogk.yahoo.co.jp> <49B78859.5050807@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754161AbZCKVEa@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Norman Diamond <n0diamond@yahoo.co.jp>
List-Id: linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Norman Diamond wrote:
>> [attribution stolen:]
>>> [Norman Diamond:]
>>>> It looks like both LIBATA and the old IDE drivers
>>>> have an off-by-one error in deciding whether to use
>>>> READ SECTOR(S) instead of READ SECTOR(S) EXT.
>>>>
>>> This was fixed here:
>>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=97b697a11b07e2ebfa69c488132596cc5eb24119
>>
>> Thank you.
>> I will see if I can port that fix to 2.6.24.3, because
>> Slax 6.0.3 and kernel 2.6.24.3 avoided some other bugs of
>> later kernels.
>
> Note that this doesn't fix it for the IDE core.

That helps explain my subsequent testing.  I'm still having problems.

> The ide-disk driver however seems to use LBA48 regardless of the sector 
> address.

But that doesn't explain my subsequent testing.  That behaviour would cause 
it to work in one of my present cases, but it still fails.

> But still there are incorrect capacity checks, and it can fails with 
> drivers not supporting LBA48 with DMA...

Yeah that could be part of it.  2.6.20 turned on DMA more often than later 
kernels, so I'm now thinking of reverting to 2.6.20.  I've heard (but 
couldn't test personally) that 2.6.20 gave abysmal performance to users of 
AMD chipsets.  Since Intel users outnumber them, I'm inclined to revert to a 
version that worked for Intel even though AMD suffers. 

--------------------------------------
Power up the Internet with Yahoo! Toolbar.
http://pr.mail.yahoo.co.jp/toolbar/
