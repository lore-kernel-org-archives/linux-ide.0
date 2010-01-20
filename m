From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [patch 2/2] sata_via: Delay on vt6420 when starting ATAPI DMA
   write
Date: Tue, 19 Jan 2010 22:53:55 -0600
Message-ID: <4B568C63.4050506@gmail.com>
References: <20100116235653.898098245@gmail.com> <20100116235851.884756038@gmail.com> <4B5678E2.2050709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754928Ab0ATEyG@vger.kernel.org>
In-Reply-To: <4B5678E2.2050709@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bart Hartgers <bart.hartgers@gmail.com>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, juergen.metzdorf@telelev-dsl.de, markpschool@hotmail.com, sporadic.crash@gmail.com, apopov@sirma.bg, david@coomber.co.za, jay4mail@gmail.com
List-Id: linux-ide@vger.kernel.org

On 01/19/2010 09:30 PM, Tejun Heo wrote:
> Hello,
>
> On 01/17/2010 08:56 AM, Bart Hartgers wrote:
>> When writing a disc on certain lite-on dvd-writers (also rebadged as
>> optiarc/LG/...) connected to a vt6420, the ATAPI CDB ends up in the
>> datastream and on the disc, causing silent corruption.  Delaying
>> between sending the CDB and starting DMA seems to prevent this.
>>
>> I do not know if there are burners that do not suffer from this, but
>> the patch should be safe for those as well.
>>
>> There are many reports of this issue, but AFAICT no solution was
>> found before. For example:
>> http://lkml.indiana.edu/hypermail/linux/kernel/0802.3/0561.html
>>
>> Signed-off-by: Bart Hartgers<bart.hartgers@gmail.com>
>
> Ah... you found solution for this?  That's great.  This is one of the
> three problems that have been lingering for years - the other two
> being pata_ali ATAPI DMA problem and sata_sil data corruption problem.
> I'll be ecstatic if this fix works.  Just one thing, I don't think
> we'll need a warning message there.  It's useful during development
> but it doesn't really provide any useful information afterwards.

Another tiny nitpick about the patch, the unlikely() around the 
DMA_TO_DEVICE check probably shouldn't be there - unlikely() is for 
things that will always be either highly unlikely or a slow path, 
neither of which really apply.

>
> Digging up the mailing list and cc'ing people who have reported this
> problem.  If you still have the affected systems, can you guys please
> test the patch in the following message and see whether it fixes the
> problem?
>
>    http://article.gmane.org/gmane.linux.kernel/939112/raw
>
> Thanks a lot.  :-)
>
