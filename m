From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 stability and performance
Date: Tue, 04 Mar 2008 09:02:31 +0900
Message-ID: <47CC9197.9050609@gmail.com>
References: <20080219020916.GA29902@denix.org> <20080219043659.GA11936@jim.sh> <47BAF677.5000602@rtr.ca> <20080302061453.GA7291@denix.org> <005d01c87c4c$0d01f550$4d0fa8c0@M2007>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.227]:42671 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbYCDACi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2008 19:02:38 -0500
Received: by qb-out-0506.google.com with SMTP id e11so237029qbe.15
        for <linux-ide@vger.kernel.org>; Mon, 03 Mar 2008 16:02:37 -0800 (PST)
In-Reply-To: <005d01c87c4c$0d01f550$4d0fa8c0@M2007>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabor FUNK <FUNK.Gabor@hunetkft.hu>
Cc: Denys Dmytriyenko <denis@denix.org>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Mark Lord <liml@rtr.ca>

Hello, Gabor.

Gabor FUNK wrote:
> I have/had a similar (hard resetting) problem (2+8 disks, kernel
> 2.6.24), see thread:
> http://www.mail-archive.com/linux-ide@vger.kernel.org/msg15950.html
> 
> I tried replacing the PSU and also run the system with two 650W PSU-s,
> also failed. I also think that PSU shouldn't be the problem as I see they
> eat much less in operation than at spinup.

It's not that simple tho.  Some PSUs which happily spin up all the
drives simultaneously have problems maintaining stable operation
afterwards.  Anyways, if you used two separate PSUs, and didn't see any
change in failure pattern (ie. drives connected to certain PSU fails or
swapping to which PSU the board is connected alleviates the problem),
it's probably safe to say it's not PSU problem.

> Now I replaced the MB and it runs with a different Gigabyte MB with
> the 8 disk in SW RAID6 connected to the 2*4 on board SATA
> connectors (these now use 2+4*ata_piix and 2 ahci kernel drivers)
> and the 2 system disk is on an add-on Silicon Image SiI 3512 card.
> 
> Since the problem is not seen immediately I can't tell whether it is
> better now. It is running cp 1 2, cp 2 3... to 2500 or so, with 1GB
> files then md5sums them, so far the problem not exhibiting. The
> 1st copy didn't finish in a day, so accidentally a second one got
> started (cron) and yesterday an "md: data-check" also started, so
> the system is quite busy now doing disk reads/writes...

Hmmm... Is it still okay?

-- 
tejun
