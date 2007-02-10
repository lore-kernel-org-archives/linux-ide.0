From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Sat, 10 Feb 2007 11:19:18 +0100
Message-ID: <1171102758.19041.5.camel@localhost>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com>
	 <45CC3FE5.2010408@gmail.com> <1171035949.23440.4.camel@localhost>
	 <200702091841.45125.rootkit85@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nn7.de ([85.214.94.156]:33687 "EHLO nn7.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753094AbXBJKTV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Feb 2007 05:19:21 -0500
In-Reply-To: <200702091841.45125.rootkit85@yahoo.it>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matteo Croce <rootkit85@yahoo.it>
Cc: linux-ide@vger.kernel.org

On Fri, 2007-02-09 at 18:41 +0100, Matteo Croce wrote:
> On Friday 09 February 2007 16:45:49 you wrote:
> > On Fri, 2007-02-09 at 04:33 -0500, Tejun Heo wrote:
> > > Root Kit wrote:
> >[...]
> > Hmmhh I cannot really reproduce this benchmark. Matteo, with which
> > benchmarking program did you produce this ?
> >[...]
> bonnie++ from ubuntu repos

OK, I reran bonnie++ -d /tmp/ on a unencrypted partition - results are
here http://nn7.de/bench/ahci.html . Looks like it is slightly faster
for sequential block write (2MB/s faster) and sequential read using
putc()  (1MB/s faster), though putc() is slowed down by 6MB/s.

However what may make it worth is that I don't see any errors on
suspend/resume anymore...

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
