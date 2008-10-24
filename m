From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: linux-next: Tree for October 24 - powerpc - build failure with
 !CONFIG_BLK_DEV_IDEDMA_PMAC
Date: Sat, 25 Oct 2008 02:39:31 +0400
Message-ID: <49024EA3.1080404@ru.mvista.com>
References: <20081024171932.1e8131d0.sfr@canb.auug.org.au>	 <20081024113856.GA4252@linux.vnet.ibm.com> <4901BC5E.7040607@ru.mvista.com> <1224886062.7654.464.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1224886062.7654.464.camel@pasglop>
Sender: linux-next-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, bzolnier@gmail.com
List-Id: linux-ide@vger.kernel.org

Hello.

Benjamin Herrenschmidt wrote:

>>>  next-20081024 randconfig build fails on the powerpc, with
>>>
>>> drivers/ide/pmac.c: In function 'pmac_ide_set_pio_mode':
>>> drivers/ide/pmac.c:527: error: implicit declaration of function 'kauai_lookup_timing'
>>> drivers/ide/pmac.c:527: error: 'shasta_pio_timings' undeclared (first use in this function)
>>> drivers/ide/pmac.c:527: error: (Each undeclared identifier is reported only once
>>> drivers/ide/pmac.c:527: error: for each function it appears in.)
>>> drivers/ide/pmac.c:534: error: 'kauai_pio_timings' undeclared (first use in this function)
>>> drivers/ide/pmac.c: In function 'pmac_ide_do_resume':
>>> drivers/ide/pmac.c:914: error: 'IDE_WAKEUP_DELAY' undeclared (first use in this function)
>>> drivers/ide/pmac.c: At top level:
>>> drivers/ide/pmac.c:1007: error: 'pmac_ide_init_dma' undeclared here (not in a function)
>>> drivers/ide/pmac.c: In function 'pmac_ide_setup_device':
>>> drivers/ide/pmac.c:1107: error: 'IDE_WAKEUP_DELAY' undeclared (first use in this function)
>>> drivers/ide/pmac.c: In function 'pmac_ide_macio_attach':
>>> drivers/ide/pmac.c:1209: error: 'pmac_ide_hwif_t' has no member named 'dma_regs'
>>> drivers/ide/pmac.c:1210: error: 'pmac_ide_hwif_t' has no member named 'dma_regs'
>>> make[2]: *** [drivers/ide/pmac.o] Error 1
>>>   
>>>       
>>    Hm, looks like this configuration was never buildable -- #ifdef's are 
>> missing and wrongly placed. CCing Ben Herrenschmidt...
>>     
>
> What configuration ?
>   

   See the subject.

> Ben.

MBR, Sergei
