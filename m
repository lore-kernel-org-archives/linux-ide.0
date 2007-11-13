From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: Correct behaviour of an ATA/ATAPI CD Drive
Date: Tue, 13 Nov 2007 21:37:19 +0000
Message-ID: <8b67d60711131337t35283d5aj3f7ca1e6be0dedb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:23871 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763156AbXKMVhV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 16:37:21 -0500
Received: by py-out-1112.google.com with SMTP id u77so2289032pyb
        for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 13:37:20 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am writing a driver for the GD Rom on the SEGA Dreamcast. This
could, loosely, be described as an ATAPI device - it's registers
correspond closely with those in the ATA3 specification but it has
proprietary packet command interface (the SPI which is only partly
reversed) similiar but quite different from the standard ATAPI packet
commands.

Anyway, to cut a long story short, when a command goes wrong, the get
sense packet command does not seem to generate an end of event
interrupt and as a result the command times out (after 60 seconds in
my driver) but the correct sense key is then returned on a read of the
Data register.

My question is whether this (ie sense times out but still returns the
right result) is this behaviour you would expect in a "normal" ATAPI
device?

I am trying to work out what is the best way to handle this - 60
seconds is a long time to wait around if the register will hold the
correct value after a second or less...
