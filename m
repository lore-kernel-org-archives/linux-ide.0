From: Tejun Heo <htejun@gmail.com>
Subject: Re: Freeze after disabling write cache with hdparm -W0 /dev/sda
Date: Wed, 11 Jul 2007 17:57:59 +0900
Message-ID: <46949B97.8090703@gmail.com>
References: <46935C4D.40003@onelan.co.uk> <4694669E.7060600@gmail.com> <46949555.9060208@onelan.co.uk> <469496A4.7070902@gmail.com> <46949AB1.80705@onelan.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:11633 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbXGKI6J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jul 2007 04:58:09 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1291601nze
        for <linux-ide@vger.kernel.org>; Wed, 11 Jul 2007 01:58:08 -0700 (PDT)
In-Reply-To: <46949AB1.80705@onelan.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Cc: linux-ide@vger.kernel.org

Simon Farnsworth wrote:
> Tejun Heo wrote:
>> Simon Farnsworth wrote:
>>> Just a thought; is it possible to trigger libata EH from userspace? If
>>> so, we could write a small utility to disable write cache, then force EH
>>> to detect the change.
>> That's automatically done.  libata snoops cache on/off and triggers
>> revalidation but you can request manual rescan by echoing "- - -" to
>> /sys/class/scsi_host/hostX/scan.
>>
> Would it be worth changing our code to do "hdparm -W1 /dev/sda && hdparm
> -W0 /dev/sda", or would this not show anything. The lack of revalidation
> on some drives is what's worrying me a little here.

Revalidation happens after cache property is changed successfully.  What
happens if you request manual rescan while the drive is not repsponding?

-- 
tejun
