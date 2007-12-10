From: Tejun Heo <htejun@gmail.com>
Subject: Re: SAS v SATA interface performance
Date: Mon, 10 Dec 2007 16:33:14 +0900
Message-ID: <475CEBBA.3050409@gmail.com>
References: <47506237.3000406@clear.net.nz> <47507F9A.3080109@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:41528 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbXLJHdV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 02:33:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1528661rvb
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 23:33:21 -0800 (PST)
In-Reply-To: <47507F9A.3080109@msgid.tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Richard Scobie <r.scobie@clear.net.nz>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

(cc'ing Jens as it contains some discussion about IO scheduling)

Michael Tokarev wrote:
> Richard Scobie wrote:
>> If one disregards the rotational speed and access time advantage that
>> SAS drives have over SATA, does the SAS interface offer any performance
>> advantage?
> 
> It's a very good question, to which I wish I have an answer myself ;)
> Since I never tried actual SAS controllers with SAS drives, I'll
> reply from ol'good SCSI vs SATA perspective.

Purely from transport layer protocol perspective, SATA has slightly
shorter latency thanks to its simplicity but compared to actual IO
latency, this is negligible and if you throw NCQ and TCQ into play, this
theoretical advantage becomes completely negligible.

> They says that modern SATA drives has NCQ, which is "more
> advanced" than ol'good TCQ used in SCSI (and SAS) drives.
> I've no idea what's "advanced" in it, except of that it
> just does not work.  There's almost no difference with
> NCQ turned on or off, and in many cases turning NCQ ON
> actually REDUCES performance.

NCQ is not more advanced than SCSI TCQ.  NCQ is "native" and "advanced"
compared to old IDE style bus-releasing queueing support which was one
ugly beast which no one really supported well.  The only example I can
remember which actually worked was first gen raptors paired with
specific controller with custom driver on windows.

If you compare protocol to protocol, NCQ should be able to perform as
good as TCQ unless you're talking about monster storage enclosure device
which can have a lot of spindles behind it.  Again, NCQ has lower
overhead but bus latency / overhead don't really matter.

However, that is not to say SATA drives with NCQ support perform as good
as SCSI drives with TCQ support.  SCSI drivers are simply faster and
tend to have better firmware.  There is nothing much operating system
can do about it.

There's one thing we can do to improve the situation tho.  Several
drives including raptors and 7200.11s suffer serious performance hit if
sequential transfer is performed by multiple NCQ commands.  My 7200.11
can do > 100MB/s if non-NCQ command is used or only upto two NCQ
commands are issued; however, if all 31 (maximum currently supported by
libata) are used, the transfer rate drops to miserable 70MB/s.

It seems that what we need to do is not issuing too many commands to one
sequential stream.  In fact, there isn't much to gain by issuing more
than two commands to one sequential stream.

Both raptors and 7200.11 perform noticeably better on random workload
with NCQ enabled.  So, it's about time to update IO schedulers
accordingly, it seems.

Thanks.

-- 
tejun
