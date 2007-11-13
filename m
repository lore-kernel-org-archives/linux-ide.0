From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Correct behaviour of an ATA/ATAPI CD Drive
Date: Tue, 13 Nov 2007 21:50:02 +0000
Message-ID: <20071113215002.685e9a98@the-village.bc.nu>
References: <8b67d60711131337t35283d5aj3f7ca1e6be0dedb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39316 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762164AbXKMVun (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 16:50:43 -0500
In-Reply-To: <8b67d60711131337t35283d5aj3f7ca1e6be0dedb6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian McMenamin <lkmladrian@gmail.com>
Cc: linux-ide@vger.kernel.org

> Anyway, to cut a long story short, when a command goes wrong, the get
> sense packet command does not seem to generate an end of event
> interrupt and as a result the command times out (after 60 seconds in
> my driver) but the correct sense key is then returned on a read of the
> Data register.

Could be the case for a weird device.

> My question is whether this (ie sense times out but still returns the
> right result) is this behaviour you would expect in a "normal" ATAPI
> device?

No. I would take it as indication of an IRQ delivery problem, or given
the device you have perhaps an expectation that request sense must be
issued as a polling command with nIEN.
