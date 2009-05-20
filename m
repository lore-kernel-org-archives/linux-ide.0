From: Utku Somer <utku@zeitin.com>
Subject: Re: utku's sata freeze and hard reset problem
Date: Wed, 20 May 2009 16:22:17 +0300
Message-ID: <4A140409.6040108@zeitin.com>
References: <4A10B2A2.3030003@zeitin.com> <4A126296.80006@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host-212-154-27-247.parkyeri.net ([212.154.27.247]:50531 "EHLO
	witten.zeitin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbZETNW6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 09:22:58 -0400
In-Reply-To: <4A126296.80006@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Tiemouts without any link layer problem reported.  Hmmm.... Does it
> help if you disable NCQ with the following command?
>
> # echo 1 > /sys/block/sdX/device/queue_depth
>
> Thanks
I had the same idea after I read around the mailing list. (But I was 
ignorant
on the way, I actually tried to echo 0 into queue_depth first. Good 
thing it doesn't
let me.) Anyway, it has been running without the errors for more than 12 
hours
now. I also tried by increasing the disk load, which increases the 
chances of the problem
occurring. It has not happened yet.

So yes, disabling NCQ stops the problem from occurring.

Any ideas?

Thanks
