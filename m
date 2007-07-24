From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] pata_hpt37x: Fix 2.6.22 clock PLL regression
Date: Tue, 24 Jul 2007 16:07:36 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707241607150.3607@woody.linux-foundation.org>
References: <20070724151748.7e99f4f0@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34048 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753492AbXGXXHs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jul 2007 19:07:48 -0400
In-Reply-To: <20070724151748.7e99f4f0@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jeff@garzik.org



On Tue, 24 Jul 2007, Alan Cox wrote:
> 
> 	Just one version of Linux ago
> 	The PLL code broke - oh no!
> 	But set the right mode
> 	And fix up the code
> 	Makes the PLL timing sync go

Alan, I'm getting a bit worried about you.

		Linus
