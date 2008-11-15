From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patch] libata fix
Date: Sat, 15 Nov 2008 20:30:36 +0000
Message-ID: <20081115203036.47da5548@lxorguk.ukuu.org.uk>
References: <20081114235640.GA3624@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42579 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751518AbYKOUbJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Nov 2008 15:31:09 -0500
In-Reply-To: <20081114235640.GA3624@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

> Tejun Heo (1):
>       libata: improve phantom device detection
> 

This seems highly inappropriate for 2.6.28

It fixes a case where people get a slow boot. It risks users suddenely
finding some devices and controllers don't detect drives at all. Some are
very quirky on device probe - eg the IT821x in RAID mode.

This could be tested in -next/-mm/2.6.29-rc and backported without much
pain.
