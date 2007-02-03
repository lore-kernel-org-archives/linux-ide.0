From: Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Sat, 03 Feb 2007 14:47:07 -0500
Message-ID: <45C4E6BB.6020307@pobox.com>
References: <20070202151856.GD1625@htj.dyndns.org> <20070202211441.GA2933@artsapartment.org> <45C3EECF.2080100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lollipop.listbox.com ([208.210.124.78]:33998 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbXBCUKc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 15:10:32 -0500
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by lollipop.listbox.com (Postfix) with ESMTP id E981741FD95
	for <linux-ide@vger.kernel.org>; Sat,  3 Feb 2007 14:48:42 -0500 (EST)
In-Reply-To: <45C3EECF.2080100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Art Haas <ahaas@airmail.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Tejun Heo wrote:
> ..
> Then, PACKET_IDENTIFY after configuring transfer mode fails with
> -ENOENT.  Meaning it saw (status & (ATA_BUSY|ATA_DRQ|ATA_ERR|ATA_DF)) ==
> 0 in HSM_ST.
..
> So, PATA gurus, can you bless us with enlightenment?  :-)

Heh.. guaranteeing detection of all the strange implementations out there
is part black magic.

But the simple thing to do here is, just for fun, hack the code
to do the infamous 50 millisecond hard wait before issuing the PACKET_IDENTIFY.
If that fixes it, then it's just a matter of tuning to discover the real
amount of delay required, and a nicer way of doing the delay.

Also, zero out the features register before issuing PACKET_IDENTIFY,
if the code isn't already doing that.

After the drive asserts BUSY, and later deasserts BUSY,
there might be a slight delay before the drive asserts DRQ.
So, it is possible for the status to read zeros in the important bits.

My suggestion is to wait up to the infamous 50 milliseconds again here,
if needed.

????

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
