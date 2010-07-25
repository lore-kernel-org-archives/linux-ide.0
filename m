From: Tejun Heo <tj@kernel.org>
Subject: Re: support for drives larger than 2TiB
Date: Sun, 25 Jul 2010 09:56:09 +0200
Message-ID: <4C4BEE19.8030106@kernel.org>
References: <4C4AB952.9030705@kernel.org>            <1279974966.11927.26.camel@lithium.local.net> <92061.1279979348@localhost> <4C4B7255.2070505@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39347 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364Ab0GYH4P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Jul 2010 03:56:15 -0400
In-Reply-To: <4C4B7255.2070505@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stan Hoeppner <stan@hardwarefreak.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On 07/25/2010 01:08 AM, Stan Hoeppner wrote:
> Valdis.Kletnieks@vt.edu put forth on 7/24/2010 8:49 AM:
> 
>> As a side consideration - moving from 512 to 4K moves the associated limit from
>> 2 TiB to 16 TiB.  Given the current rate of device density increase, how much
>> time will that buy us, and what do we do then?

I don't really see it happening on ATA hard drives.  Maybe on USB /
external ones.  There simply are too many compatibility implications.

> In the not too distance future, PCs/laptops/netbooks will all
> transition to shipping with SSD as their sole/main internal storage
> device, with USB3/eSATA thumb drives of 1TB and above permanently
> replacing external USB/eSATA mechanical drives.

After hearing the same story for the good part of the decade, I'm a
bit skeptical about this too.  The unit capacity price ratio hasn't
really changed that much.  Maybe requirements for storage capacity
have reached / are approaching saturation point, so as long as the
price keeps coming down, SSDs can be mainstream without closing the
unit capacity price difference.  At this point, hybrid seems much more
realistic to me, but then again, maybe we really are reaching the
saturation point.  Who knows?

Thanks.

-- 
tejun
