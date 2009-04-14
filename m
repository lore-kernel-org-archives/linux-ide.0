From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_hpt37x: fix HPT370 DMA timeouts
Date: Tue, 14 Apr 2009 17:35:07 +0100
Message-ID: <20090414173507.136ac439@lxorguk.ukuu.org.uk>
References: <200904141839.14755.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50402 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756481AbZDNQgF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Apr 2009 12:36:05 -0400
In-Reply-To: <200904141839.14755.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, stable@kernel.org

On Tue, 14 Apr 2009 18:39:14 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> The libata driver has copied the code from the IDE driver which caused a post
> 2.4.18 regression on many HPT370[A] chips -- DMA stopped to work completely,
> only causing timeouts.  Now remove hpt370_bmdma_start() for good...

Do we need to move it rather than remove it though. I need to look at
that a bit with my HPT370 and see what happens. I suspect that if we get
a failed transfer we need to do the reset somewhere - perhaps qc_issue
before anything hits the chip for the command ?


