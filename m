From: Sven Riedel <sr@gimp.org>
Subject: Re: SATA command timeouts
Date: Mon, 10 Jul 2006 13:25:51 +0200
Message-ID: <20060710112551.GB14003@localnet>
References: <20060708130037.GA22725@localnet>
Reply-To: sr@gimp.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kamp-dsl.de ([195.62.99.42]:58552 "HELO
	mailout.kamp-dsl.de") by vger.kernel.org with SMTP id S1751320AbWGJLZy
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Jul 2006 07:25:54 -0400
Received: from dsl-mail.kamp.net (mail.kamp-dsl.de [195.62.99.42])
	by sponts.dsl-backup.kamp.de (SPONTS v6.3.6) with SMTP
	id 110C582FA64C-0
	for <linux-ide@vger.kernel.org>; Mon, 10 Jul 2006 11:25:53 +0000
Received: from mx01.kamp-dsl.de (mail.kamp-dsl.de [195.62.99.42])
	by sponts.dsl-backup.kamp.de (SPONTS v6.3.6) with ESMTP
	id 110C582FA5DF-0
	for <linux-ide@vger.kernel.org>; Mon, 10 Jul 2006 11:25:53 +0000
Received: from mail.localnet (turing.localnet [192.168.13.1])
	by mx (Postfix) with ESMTP id AE59B1F864
	for <linux-ide@vger.kernel.org>; Mon, 10 Jul 2006 11:25:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20060708130037.GA22725@localnet>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

On Sat, Jul 08, 2006 at 03:00:37PM +0200, Sven Riedel wrote:
> Hi,
> I hooked up new SATA disks to a machine yesterday and set up a software raid.
> After copying roughly 25 GB of data onto the array all attached drives
> reported command timeouts and wouldn't recover. Only a reboot would help. 
> I tried the same again, this time the drives would timeout after 60 GB of data
> written. I exchanged the CPU, but the same thing occurs. 

Well, seems the second CPU was defunct. After switching back to the first CPU
the hard system crashes stopped occurring.


> My
> next test will be doing write-heavy operations on all four drives
> simulaneously, but without gathering them into a raid array.

Well, it looks like the problem can be reproduced most reliably only when all
four drives are under load. It happens even sooner when they are gathered into
a raid array (I only tested level 5 - could be that the background "rebuild"
after creation is adding additional load which triggers the problem sooner).

Just to rule out an insufficient power supply, I hooked the drives up to a
completely independent PSU and the drives still all suddenly trigger a
command-timeout after a while.

Regs,
Sven

-- 
Sven Riedel                      sr@gimp.org
