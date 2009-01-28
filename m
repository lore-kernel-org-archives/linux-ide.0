From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] ide/net: flip the order of SATA and network init
Date: Tue, 27 Jan 2009 16:48:42 -0800
Message-ID: <20090127164842.0b73cc46@infradead.org>
References: <20090127141952.51785b4f@infradead.org>
	<497F9A49.6060601@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44558 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbZA1Asn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2009 19:48:43 -0500
In-Reply-To: <497F9A49.6060601@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, netdev@vger.kernel.org

On Tue, 27 Jan 2009 18:35:37 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> ACK, ok with me too
> 

ok so... which tree should this go via?

I would guess jgarzik's because he deals with both sata and net ;)

Jeff... how do you want to handle this?

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
