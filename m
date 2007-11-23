From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc2 displays incorrect DVD description
Date: Fri, 23 Nov 2007 00:35:57 -0800
Message-ID: <20071123003557.36a126bd.akpm@linux-foundation.org>
References: <1354.72.205.227.110.1194986901.squirrel@www.tuxsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41349 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751719AbXKWIgf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Nov 2007 03:36:35 -0500
In-Reply-To: <1354.72.205.227.110.1194986901.squirrel@www.tuxsoft.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: steve@tuxsoft.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>


(cc linux-ide)

On Tue, 13 Nov 2007 15:48:21 -0500 (EST) steve@tuxsoft.com wrote:

> For example, 2.6.23.1:
> 
> Linux version 2.6.23.1 (root@jupiter) (gcc version 4.2.2) #1 SMP PREEMPT
> Fri Oct 26 13:09:09 CDT 2007
> kernel: hdd: HP DVD Writer 1040d, ATAPI CD/DVD-ROM drive
> kernel: hdd: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache,
> UDMA(66)
> 
> and
> 
> 2.6.24-rc2:
> 
> Linux version 2.6.24-rc2 (ironman@jupiter) (gcc version 4.2.2) #1 SMP
> PREEMPT Fri Nov 9 20:41:37 CST 2007
> kernel: hdd: HP DVD Writer 1040d, ATAPI CD/DVD-ROM drive
> kernel: hdd: ATAPI 126X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache,
> UDMA(66)
> 
> The drive seems to work correctly, reading and writing just fine.  I just
> happened to notice this and thought I'd pass it along.
> 
> One other odd thing while looking through the logs, 2.6.23.1 has also
> reported the drive as follows:
> 
> Linux version 2.6.23.1 (root@jupiter) (gcc version 4.2.2) #1 SMP PREEMPT
> Fri Oct 26 13:09:09 CDT 2007
> kernel: hdd: HP DVD Writer 1040d, ATAPI CD/DVD-ROM drive
> kernel: hdd: ATAPI 32X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache,
> UDMA(66)
> 
> Any idea what is going on here?  It's being reported as 48X, 126X, and 32X.
> 

