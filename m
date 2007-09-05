From: Paul Wouters <paul@xelerance.com>
Subject: CF as IDE with pata_via or VIA_IDE fails on lexar CF
Date: Wed, 5 Sep 2007 18:31:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709051702590.24400@newtla.xelerance.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from newtla.xelerance.com ([193.110.157.143]:39959 "EHLO
	newtla.xelerance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756574AbXIEXLI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 19:11:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi,

I followed the discussion on this list about people with CF as IDE
problems, eg: http://www.mail-archive.com/linux-ide@vger.kernel.org/msg07402.html

I was using Lexar Premium 80x 512MB cards on a VIA VT823x chipset (both on a
VIA cpu and an P4 board), and they also fail to boot linux. What I tried:

- set pio mode 4 in the BIOS
- disable DMA in the BIOS
- boot with ide=nodma
- boot with noapic
- try booting with sata_via
- try booting with old VIA_IDE

A PQI HiSpeed 40 2GB card worked without problems.  A Kingston 2GB
(no other identifying numbers on the card) also worked without problems.

I tried two different CF adapters, same results.

I now have a few spare, to me useless, Lexar Premium 512M cards lying
around. If anyone working on the CF-IDE issues would like to receive
one for free, send me an email.

Paul
