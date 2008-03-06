From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 stability and performance
Date: Thu, 06 Mar 2008 13:25:06 +0900
Message-ID: <47CF7222.7060702@gmail.com>
References: <20080219020916.GA29902@denix.org> <20080219043659.GA11936@jim.sh> <47BAF677.5000602@rtr.ca> <20080302061453.GA7291@denix.org> <005d01c87c4c$0d01f550$4d0fa8c0@M2007> <47CC9197.9050609@gmail.com> <20080304002215.GA13317@denix.org> <47CCC1C6.5010600@gmail.com> <20080304062942.GA14335@denix.org> <47CE55B3.6070701@gmail.com> <20080306041454.GA7242@denix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:65526 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517AbYCFEZR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Mar 2008 23:25:17 -0500
Received: by gv-out-0910.google.com with SMTP id s4so1359530gve.37
        for <linux-ide@vger.kernel.org>; Wed, 05 Mar 2008 20:25:15 -0800 (PST)
In-Reply-To: <20080306041454.GA7242@denix.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Dmytriyenko <denis@denix.org>
Cc: Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Mark Lord <liml@rtr.ca>

Denys Dmytriyenko wrote:
> On Wed, Mar 05, 2008 at 05:11:31PM +0900, Tejun Heo wrote:
>> That's the drive rejecting acoustic setting command probably because the
>> drive doesn't support it.  Nothing to worry about.  More recent kernels
>> won't whine about those anymore.
> 
> Oh, thanks. I forgot that I tried to change acoustic setting.
> 
>>> # dd if=/dev/zero of=file bs=100M count=20
>>> 20+0 records in
>>> 20+0 records out
>>> 2097152000 bytes (2.1 GB) copied, 117.053 s, 17.9 MB/s
>>>
>>> # dd if=file of=file1 bs=100M count=20
>>> 20+0 records in
>>> 20+0 records out
>>> 2097152000 bytes (2.1 GB) copied, 161.721 s, 13.0 MB/s
>> Write seems awfully sluggish.  Does turning off NCQ help?  You can turn
>> off NCQ by echoing 1 to /sys/block/sdX/device/queue_depth.  Also, which
>> kernel is this test result from?
> 
> Turning off NCQ does not help. I am currently on 2.6.23.9, but I just tried
> 2.6.25-rc4 and it is the same.
> 
>>> A similar drive in an ICH7 box shows more consistent results:
>>>
>>> # hdparm -t /dev/sda
>>>
>>> /dev/sda:
>>>  Timing buffered disk reads:  182 MB in  3.01 seconds =  60.48 MB/sec
>>>
>>> # dd if=/dev/zero of=file bs=100M count=100
>>> 100+0 records in
>>> 100+0 records out
>>> 10485760000 bytes (10 GB) copied, 242.908 s, 43.2 MB/s
>>>
>>> # dd if=file of=/dev/null bs=100M count=100
>>> 100+0 records in
>>> 100+0 records out
>>> 10485760000 bytes (10 GB) copied, 211.132 s, 49.7 MB/s
>> Hmmm... indeed.  Same kernel version?  Can you post "hdparm -I" results
>> of both drives?
> 
> The kernel on the second box is also 2.6.23.9. Here are hdparm results for
> identical drives:
> 
> 1. Connected to SiI 3124/sata_sil24 w/ slow write:
> 
> # hdparm -I /dev/sda
> 
> /dev/sda:
> 
> ATA device, with non-removable media
>         Model Number:       WDC WD1600JS-75NCB1
>         Serial Number:      WD-WCANM1344866
>         Firmware Revision:  10.02E01
> 
> # hdparm -I /dev/sda
> 
> /dev/sda:
> 
> ATA device, with non-removable media
>         Model Number:       WDC WD1600JS-75NCB1
>         Serial Number:      WD-WCANM1356774
>         Firmware Revision:  10.02E01
> 
> Also, few months ago instead of sata_sil24 I had my drives connected to
> sata_mv (Supermicro 8-port) and performance was normal...

Everything seems okay.  I wonder where the difference is.  Does "dd
if=/dev/zero of=file oflags=direct bs=1M" make any difference?  And can
you vacate a raw partition and try it on there?

-- 
tejun
