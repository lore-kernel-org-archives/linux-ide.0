From: Tejun Heo <htejun@gmail.com>
Subject: Re: Errors when copying between drives on a SiI3114 controller under
 kernel 2.6.18
Date: Mon, 09 Oct 2006 17:38:30 +0900
Message-ID: <452A0A86.8070107@gmail.com>
References: <op.tg1yx12kxci36i@akima> <45287FA6.5020906@gmail.com> <op.tg3tyekpxci36i@akima>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:61261 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932401AbWJIIik (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Oct 2006 04:38:40 -0400
Received: by nf-out-0910.google.com with SMTP id x30so1898538nfb
        for <linux-ide@vger.kernel.org>; Mon, 09 Oct 2006 01:38:39 -0700 (PDT)
In-Reply-To: <op.tg3tyekpxci36i@akima>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Bell <doggs.lay.eggs@googlemail.com>
Cc: linux-ide@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

[cc'ing Carlos Pardo]

Jonathan Bell wrote:
> On Sun, 08 Oct 2006 05:33:42 +0100, Tejun Heo <htejun@gmail.com> wrote:
> 
>> Hello.
>>
>> Jonathan Bell wrote:
>>> The problem is that when copying a file off one drive on the 
>>> controller to
>>> another on the same controller, be it via dd or cp, the file that gets
>>> written becomes corrupted along with the filesystem itself. Here is an
>>> extract from dmesg:
>>
>> That's very weird.
>>
>>> [12689.451466] attempt to access beyond end of device
>>> [12689.451475] sdb1: rw=0, want=2339438600, limit=488392002
>>> [12689.451480] attempt to access beyond end of device
>>> [12689.451484] sdb1: rw=0, want=18446744056529747976, limit=488392002
>>> [12689.453822] attempt to access beyond end of device
>>> [12689.453831] sdb1: rw=0, want=2339438600, limit=488392002
>>> [12689.453834] Buffer I/O error on device sdb1, logical block 292429824
>>> [12689.453935] attempt to access beyond end of device
>>> [12689.453938] sdb1: rw=0, want=2339438600, limit=488392002
>>> [12689.453941] Buffer I/O error on device sdb1, logical block 292429824
>> [--snip--]
>>> I would like some help tracking down the cause of this problem as I have
>>> practically exhausted the methods currently at my disposal - my best 
>>> guess
>>> at the moment is that data being written to another port is being 
>>> trampled
>>> on somehow but only when there is I/O active on another port. I will
>>> continue testing to see if simultaneous writes to multiple drives on a
>>> controller causes the same problem.
>>
>> Can you repeat the test using raw devices - /dev/sdX?  I don't think 
>> filesystem is at fault, so let's rule it out.  Also, please post the 
>> result of lspci -nvvvxxx
>>
>> Thanks.
>>
> 
> 
> See attached for the lspci output.
> 
> I have confirmed the problem still happens with the following command:
> 
> yes 0123456789 | dd of=/dev/sda1 & dd if=/dev/sdb1 of=/dev/null &
> 
> I killed it after a while, then did "uniq /dev/sda1"
> 
> The results were.... interesting - instead of just 0123456789 I ended up 
> with a whole load of variations on the theme of "0123456789". Attached 
> is an extract. While this proved the problem still is there I don't 
> really know how to send you any useful information without sending you a 
> ~256 megabyte dump of /dev/sda1 (compressed it is still approximately 
> 1.8MB)
> 
>  From the looks of things the corruptions are few and far between - I 
> wouldn't know how to check how often they occur or what length they are 
> though.
> 
> Also, I probed the validity of the "Buffer I/O error" and found that the 
> logical block wasn't actually corrupted - dd read it just fine - it was 
> full of 0x00 (from badblocks I guess).

I cannot reproduce your problem here.  Can you retest after running the 
following commands?

# setpci -s 01:07.0 0c.b=04
# setpci -s 01:08.0 0c.b=04

The above commands adjust cache line size to 16bytes.

Carlos, the whole thread can be found at the following URL.  lspci 
-nvvvxx result is there too.

http://thread.gmane.org/gmane.linux.ide/13381/focus=13381

-- 
tejun
