From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] irq handler must disable the handled irq
Date: Mon, 27 Oct 2008 16:41:06 +0100
Message-ID: <20081027154106.GA27227@nuty>
References: <1225116107-9753-1-git-send-email-n0-1@freewrt.org> <20081027141509.2d0be2c7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:56838 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbYJ0Prn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 11:47:43 -0400
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id D239B38C2BF5
	for <linux-ide@vger.kernel.org>; Mon, 27 Oct 2008 16:40:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081027141509.2d0be2c7@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Mon, Oct 27, 2008 at 02:15:09PM +0000, Alan Cox wrote:
> You can't call disable_irq in an IRQ handler. What are you actually
> trying to do ?

Well, what I'm trying to do is getting the driver to a working state.
But it seems like I don't know what I'm actually doing. :/

The symptom I discovered was rb532_pata_irq_handler() being called over
and over again, endlessly. Calling disable_irq() from within stopped
that, so I assumed it to be right (obviously the wrong direction for a
proof).

As the working driver for 2.6.19 I have here is not based on libata, I'm
not quite sure how much code is still required and where to hook it into
the libata subsystem.

Greetings, Phil
