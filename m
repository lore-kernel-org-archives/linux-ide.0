From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: LibPATA code issues / 2.6.16 (previously, 2.6.15.x)
Date: Fri, 21 Apr 2006 18:46:36 -0400
Message-ID: <444960CC.2000009@pobox.com>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca> <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca> <4405EC94.2030202@dgreaves.com> <4405FAAE.3080705@dgreaves.com> <Pine.LNX.4.64.0603050637110.30164@p34> <Pine.LNX.4.64.0603050740500.3116@p34> <440B6CFE.4010503@rtr.ca> <440B76B4.5080502@pobox.com> <Pine.LNX.4.64.06042115111
 20.22768@p34> <44493023.4010109@pobox.com> <Pine.LNX.4.64.0604211226120.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35782 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750706AbWDUWq6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Apr 2006 18:46:58 -0400
In-Reply-To: <Pine.LNX.4.64.0604211226120.3701@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Mark Lord <lkml@rtr.ca>, David Greaves <david@dgreaves.com>, Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, smartmontools-support@lists.sourceforge.net

Linus Torvalds wrote:
> 
> On Fri, 21 Apr 2006, Jeff Garzik wrote:
>> You can force the disk to replace the bad sectors by doing a disk-level write:
>>
>> 	dd if=/dev/zero of=/dev/sda1 bs=4k
> 
> NOTE! Obviously don't do this before you've backed up the disk.  Depending 
> on the filesystem, you might just have overwritten something important, or 
> just your pr0n collection ;)
> 
> Jeff, please be a little more careful about telling people commands like 
> that. Some people might cut-and-paste the command without realizing what 
> it's doing as a way to "fix" their problem.

Agreed, though the original poster had already done a 400GB dd from 
/dev/zero...

	Jeff



