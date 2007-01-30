From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Tue, 30 Jan 2007 18:07:27 +0000
Message-ID: <20070130180727.594b35d0@localhost.localdomain>
References: <45BF5003.3000503@imc-berlin.de>
	<20070130164401.295f9913@localhost.localdomain>
	<45BF7658.1090204@imc-berlin.de>
	<20070130172629.70ad628d@localhost.localdomain>
	<45BF7E21.7010605@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55192 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965656AbXA3Rze (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 12:55:34 -0500
In-Reply-To: <45BF7E21.7010605@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

> Hmm. Don't think so. Since the use of ioremap() I think the MMU treats the
> area as none-cacheable, right?

Thats only the first half of the story. If you don't decode byte level
fetches in the FPGA or the code is doing something like


		read 16 bit value
		shift 8
		return half

for 8 bit reads you'll get wrong answers.

Alan
