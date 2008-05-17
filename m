From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata sata_via unusual behaviour
Date: Sat, 17 May 2008 23:04:43 +0100
Message-ID: <20080517230443.2a3eedff@core>
References: <3bbeafe90805011018o28f46794h369242ccb02b7ced@mail.gmail.com>
	<3bbeafe90805011158n5b45283awd43a7a534ba11456@mail.gmail.com>
	<20080501195823.79786815@core>
	<3bbeafe90805011216l1780cf5bm9bad77a414062643@mail.gmail.com>
	<20080501211019.21b0701d@core>
	<3bbeafe90805170656v58ad2dc5nb6c1efcf55b8f2cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60629 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757851AbYEQWQJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 May 2008 18:16:09 -0400
In-Reply-To: <3bbeafe90805170656v58ad2dc5nb6c1efcf55b8f2cf@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo <paoletto@gmail.com>
Cc: linux-ide@vger.kernel.org

> real    5m16.352s
> user    0m0.132s
> sys     0m6.244s

So the CPU usage is ok

> root@ubuntu:/media/disk/movies# ls -la Lo\ squalo.avi
> -rw-r----- 1 1000 1001 1559521280 2008-03-30 06:37 Lo squalo.avi
> 
> it means roughly those old 5mb/sec.
> In the meanwhile i checked with top, and all the cpu cycles were taken
> by the disk (about 98.0%wa and 0.0%id)

98.0%wa - wait time, not CPU time.

Its still a very slow copy rate unless the disks are on the same IDE
channel. How is the disk set up - ext3 direct or via raid/lvm ?

Also is a copy of the movie to /dev/null slow or fast, ditto a copy
from /dev/zero to disk of that sort of size ?

Alan
