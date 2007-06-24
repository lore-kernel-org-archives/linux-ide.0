From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: SATA RAID5 speed drop of 100 MB/s
Date: Sun, 24 Jun 2007 19:52:54 +0400
Message-ID: <467E9356.1030200@msgid.tls.msk.ru>
References: <20070620224847.GA5488@alinoe.com> <4679B2DE.9090903@garzik.org> <20070622214859.GC6970@alinoe.com> <467CC5C5.6040201@garzik.org> <20070623125316.GB26672@alinoe.com> <467DA1F5.2060306@garzik.org> <467E5C5E.6000706@msgid.tls.msk.ru> <20070624125957.GA28067@gallifrey> <Pine.LNX.4.64.0706241021030.12207@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:21797 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755695AbXFXPw6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Jun 2007 11:52:58 -0400
In-Reply-To: <Pine.LNX.4.64.0706241021030.12207@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, Jeff Garzik <jeff@garzik.org>, Carlo Wood <carlo@alinoe.com>, Tejun Heo <htejun@gmail.com>, Manoj Kasichainula <manoj@io.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Justin Piszcz wrote:
> Don't forget about max_sectors_kb either (for all drives in the SW RAID5
> array)
> 
> max_sectors_kb = 8
> $ dd if=/dev/zero of=file.out6 bs=1M count=10240
> 10737418240 bytes (11 GB) copied, 55.4848 seconds, 194 MB/s
> 
> max_sectors_kb = 128
> 10737418240 bytes (11 GB) copied, 22.6298 seconds, 474 MB/s

Well.  You're comparing something different.  Yes, this
thread is about linux software raid5 in the first place,
but I were commenting about [NT]CQ within a single drive.

Overall, yes, the larger your reads/writes to the drive
becomes, the faster its linear performance is.  Yet you
have to consider real workload instead of very synthetic
dd test.  It may be good approcsimation of a streaming
video workload (when you feed a large video file over
network or something like that), but even with this,
you probably want to feed several files at once (different
files to different clients), so single-threaded test
here isn't very useful.  IMHO anyway, and good for a
personal computer test.

/mjt
