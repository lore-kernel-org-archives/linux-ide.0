From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch 2.6.30-rc2 2/2] palm_bk3710:  UDMA performance fix
Date: Tue, 21 Apr 2009 14:02:22 +0400
Message-ID: <49ED99AE.3020100@ru.mvista.com>
References: <200904201841.10989.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:19270 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753446AbZDUKBZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Apr 2009 06:01:25 -0400
In-Reply-To: <200904201841.10989.david-b@pacbell.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, DaVinci <davinci-linux-open-source@linux.davincidsp.com>

David Brownell wrote:

> Fix UDMA throughput bug:  tCYC averages t2CYCTYP/2, but the code
> previously assumed it was the same as t2CYCTYP.

    Wow, thanks for finding it!
    IIUC however, this should have only affected UDMA writes, not reads 
because on reads the device controls the strobe timing.

> (That is, it was using just one clock edge, not both.)

    There's no way only one clock edge could have been used since it would 
have resulted in CRC errors, so this comment is not to the point.

> On one system this change increased throughput by almost 4x: UDMA/66
> sometimes topped 23 MB/sec (on a drive known to do much better).  On
> another system it was around a 10% win (UDMA/66 up to 7+ MB/sec).

    It's interesting that on my DM6467 EVM UDMA/66 reads topped at about 29-30 
MB/s even without this patch (measuread with hdparm), and on DM6446 EVM they 
were only slightly slower...

> The difference might be caused by the ratio between memory and IDE
> clocks.  In the system with large speedup, this was exactly 2 (as a
> workaround for a rev 1.1 silicon bug).  The other system used a more
> standard ratio of 1.63 (and rev 2.1 silicon) ... clock domain synch
> might have some issues, they're not unheard-of.

    Interesting...

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

    The patch itself is:

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
