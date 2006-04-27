From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 8/9] prep for hotplug support
Date: Thu, 27 Apr 2006 19:47:58 +0900
Message-ID: <4450A15E.4050105@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com> <44508D6A.3050200@pobox.com> <44509C98.80301@gmail.com> <44509EC7.70807@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:29086 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965088AbWD0Krh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Apr 2006 06:47:37 -0400
Received: by pproxy.gmail.com with SMTP id i49so2017521pye
        for <linux-ide@vger.kernel.org>; Thu, 27 Apr 2006 03:47:37 -0700 (PDT)
In-Reply-To: <44509EC7.70807@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Yeah, Forrest pointed out the same thing and I've converted hotplug_wq 
>> to single threaded variant, which should be enough for SCSI 
>> hotplugging.  For ata_wq, I think it's wiser to keep it multi-threaded 
>> for the time being.  Maybe what should be done is to allocate a single 
>> threaded workqueue per host_set.
> 
> One thread per host_set would suck for any situation where that's doing 
> ATAPI or PIO tasks.  Would love to find a good metric...

Dynamic pool of worker threads maybe?

> 
>> $BIGNUM CPU boxes tend to have $BIGNUM GB of memories, so 
>> multithreaded wq might not be that critical resource-wise.  But, 
>> still, inefficient 
> 
> That's a bad assumption on modern machines.  Think of a single 16-core, 
> 8-thread SPARC Niagara CPU, for example :)
> 

Yeah, that one is pretty extreme.  But most mainstream machines have <= 
8 threads of execution and even they are equipped with GB's of memory. 
But, I do agree that we want something better.

-- 
tejun
