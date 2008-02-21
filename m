From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 not configuring drive right?
Date: Thu, 21 Feb 2008 10:23:51 +0900
Message-ID: <47BCD2A7.1030504@gmail.com>
References: <47BB8346.4070400@fhtw-berlin.de> <47BBA66C.7050900@gmail.com> <47BC7D47.9060608@fhtw-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:50246 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756800AbYBUBX7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Feb 2008 20:23:59 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2373591wxd.4
        for <linux-ide@vger.kernel.org>; Wed, 20 Feb 2008 17:23:58 -0800 (PST)
In-Reply-To: <47BC7D47.9060608@fhtw-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Johann-Christoph Jacob <johann-christoph.jacob@fhtw-berlin.de>
Cc: linux-ide@vger.kernel.org

Johann-Christoph Jacob wrote:
> my problem is not with the transfer mode but with the NCQ queue_depth.
> My bootlog shows:
> ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 1)
> but i would like it to show:
> ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 31/32)
> or something similar.
> I was not exact enough concerning the writeability of
> /sys/block/sda/device/queue_depth
> The file is not read only but writing to it fails:
> echo 31 > /sys/block/sda/device/queue_depth
> bash: echo: write error: Invalid argument

Right.

>>> ATA device, with non-removable media
>>>         Model Number:       WDC WD1200BEVS-07LAT0                   
>>>         Serial Number:      WD-WXE906801963
>>>         Firmware Revision:  01.06M01
>>> Standards:
>>>         Supported: 7 6 5 4 
>>>         Likely used: 7
>>> Configuration:
>>>         Logical         max     current
>>>         cylinders       16383   16383
>>>         heads           16      16
>>>         sectors/track   63      63
>>>         --
>>>         CHS current addressable sectors:   16514064
>>>         LBA    user addressable sectors:  234441648
>>>         LBA48  user addressable sectors:  234441648
>>>         device size with M = 1024*1024:      114473 MBytes
>>>         device size with M = 1000*1000:      120034 MBytes (120 GB)
>>> Capabilities:
>>>         LBA, IORDY(can be disabled)
>>>         Queue depth: 1

Hmm... Here it is.  Interesting.  The drive is reporting queue depth of
1.  Interesting.  This is the first time I see this.  The drive is
telling libata that it supports NCQ and the max queue depth is 1 and
libata configures it accordingly.  I'll ask wd about it.

Thanks.

-- 
tejun
