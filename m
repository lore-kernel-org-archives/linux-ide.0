From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem with PCMCIA IDE
Date: Sun, 18 Nov 2007 22:37:25 +0000
Message-ID: <20071118223725.19c2424b@the-village.bc.nu>
References: <20071118202309.GE15355@shallowsky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56113 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753295AbXKRWjG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:39:06 -0500
In-Reply-To: <20071118202309.GE15355@shallowsky.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akkana Peck <akkana@shallowsky.com>
Cc: linux-ide@vger.kernel.org

On Sun, 18 Nov 2007 12:23:09 -0800
Akkana Peck <akkana@shallowsky.com> wrote:

> I've been having problems getting PCMCIA IDE to work on my Vaio
> laptop on recent kernels (I've been working most with 2.6.23.1 and
> .8). I've been hesitant to report it as a kernel bug because it
> may very well be a problem with my .config parameters -- the CDROM

Does the same happen if you disable the tickless NOHZ kernel option ?

Alan
