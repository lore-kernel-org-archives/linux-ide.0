From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: bug: AHCI: Serial ATA to CompactFlash adapter loops endlessly
Date: Sat, 16 Dec 2006 11:49:20 -0500
Message-ID: <45842390.1000102@pobox.com>
References: <20061117211135.GO7299@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34887 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161189AbWLPQtX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Dec 2006 11:49:23 -0500
In-Reply-To: <20061117211135.GO7299@kvack.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-ide@vger.kernel.org

Benjamin LaHaise wrote:
> Hello Jeff,
> 
> While trying out a CompactFlash card on Serial ATA to CF adapter, I'm 
> running into a machine that loops endlessly after attempting to disable 
> DMA due to blacklisting.  The adapter itself works with a different CF 
> card that isn't blacklisted and uses DMA.  Note that most CompactFlash 
> should not be blacklisted, rather the adapters that don't wire up the DMA 
> line should be worked around by the system owner with ideX=nodma (which 
> is definately the case with some of the WRAP boards, which could perhaps 
> be worked around by detecting their BIOS).  Anyway, I'm game for testing 
> any patches/ideas that folks have.  Thanks,

Did you ever figure anything out in this direction?

As you saw on IRC, I might start poking at a SATA<->CF adapter in my 
quest to build a near-silent x86 machine.

	Jeff



