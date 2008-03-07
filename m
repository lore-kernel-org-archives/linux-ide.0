From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] Disk shock protection (revisited)
Date: Fri, 7 Mar 2008 22:43:35 +0000
Message-ID: <20080307224335.0412d8a2@core>
References: <87skzgd1zk.fsf@denkblock.local>
	<20080226123946.75dbe3d2@core>
	<87mypl8p49.fsf@denkblock.local>
	<20080228111349.6831925c@core>
	<87bq5qfm2v.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37552 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753936AbYCGW4V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Mar 2008 17:56:21 -0500
In-Reply-To: <87bq5qfm2v.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

> This business of aborting commands is exactly what I haven't a clue
> about. At first I thought I could do something similar to
> ata_do_link_abort but I obviously want to avoid the need for a soft
> reset before issuing idle immediate. How am I to go about it?

See the ATA 7 specification, and then stare at libata, and then stress a
lot and realise it is going to be very hard.

Seriously - get the queue freezing stuff working first and then I'm sure
one of us libata folk who actually have the misfortune to read these
specs regularly will add in the details like that.

