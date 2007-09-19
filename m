From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATAPI tape drives broken with libata
Date: Wed, 19 Sep 2007 21:50:35 +0100
Message-ID: <20070919215035.1d4557ff@the-village.bc.nu>
References: <46D5F97B.3050808@redhat.com>
	<20070830005006.6951265a@the-village.bc.nu>
	<46D6EC3B.8090306@redhat.com>
	<20070831151903.37a60ba9@the-village.bc.nu>
	<46E966C2.1050405@rtr.ca>
	<46E97FE8.5090304@rtr.ca>
	<46E9848E.2000704@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52888 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751184AbXISUns (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Sep 2007 16:43:48 -0400
In-Reply-To: <46E9848E.2000704@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Chuck Ebbert <cebbert@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, craig48@swbell.net


> I can read and write the tape successfully, and the written data matches
> what is later read back from it.
> 
> Here's the hack I used.  Not ready for mainline, but perhaps it will
> help Alan or whomever come up with something nice for Jeff.

Its possible we should just scream and shout but for robustness and
paranoia I just added ATA_HORKAGE_DRQ and skip the error setup in the
case that HORKAGE_DRQ is set.

Just need the identify data now..
