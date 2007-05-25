From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: VIA VT6420: SATA disconnects
Date: Fri, 25 May 2007 03:48:52 -0400
Message-ID: <465694E4.9020601@pobox.com>
References: <46569341.4020801@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52483 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbXEYHtB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 May 2007 03:49:01 -0400
In-Reply-To: <46569341.4020801@sw.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vasily Averin <vvs@sw.ru>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, j.e.van.grootheest@caiway.nl, devel@openvz.org

Vasily Averin wrote:
> Jeff, Tejun,
> 
> Our RHEL5-based OpenVZ linux kernel reports about SATA-related issues:
> VIA VT6420 SATA RAID Controller on MSI motherboard, x86_64 kernel based on latest RHEL5 kernel,
> On booting hardware initialized properly and all works fine some time, but then it detects timeout and disables devices. We have replaced SATA cables, but issue didn't go away and still present.
> 
> I've googled and found similair bugreport in linux-ide@
> http://www.mail-archive.com/linux-ide@vger.kernel.org/msg06011.html
> 
> Are you know something about this issue? I've seen that you have fixed SATA reset procedure recently, probably this issue was fixed already?

RHEL5 SATA is unfortunately way out of date :(  The next RHEL5 update 
should include a boatload of fixes.

Try running the latest upstream kernel (2.6.21.3 or 2.6.22-rc2-git7), 
and see if the problem is reproducible.

	Jeff



