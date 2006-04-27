From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 8/9] prep for hotplug support
Date: Thu, 27 Apr 2006 19:27:36 +0900
Message-ID: <44509C98.80301@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com> <44508D6A.3050200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:19855 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965074AbWD0K1R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Apr 2006 06:27:17 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1902942nzf
        for <linux-ide@vger.kernel.org>; Thu, 27 Apr 2006 03:27:17 -0700 (PDT)
In-Reply-To: <44508D6A.3050200@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Hello, all.
>>
>> This is the first take of prep-for-hotplug-support patchset.  As the
>> name suggests, this patchset prepares libata for hotplug support.
>> This patchset contains 15 patches.
>>
>> #01-02    update sata_sil (hotplug related constants, new interrupt 
>> handler)
>> #03-04    misc libata preps
>> #05-12    prepare ata_bus_probe()
>> #13-15    hotplug flags, extra fields, hotplug_wq
> 
> ACK, modulo the minor comments just sent.
> 
> Also, in general libata needs a rethink when it comes to workqueues. 
> Sometimes a single thread is more appropriate than the workqueue default 
> of one-thread-per-CPU.  Using workqueues in the default state is quite 
> efficient, but can also given you a huge number of idle threads on a 
> $BIGNUM CPU box.  Workqueues on a 16-CPU box can be pretty insane...
> 

Yeah, Forrest pointed out the same thing and I've converted hotplug_wq 
to single threaded variant, which should be enough for SCSI hotplugging. 
  For ata_wq, I think it's wiser to keep it multi-threaded for the time 
being.  Maybe what should be done is to allocate a single threaded 
workqueue per host_set.

$BIGNUM CPU boxes tend to have $BIGNUM GB of memories, so multithreaded 
wq might not be that critical resource-wise.  But, still, inefficient 
and doesn't scale well.

-- 
tejun
