From: 7091@blargh.com
Subject: Re: sata_sil, writing bug with multiple cards?
Date: Tue, 03 Jul 2007 20:22:00 -0700
Message-ID: <courier.468B1258.000018F4@blargh.com>
References: <courier.4689EFD9.0000589A@blargh.com>
            <468A0E24.7020000@gmail.com>
            <courier.468B005A.0000127A@blargh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blargh.com ([24.234.115.147]:51073 "EHLO blargh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670AbXGDDWB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 23:22:01 -0400
In-Reply-To: <courier.468B005A.0000127A@blargh.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 7091@blargh.com
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com

7091@blargh.com writes: 

> Tejun Heo writes:  
> 
>> Sounds awfully similar to the recent nvidia data corruption issue.  It
>> was involving the IOMMU and one of the workarounds was not using IOMMU,
>> IIRC.  Please turn off IOMMU and see what happens.  You can turn IOMMU
>> off by passing "iommu=off" as kernel parameter.  
>> 
>> -- 
>> tejun
> 
> Blast.  I stand corrected - it didn't fix it.  
> 
> I now have 3 300G drives hanging off the add-in card, sda sdb sdc.  I did 
> the following:  
> 
> # Make a RAID5 array of 3 out of the 4 drives I'll eventually be using
> mdadm --create /dev/md6 --chunk=64 --level=raid5 --raid-devices=4 
> /dev/sda1 /dev/sdb1 /dev/sdc1 missing

Here's an odd data point. 

I just broke that array, formatted all three of those partitions seperately, 
mounted and did my ISO copy test. 

All three drives, run one at a time, function fine.  No corruption.
