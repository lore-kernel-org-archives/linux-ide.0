From: Tejun Heo <htejun@gmail.com>
Subject: Re: Port multiplier
Date: Tue, 29 Aug 2006 00:38:42 +0900
Message-ID: <44F30E02.8010503@gmail.com>
References: <44F2984F.6030100@clear.net.nz> <44F2EA27.9090603@gmail.com> <20060828153554.GA4471@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.199]:40232 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751083AbWH1Pit (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Aug 2006 11:38:49 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1047392nzf
        for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2006 08:38:49 -0700 (PDT)
In-Reply-To: <20060828153554.GA4471@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: Richard Scobie <r.scobie@clear.net.nz>, linux-ide@vger.kernel.org

Jim Paris wrote:
> Tejun Heo wrote:
>> Richard Scobie wrote:
>>
>>> Can I unmount the connected and mounted array and just unplug the array
>>> with no further concern?
>> The machine will survive and detach the device correctly but 
>> yet-unwritten data will be lost.
> 
> He said he'll unmount it first, so presumably that should avoid most
> data loss?

Ah... missed that line.

> I suppose if you're in the middle of a RAID resync, or
> just ran fdisk or fsck or similar, you could still have unflushed
> data.  Does that mean that hot-unplug is not recommended, and one
> should always do warm-unplug instead?

If you have unmounted and none of fdisk/fsck/RAID resync or anything 
similar is running (which is true most of the time), hot unplugging is 
just fine.

-- 
tejun
