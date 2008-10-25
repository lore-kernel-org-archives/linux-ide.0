From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: linux-next: Tree for October 24 - powerpc - build failure with
 !CONFIG_BLK_DEV_IDEDMA_PMAC
Date: Sat, 25 Oct 2008 22:57:27 +0400
Message-ID: <49036C17.1060604@ru.mvista.com>
References: <20081024171932.1e8131d0.sfr@canb.auug.org.au> <49024EA3.1080404@ru.mvista.com> <1224889818.7654.466.camel@pasglop> <200810251519.57543.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200810251519.57543.bzolnier@gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: benh@kernel.crashing.org, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>>    Hm, looks like this configuration was never buildable -- #ifdef's are missing and wrongly placed. CCing Ben Herrenschmidt...   
>>>>>           
>>>> What configuration ?
>>>>   
>>>>         
>>>    See the subject.
>>>       
>> Ah ok. We should probably just remove the option...
>>     
>
> Fine with me.  Anybody want an easy +1 patch-point? :)
>   

   BTW, why this option selects BLK_DEV_IDEDMA_PCI?

MBR, Sergei
