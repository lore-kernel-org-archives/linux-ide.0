From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: NCQ is slower in some cases?
Date: Thu, 23 Jul 2009 12:04:56 -0600
Message-ID: <4A68A648.8080108@gmail.com>
References: <1248320643.9035.19.camel@sli10-desk.sh.intel.com> <4A67E0AA.6060405@pobox.com> <20090723054804.GB7473@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f192.google.com ([209.85.222.192]:48380 "EHLO
	mail-pz0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbZGWSIo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jul 2009 14:08:44 -0400
Received: by pzk30 with SMTP id 30so606021pzk.33
        for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2009 11:08:44 -0700 (PDT)
In-Reply-To: <20090723054804.GB7473@sli10-desk.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>, "Zhang, Yanmin" <yanmin.zhang@intel.com>

On 07/22/2009 11:48 PM, Shaohua Li wrote:
> On Thu, Jul 23, 2009 at 12:01:46PM +0800, Jeff Garzik wrote:
>> Shaohua Li wrote:
>>> Hi,
>>> I did some tests about NCQ. It appears enabling NCQ sometimes will make
>>> disk slower than disabling it (well it does improve performance in
>>> random io case). Test using fio with attached script.
>>> With queue_depth 1 (so NCQ is disabled), the disk speed is about 27m/s.
>>> with queue_depth 2 - 31, the speed is about 24m/s.
>>>
>>> blktrace shows the Q2C time with NCQ enabled increases about 10%.
>>> Specifically the D2C time increases and time of other stages hasn't
>>> obvious changes.
>>>
>>> I added a 'udelay()' at the end of ahci_qc_issue(), as my test does
>>> 'submit a request, wait it and then submit another', so if the udelay
>>> time is shorter than the disk io time, the udelay should not be harmful.
>>> My test shows when the udelay time is smaller than 90us, the delay
>>> hasn't any impact to the ncq enabled case. On the other hand, the udelay
>>> time should be shorter than 30us otherwise the ncq disabled case has
>>> obvious performance downgrade. This test seems suggesting diskio is
>>> slower in ncq enabled. Is the single diskio slow in ncq case expected?
>> You should test disks from different vendors and generations...
>>
>> NCQ is _usually_ a win, especially for multi-threaded applications.
>> Tests from years ago seemed to indicate that the advantage maxed out at
>> 4-8 queued commands, and added little value after that.
>>
>> In addition, some NCQ disks and some system workloads may underperform,
>> but this does not seem to be the general case.
> I just occasionally did the test and hadn't resource to do a full test.
> I tested two hard disks (one from WDC the other Seegate), both have the
> same behavior. If it's possible hardware will slower with NCQ in some
> cases, I'll not borther spending time on it any more.
> So can you guys suggest if the issue is related with hardware?

In theory there's no reason NCQ should be slower with single 
non-overlapped requests (actually there's some reason it should be 
faster as using FPDMA the drive is allowed to return the data for the 
request out of order). However, some drive firmware may have extra 
overhead for NCQ requests or buffer things differently, etc. which may 
cause some slowdown.
