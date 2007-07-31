From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver
 for CF	interface
Date: Wed, 1 Aug 2007 00:56:40 +0100
Message-ID: <20070801005640.327226db@the-village.bc.nu>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<20070725165326.5331.19920.stgit@localhost.localdomain>
	<46A78322.3080607@ru.mvista.com>
	<46A78E3F.1030904@ru.mvista.com>
	<a414f3b506b7802a717e6e2c08befd1e@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34190 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753760AbXGaXtq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jul 2007 19:49:46 -0400
In-Reply-To: <a414f3b506b7802a717e6e2c08befd1e@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Vitaly Bordug <vitb@kernel.crashing.org>, linux-ide@vger.kernel.org

> The hardware is called (E)IDE, the protocol is called ATA.
> Or that's what I was told -- I think there's some historic
> revisionism involved, too.

ATA is the interface and standards for the ANSI standards based disk
attachment. IDE "Integrated Drive Electronics" is a marketing name used
to cover all sorts of ST412 compatible-ish early interfaces that moved
the brains onto the disk. IDE doesn't really mean much but "brains on
disk", ATA is a real standard.
