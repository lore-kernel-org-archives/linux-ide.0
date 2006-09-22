From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: AHCI rev 1.1 -- Command Table base address 128-byte cache line
Date: Fri, 22 Sep 2006 05:52:21 -0400
Message-ID: <4513B255.60900@pobox.com>
References: <d2b7bd0e0609200049g1b966f4bm5d609bd6dc75d1a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:3513 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751154AbWIVJwY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Sep 2006 05:52:24 -0400
In-Reply-To: <d2b7bd0e0609200049g1b966f4bm5d609bd6dc75d1a4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dislo Luo <dislo.bj.luo@gmail.com>
Cc: linux-ide@vger.kernel.org

Dislo Luo wrote:
> My question is I don't see any 128-byte adjusment ?
> Or pointer return from dma_alloc_coherent already in 128 byte alignment ?
> So we don't bother to do it.


dma_alloc_coherent() returns better than 128-byte alignment

