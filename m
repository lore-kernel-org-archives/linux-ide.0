From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IT8212 driver seems to be broken - no DMA or functionality in
 general
Date: Tue, 12 Aug 2008 12:57:35 +0100
Message-ID: <20080812125735.40f46775@lxorguk.ukuu.org.uk>
References: <4405b24e0808120446s14c42968t870de56a0af109c4@mail.gmail.com>
	<4405b24e0808120449r7ce1466bm3387319549dbaa0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33256 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751636AbYHLMPE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 08:15:04 -0400
In-Reply-To: <4405b24e0808120449r7ce1466bm3387319549dbaa0b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Wells <pete.wells@gmail.com>
Cc: linux-ide@vger.kernel.org

> The post is located at http://kerneltrap.org/node/16482 and looks like this:
> 
> IT8212 driver seems to be broken - no DMA or functionality in general

I sent Jeff a set of fixes for this for the libata driver. Some changes
in libata broke some tricks the pata_it821x driver did. I've rewritten
those bits and parts of the core libata to sort that out and my IT821x
RAID card is back to health with libata. Hopefully .27 will behave
somewhat better therefore.

No idea about the old IDE driver. I don't think anyone maintains that one
any more but it certainly used to work.

Alan
