From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Still having problems with sata_promise on all late kernels -
 shutdown too - BISECTED
Date: Tue, 14 Aug 2007 20:42:58 +0400
Message-ID: <46C1DB92.7080806@wasp.net.au>
References: <46C11BBE.6010802@wasp.net.au> <46C1316F.4010906@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:41906 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763264AbXHNQnE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Aug 2007 12:43:04 -0400
In-Reply-To: <46C1316F.4010906@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Brad Campbell wrote:

> http://www.fnarfbargle.com/CIMG1029.JPG (I have posted this screen shot 
> previously. It's still doing exactly the same thing on both boxes).
> 

git-bisect shows up this commit as the guilty party. I can't just revert it on a recent tree though.
Will investigate further.

brad@bkmac:~/git/linux-2.6$ git-bisect good
13b8d09f5de0aaa3153bbccc98baf247387823dc is first bad commit
commit 13b8d09f5de0aaa3153bbccc98baf247387823dc
Author: Tejun Heo <htejun@gmail.com>
Date:   Tue May 15 12:29:22 2007 +0200

     libata: track spindown status and skip spindown_compat if possible

     Our assumption that most distros issue STANDBYNOW seems wrong.  The
     upstream sysvinit and thus many distros including gentoo and opensuse
     don't take any action for libata disks on spindown.  We can skip
     compat handling for these distros so that they don't need to update
     anything to take advantage of kernel-side shutdown.

     Signed-off-by: Tejun Heo <htejun@gmail.com>
     Signed-off-by: Jeff Garzik <jeff@garzik.org>

:040000 040000 6084e11e2d53daf2506d16896d0aa5635f95a9af cd30a7aad2a6a6af63779797889d4d9eed52e473 M 
     drivers
:040000 040000 75e3a561488e2902eed8f197da960e55fbd88f27 a7f586a83645bedbce4b4286c2e9dbcfd69f8f86 M 
     include

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
