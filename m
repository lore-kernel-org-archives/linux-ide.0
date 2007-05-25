From: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Subject: Re: VIA VT6420: SATA disconnects
Date: Fri, 25 May 2007 16:36:00 +0200
Message-ID: <4656F450.2040707@caiway.nl>
References: <46569341.4020801@sw.ru> <465694E4.9020601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cardassian.kabelfoon.nl ([62.45.45.18]:52104 "EHLO
	cardassian.kabelfoon.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbXEYOgD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 May 2007 10:36:03 -0400
In-Reply-To: <465694E4.9020601@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Vasily Averin <vvs@sw.ru>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, devel@openvz.org

Jeff Garzik wrote:
> Vasily Averin wrote:
>> Jeff, Tejun,
>>
>> Our RHEL5-based OpenVZ linux kernel reports about SATA-related issues:
>> VIA VT6420 SATA RAID Controller on MSI motherboard, x86_64 kernel 
>> based on latest RHEL5 kernel,
>> On booting hardware initialized properly and all works fine some 
>> time, but then it detects timeout and disables devices. We have 
>> replaced SATA cables, but issue didn't go away and still present.
>>
>> I've googled and found similair bugreport in linux-ide@
>> http://www.mail-archive.com/linux-ide@vger.kernel.org/msg06011.html
>>
>> Are you know something about this issue? I've seen that you have 
>> fixed SATA reset procedure recently, probably this issue was fixed 
>> already?
>
> RHEL5 SATA is unfortunately way out of date :(  The next RHEL5 update 
> should include a boatload of fixes.
>
> Try running the latest upstream kernel (2.6.21.3 or 2.6.22-rc2-git7), 
> and see if the problem is reproducible.
>
Jeff,

In the meantime I've taken that disk out of use (although it is still in 
that same machine and connected). So I can easily run tests on it.
I'm not sure I want to build my own (somewhat recent) kernel, because 
that machine serves as our home server. It takes some engineering to 
find time where the family is gone and nobody needs it.
Also it uses xen and I don't know whether I can find the proper patches 
to get it to compile (I find it difficult in debian to find the patches 
that were used to produce a kernel). But if nobody uses it, I could do 
with a xen-less kernel. Hopefully bonnie or somesuch will make the 
problem appear.

Like Vasily I also had it connected to the VIA controller. But the 
problems also appeared when the disk was connected to the Promise 
controller on the same board. So I would, at first sight, not consider 
this a controller issue.

-- Jan Evert

