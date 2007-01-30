From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Tue, 30 Jan 2007 17:26:29 +0000
Message-ID: <20070130172629.70ad628d@localhost.localdomain>
References: <45BF5003.3000503@imc-berlin.de>
	<20070130164401.295f9913@localhost.localdomain>
	<45BF7658.1090204@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38571 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965633AbXA3ROi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 12:14:38 -0500
In-Reply-To: <45BF7658.1090204@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

> > Is your IDE controller LBA48 capable ?
> 
> Well TBH I have no contoller. As I said I am using an embedded ARM board.
> The HDD is connected via a FPGA. The internal HDD registers simply memory
> mapped. Works fine. Usually. By now we seem to have trouble with that
> Seagate drive...

The reason I ask is that the stuff which is going wrong is the stuff
which requires two fetches from the drive registers. Could that be a
caching bug (eg caching it, prefetching and thus reading a register too
many times etc) - it seems more likely than the drive given that nobody
else is seeing anything like this.

Alan
