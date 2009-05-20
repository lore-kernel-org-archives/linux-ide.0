From: Tejun Heo <tj@kernel.org>
Subject: Re: utku's sata freeze and hard reset problem
Date: Wed, 20 May 2009 22:30:53 +0900
Message-ID: <4A14060D.5020709@kernel.org>
References: <4A10B2A2.3030003@zeitin.com> <4A126296.80006@kernel.org> <4A140409.6040108@zeitin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53169 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811AbZETNbG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 09:31:06 -0400
In-Reply-To: <4A140409.6040108@zeitin.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Utku Somer <utku@zeitin.com>
Cc: linux-ide@vger.kernel.org

Utku Somer wrote:
> Tejun Heo wrote:
>> Tiemouts without any link layer problem reported.  Hmmm.... Does it
>> help if you disable NCQ with the following command?
>>
>> # echo 1 > /sys/block/sdX/device/queue_depth
>>
>> Thanks
> I had the same idea after I read around the mailing list. (But I was
> ignorant
> on the way, I actually tried to echo 0 into queue_depth first. Good
> thing it doesn't
> let me.) Anyway, it has been running without the errors for more than 12
> hours
> now. I also tried by increasing the disk load, which increases the
> chances of the problem
> occurring. It has not happened yet.
> 
> So yes, disabling NCQ stops the problem from occurring.
> 
> Any ideas?

Timeouts w/ NCQ seem to be one of the most subtle failure modes.  It
can be caused by several different issues - firmware bug, power
problem or link layer problem.  Is there a firmware update available
for your drive?  If there's one, please save the output of "hdparm -I"
before going forward with firmware update.

Thanks.

-- 
tejun
