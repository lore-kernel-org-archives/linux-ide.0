From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Allow per driver taskfile filters
Date: Fri, 05 Nov 2004 23:25:28 +0000
Message-ID: <1099697126.5630.71.camel@localhost.localdomain>
References: <1099672568.5564.49.camel@localhost.localdomain>
	 <200411052311.45231.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:32709 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261281AbUKFA2Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 19:28:24 -0500
In-Reply-To: <200411052311.45231.bzolnier@elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Gwe, 2004-11-05 at 22:11, Bartlomiej Zolnierkiewicz wrote:
> This covers ide_raw_taskfile() calls, what with do_rw_taskfile()
> ones and HDIO_DRIVE_[CMD,TASK,TASKFILE] ioctls?

do_rw_taskfile could be filtered. I'm not clear if filtering the HDIO
ones
is the right thing to do

> BTW IT8212 is (also) a real hardware RAID and it really deserves
>     its own driver in the future (can share code with libata).
> 
> What is missing in libata to handle it?

ATAPI, working blacklists, testing, the same as to move every other
driver over. When the rest move it can.


