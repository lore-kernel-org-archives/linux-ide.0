From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall
 back
Date: Thu, 24 Jul 2008 12:13:28 +0100
Message-ID: <20080724121328.5d281b97@lxorguk.ukuu.org.uk>
References: <20080723144226.807475493@fluff.org>
	<20080723144227.253944199@fluff.org>
	<20080723163216.7477be06@lxorguk.ukuu.org.uk>
	<20080723190433.GB26938@trinity.fluff.org>
	<20080723201349.33226d58@lxorguk.ukuu.org.uk>
	<20080724112637.GG26938@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44477 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752072AbYGXLbB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 07:31:01 -0400
In-Reply-To: <20080724112637.GG26938@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, vince@simtec.co.uk

> I had a look, and there doesn't seem to be any way of specifying an
> IRQ for a host port when registering with libata-sff.c, which is a
> problem since we need to be able to either pass-in or have a callback
> to allow our "quirk" to specify a new IRQ for the device.

Currently there is not. However if the device as a whole is wired to IRQ
14 you want to quirk pdev->irq.

