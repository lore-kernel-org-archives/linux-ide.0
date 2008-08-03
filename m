From: Hong Tran Duc <hongtd2k@gmail.com>
Subject: Re: Oops when read/write or mount/unmount continuously ~ 600.000
 times
Date: Sun, 03 Aug 2008 22:18:57 +0700
Message-ID: <4895CC61.6040301@gmail.com>
References: <4895A96E.2040303@gmail.com> <20080803133817.GG26461@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080803133817.GG26461@parisc-linux.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Matthew Wilcox wrote:
> On Sun, Aug 03, 2008 at 07:49:50PM +0700, Hong Tran Duc wrote:
>   
>> The reasons is almost linked list on those function was broken. Ex: 
>> linkedlist->next linkedlist->prev = NULL or set to invalid address.
>> In the situation SIGILL, the instruction pointer (NIP) is same as the 
>> return address register (LR).
>>     
>
> In later kernels, we have a list debugging option which lets you find
> list corruptions earlier.
>   
I'm not have much experience with linux kernel architecture, so I don't 
know where I can focus on.

Currently, I'm suspecting these module are affected with this Oops: 
Block I/O management and filesystem, some Wait Queue  ? Is that correct ?
Or would you give me some suggestion what is the most suspicious ? or 
some debugging option you told above ?

Thanks for your help,


-- 
nm.

GPG Key ID: 0xDD253B25
Fingerprint: 2B17 D64A 9561 A443 2ABC 1302 4641 D0B7 DD25 3B25

