From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: linux-next: Tree for Oct 11 (ata/pata_of_platform.c)
Date: Fri, 14 Oct 2011 10:58:01 -0700
Message-ID: <4E987829.3080104@xenotime.net>
References: <20111011201127.455df266dcbffb1d621f8576@canb.auug.org.au> <4E94A920.40503@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E94A920.40503@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>
List-Id: linux-ide@vger.kernel.org

On 10/11/2011 01:37 PM, Randy Dunlap wrote:
> On 10/11/11 02:11, Stephen Rothwell wrote:
>> Hi all,
>>
>> The linux-next tree is now available from
>> git://github.com/sfrothwell/linux-next.git as a temporary measure while
>> the kernel.org servers are unavailable.
>>
>> It may also turn up on git.kernel.org (depending on the mirroring).  The
>> patch set is still absent, however.
>>
>> Changes since 20111007:
>>
>> Removed tree: ide (at the maintainer's request)
> 
> 
> drivers/ata/pata_of_platform.c:55:13: error: 'NO_IRQ' undeclared (first use in this function)


[adding Author: Anton]

Build error still present in linux-next of 20111014.


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
