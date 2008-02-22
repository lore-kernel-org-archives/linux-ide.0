From: Tejun Heo <htejun@gmail.com>
Subject: Re: JMicron - hard resetting link
Date: Fri, 22 Feb 2008 11:03:22 +0900
Message-ID: <47BE2D6A.6060603@gmail.com>
References: <009401c86d5c$5eb57bf0$4d0fa8c0@M2007> <47B19997.1010404@gmail.com> <003801c86d84$fdae0510$4d0fa8c0@M2007> <47B1B299.3010208@gmail.com> <002f01c86d9c$94542f50$4d0fa8c0@M2007> <47B230CA.9060506@gmail.com> <005c01c86f5d$b050b4e0$4d0fa8c0@M2007> <47B4CF71.5070408@gmail.com> <008901c874d3$10731c80$4d0fa8c0@M2007>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.176]:26823 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921AbYBVCD3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Feb 2008 21:03:29 -0500
Received: by el-out-1112.google.com with SMTP id v27so247405ele.23
        for <linux-ide@vger.kernel.org>; Thu, 21 Feb 2008 18:03:29 -0800 (PST)
In-Reply-To: <008901c874d3$10731c80$4d0fa8c0@M2007>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabor FUNK <FUNK.Gabor@hunetkft.hu>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

Gabor FUNK wrote:
> To sum it up:
> - 1st the 4 disks on the Jmicron controller failed with 1 [chieftek] PSU
> - then it failed with 2 PSU too, but this time the chieftek was only
>   connected to the different 4 disks - on the nvidia controller. MB
>   and other disks were on the other, non-chieftek [650W] PSU.
> - Then I started the tests with only this second PSU, and it ran
>   for about 6 days under heavy testing and array rebuilding and
>   guess what: it failed again.

Eeekk..

> Full kernel log at:
> http://www.huweb.hu/maques/tmp/jmicron/kern0221.log
> 
> Since it is not a "switch on and see" problem, I'm not in too good
> position, so unless someone have a really great idea or observation,
> I seriously have to consider to replace the MB and probably add
> some extra sata controllers.

If you can still do some testing, what happens if you unplug power to
the failed drive and replug it while the system is still running?  Does
hotplug event get triggered and the drive gets recognized again?  If so,
does unplugging and replugging the SATA controller only (w/o powering
down the drive) achieve the same thing?

Thanks.

-- 
tejun
