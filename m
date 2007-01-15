From: Tejun Heo <htejun@gmail.com>
Subject: Re: ahci problems with sata disk.
Date: Mon, 15 Jan 2007 22:50:56 +0900
Message-ID: <45AB86C0.2020507@gmail.com>
References: <1168785128.7865.13.camel@duo>  <45AB45B2.2080602@gmail.com> <1168859112.6980.8.camel@duo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:54212 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932317AbXAONvJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jan 2007 08:51:09 -0500
Received: by an-out-0708.google.com with SMTP id b33so793780ana
        for <linux-ide@vger.kernel.org>; Mon, 15 Jan 2007 05:51:09 -0800 (PST)
In-Reply-To: <1168859112.6980.8.camel@duo>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kenneth johansson <ken@kenjo.org>
Cc: linux-ide@vger.kernel.org

kenneth johansson wrote:
> On Mon, 2007-01-15 at 18:13 +0900, Tejun Heo wrote:
>> kenneth johansson wrote:
>>> I changed my bios setting for SATA from IDE to AHCI.
>>>
>>> This resulted in some "interesting" read throughput. 
>>>
>>> plots can be found at http://kenjo.org/~ken/sata/
>>> The plots was done on a live disk so some noise is expected but in the
>>> ahci mode the throughput get stuck at 17 MB way to much.
>> It's probably not an ahci problem but more of NCQ implementation problem
>> in the drive firmware.  Please report the result of 'hdparm -I /dev/sdX'
>> and try adjust queue depth and see what happens.
>>
>> http://linux-ata.org/faq.html
>>
> 
> It was, when I turn of NCQ with "echo 1
>> /sys/block/sda/device/queue_depth" I get the same performance as when
> the BIOS is set to IDE.

Can you play with queue depth a bit?  e.g. Benchmark queue depth of 4, 8
and 16.

> I though that NCQ was intended to increase performance ??

Supposedly.

> also the disk is a Westen Digital raptor and it's probably the most
> benchmarked drive one could get so I was not expecting a problem with
> the drive. 

Most benchmarked doesn't make the firmware any better, it seems.  The
raptor Alan talked about, reportedly, locks up after hours of NCQ load too.

-- 
tejun
