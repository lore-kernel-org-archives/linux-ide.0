From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Subject: Re: Freeze after disabling write cache with hdparm -W0 /dev/sda
Date: Wed, 11 Jul 2007 09:54:09 +0100
Message-ID: <46949AB1.80705@onelan.co.uk>
References: <46935C4D.40003@onelan.co.uk> <4694669E.7060600@gmail.com> <46949555.9060208@onelan.co.uk> <469496A4.7070902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay3.mail.uk.clara.net ([80.168.70.183]:40217 "EHLO
	relay3.mail.uk.clara.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbXGKIyQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jul 2007 04:54:16 -0400
In-Reply-To: <469496A4.7070902@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Simon Farnsworth wrote:
>> Just a thought; is it possible to trigger libata EH from userspace? If
>> so, we could write a small utility to disable write cache, then force EH
>> to detect the change.
> 
> That's automatically done.  libata snoops cache on/off and triggers
> revalidation but you can request manual rescan by echoing "- - -" to
> /sys/class/scsi_host/hostX/scan.
> 
Would it be worth changing our code to do "hdparm -W1 /dev/sda && hdparm
-W0 /dev/sda", or would this not show anything. The lack of revalidation
on some drives is what's worrying me a little here.
-- 
Simon Farnsworth
