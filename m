From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata pm
Date: Mon, 28 Jan 2008 21:03:48 +0900
Message-ID: <479DC4A4.30809@gmail.com>
References: <52279.82.140.50.2.1201370600.squirrel@ssl.cavemail.org>          <49398.82.140.50.2.1201377943.squirrel@ssl.cavemail.org>          <479BC34D.2000007@gmail.com>       <49407.82.140.63.93.1201397926.squirrel@ssl.cavemail.org>    <49713.82.140.63.93.1201462475.squirrel@ssl.cavemail.org>    <479D2D3C.4050102@gmail.com> <51861.82.140.47.248.1201516318.squirrel@ssl.cavemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:40224 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbYA1MD7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jan 2008 07:03:59 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1672754rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 28 Jan 2008 04:03:53 -0800 (PST)
In-Reply-To: <51861.82.140.47.248.1201516318.squirrel@ssl.cavemail.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dusty@gmx.li
Cc: linux-ide@vger.kernel.org

Hello, Dusty.

dusty@gmx.li wrote:
> Shuffling the drives did not change anything to the linkspeed of the 3
> ports running with 1.5 Gbps. Looks like the problem is port-related.

Hmm... Okay.  Maybe the signal traces or connectors have some problems.
 But 3.0Gbps on downstream port doesn't make any difference anyway so
unless it leads to errors, it should be fine.

> The first PSU (Multilane) offers (measured) 12,20 V on both lanes. This
> falls during read/write access on all drives attached down to 12,10 V.

That explains the PHY dropouts.  I've even seen drives to do hard reset
accompanying emergency head unload due to voltage dropping when high IO
load hits.  Of course, data in cache is lost.

> The second PSU (Singlelane) offers (measured) 11,75 V. This doesn't change
> during read/write access on all drives attached. I tested the second PSU
> without anything attached and it still offered 11,75 V.

11.75 is still in spec and it doesn't fluctuate.  I like this power much
better.

> I will try to add another PSU this evening and remeasure.
> Currently the whole machine needs about 350W.
> The PSUs are Targan 500W (Multilane - 2x12V 10A)

Maybe one of the lane is only connected to video power connectors?
IIRC, that was the idea of multilane power anyway.

> and Noname 350W (Singlelane - 1x12V 10A) so this 'should' be enough...
> 
> This night i copied the backup back to the first raid (the Maxtor drives)
> without any error but during the transfer i got this on the second
> (mounted but unused) raid:
> ata10.00: failed to read SCR 1 (Emask=0x40)
> ata10.01: failed to read SCR 1 (Emask=0x40)
> ata10.02: failed to read SCR 1 (Emask=0x40)
> ata10.03: failed to read SCR 1 (Emask=0x40)
> ata10.04: failed to read SCR 1 (Emask=0x40)
> ata10.05: failed to read SCR 1 (Emask=0x40)
> ata10.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata10.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata10.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata10.02: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 1 cdb 0x0 data 0
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

Timeout during heavy IO can be caused from a number of things and bad
power is one of them.

Please lemme know your test result.

-- 
tejun
