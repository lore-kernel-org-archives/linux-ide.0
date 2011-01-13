From: Herbert Poetzl <herbert@13thfloor.at>
Subject: PMP and SEMB messages to SEP
Date: Thu, 13 Jan 2011 20:25:58 +0100
Message-ID: <20110113192558.GE16039@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from MAIL.13thfloor.at ([213.145.232.33]:41371 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632Ab1AMToy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Jan 2011 14:44:54 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


I'm currently trying to wrap my head around SEMB and sending
messages to an attached SEP on some Port Multiplier connected
via eSATA ...

I found that the AHCI driver supports certain well defined
messages (for the activity leds) but I'm not sure what they
actually are, and I have no idea how to utilize them from
userspace at the moment

Basically what I want to do is the following:

 - attach a Smart Enclosure via I2C to the PMP
   (the SEP is basically under my control)
 - retrieve certain values like temperature readings
   from that Smart Enclosure via the SEMB
 - send specific 'command' messages to the SEP to
   control user visible lights on the enclosure

My current Test Setup includes a simple Sil 3726 based PMP
(Dawicontrol DC-6510 PM) which has a connector for a SEP 
using I2C (via the SEMB), connected to an eSATA Port which 
is PMP capable and handles the connected drives quite well.

I had a quick read on the (S)ATA specification regarding
PMP and sending/retrieving messages from the SEMB, but at
the moment, I have no clue how to 'map' that to existing? 
code in the Linux kernel or how that should/could be exposed 
to userspace ...

Any hints/pointers/information would be greatly appreciated.

Many thanks in advance,
Herbert 
