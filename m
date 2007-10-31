From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Slow hard drives
Date: Wed, 31 Oct 2007 10:38:43 +0000
Message-ID: <20071031103843.3a3dd374@the-village.bc.nu>
References: <1193784294.5955.2.camel@jimin-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49013 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753802AbXJaKhC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 06:37:02 -0400
In-Reply-To: <1193784294.5955.2.camel@jimin-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Court <ben.r.court@googlemail.com>
Cc: linux-ide@vger.kernel.org

> The same comes up for hdb (i have two hard drives installed) and those 3
> messages repeat for a while and then this comes up
> 
> Oct 30 20:45:41 jimin-desktop kernel: [ 69.256000] hda: DMA disabled 
> 
> Oct 30 20:45:41 jimin-desktop kernel: [ 69.592000] ide0: reset: success 

The kernel switches from DMA to PIO (slow) when it finds that the DMA
isn't working properly - its attempting to keep the box running rather
than just dying



What controller ?
