From: Randolph Chung <randolph@tausq.org>
Subject: Re: [parisc-linux] Re: a fix for NS87415 on C3K broken
Date: Thu, 23 Sep 2004 09:27:50 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040923162750.GX22642@tausq.org>
References: <41501936000007AF@mail-7-bnl.tiscali.it> <4152E6450000004C@mail-3-bnl.tiscali.it>
Reply-To: Randolph Chung <randolph@tausq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gandalf.tausq.org ([64.81.244.94]:36740 "EHLO pippin.tausq.org")
	by vger.kernel.org with ESMTP id S266517AbUIWQ1q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Sep 2004 12:27:46 -0400
Content-Disposition: inline
In-Reply-To: <4152E6450000004C@mail-3-bnl.tiscali.it>
List-Id: linux-ide@vger.kernel.org
To: Joel Soete <soete.joel@tiscali.be>
Cc: Grant Grundler <grundler@parisc-linux.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, parisc-linux@parisc-linux.org

> But when I try to use the ide-cdrom the system carsh with such oops:
> Backtrace:
>  [<000000001017e0d8>] drain_array_locked+0x98/0x148
>  [<000000001017e2c4>] cache_reap+0x13c/0x2b0
>  [<000000001015e574>] worker_thread+0x284/0x330
>  [<0000000010164714>] kthread+0x12c/0x138
>  [<000000001010647c>] ret_from_kernel_thread+0x24/0x38

maybe this will help:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109529103522064&w=2

but we are seeing some of these slab errors with this build that are not
cdrom related too... :(

can you try compiling with slab debug (under kernel debugging)?

randolph
-- 
Randolph Chung
Debian GNU/Linux Developer, hppa/ia64 ports
http://www.tausq.org/
