From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Tue, 30 Jan 2007 18:19:29 +0100
Message-ID: <45BF7E21.7010605@imc-berlin.de>
References: <45BF5003.3000503@imc-berlin.de>	<20070130164401.295f9913@localhost.localdomain>	<45BF7658.1090204@imc-berlin.de> <20070130172629.70ad628d@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:2739 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965635AbXA3RTb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 12:19:31 -0500
In-Reply-To: <20070130172629.70ad628d@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan wrote:
>>> Is your IDE controller LBA48 capable ?
>> Well TBH I have no contoller. As I said I am using an embedded ARM board.
>> The HDD is connected via a FPGA. The internal HDD registers simply memory
>> mapped. Works fine. Usually. By now we seem to have trouble with that
>> Seagate drive...
> 
> The reason I ask is that the stuff which is going wrong is the stuff
> which requires two fetches from the drive registers. Could that be a
> caching bug (eg caching it, prefetching and thus reading a register too
> many times etc) - it seems more likely than the drive given that nobody
> else is seeing anything like this.

Hmm. Don't think so. Since the use of ioremap() I think the MMU treats the
area as none-cacheable, right?

Steven
