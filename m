From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] include old-style rb532 CompactFlash support
Date: Wed, 29 Oct 2008 19:56:46 +0100
Message-ID: <20081029185646.GA17108@nuty>
References: <20081027205124.GB27227@nuty> <1225304359-11290-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:50330 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbYJ2Szr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 14:55:47 -0400
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id 0C98C3891A92
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 19:55:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1225304359-11290-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Wed, Oct 29, 2008 at 07:19:19PM +0100, Phil Sutter wrote:
> The changes to gpio.c are rather a dirty hack - the existing code for
> gpiolib is so broken, I could not find a way to use the set/get
> functions to cleanly access any register other than GPIOD.

Just read up on gpiolib: the rb532 code is not broken, gpiolib just
doesn't support pin multiplexing. I'll contact the linux-mips list for
the best solution.

Greetings, Phil
