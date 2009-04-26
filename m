From: Andrey Gusev <a.gusev1980@mail.ru>
Subject: Re: Delay on intialization ide subsystem(most likely)
Date: Mon, 27 Apr 2009 02:20:28 +0400
Message-ID: <20090427022028.2f922b6f@power-debian>
References: <20090425170203.74603b9c@power-debian>
	<200904251648.38389.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx30.mail.ru ([94.100.176.44]:4906 "EHLO mx30.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbZDZWUm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Apr 2009 18:20:42 -0400
In-Reply-To: <200904251648.38389.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com

On Sat, 25 Apr 2009 16:48:38 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> 
> Hi,
> 
> On Saturday 25 April 2009 15:02:03 Andrey Gusev wrote:
> > Hello!
> > 
> > I have tested linux-2.6.30-rc3 on my system and find some problems.
> > One of them is delaying on initialization IDE subsystem. I don't
> > have this problem on 2.6.29.1. The difference is looked on log of
> > dmesg.
> 
> Unfortunately this doesn't give us any hint about the root cause of
> the bug so please try narrowing the problem down to the specific
> change using git-bisect (sorry, there were 212 drivers/ide/ commits
> during v2.6.29..v2.6.30-rc3 and much much more non-drivers/ide/ ones).
> 
> Thanks,
> Bart
> 

I will finish this, but this machine is not very fast. So, may be partly
result will be useful. I did checks:

git bisect start
# good: [8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84] Linux 2.6.29
git bisect good 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84
# bad: [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3
git bisect bad 091069740304c979f957ceacec39c461d0192158
# good: [40f07111be99b71c1e8d40c13cdc38445add787f] V4L/DVB (11166): pvrusb2: Implement status fetching from sub-devices
git bisect good 40f07111be99b71c1e8d40c13cdc38445add787f
# good: [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg: slicoss: Specify the license for Sahara SXG and Slicoss drivers
git bisect good ba0e1ebb7ea0616eebc29d2077355bacea62a9d8

git bisect start 'drivers/ide/'
# good: [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg: slicoss: Specify the license for Sahara SXG and Slicoss drivers
git bisect good ba0e1ebb7ea0616eebc29d2077355bacea62a9d8
# bad: [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3
git bisect bad 091069740304c979f957ceacec39c461d0192158
# good: [e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d] ide-cd: convert cdrom_decode_status() to use switch statements
git bisect good e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d
# good: [3153c26b54230d025c6d536e8d3015def4524906] ide: refactor tf_read() method
git bisect good 3153c26b54230d025c6d536e8d3015def4524906

Best,
Andrey
