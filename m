From: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Fix ALi15x3 DMA on sparc64 (maybe others)
Date: Thu, 17 Jul 2003 23:38:49 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030717233849.102250cb.davem@redhat.com>
References: <20030717181410.GI1171@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pizda.ninka.net ([216.101.162.242]:50409 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271736AbTGRGdp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jul 2003 02:33:45 -0400
In-Reply-To: <20030717181410.GI1171@phunnypharm.org>
List-Id: linux-ide@vger.kernel.org
To: Ben Collins <bcollins@debian.org>
Cc: marcelo@conectiva.com.br, alan@redhat.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, 17 Jul 2003 14:14:10 -0400
Ben Collins <bcollins@debian.org> wrote:

> Attached is a patch that is known to fix atleast the DMA corruption
> occuring on sparc64 in 2.4.x kernels for ALi15x3 IDE chipsets. I think
> Alan hinted that someone also reported it fixed a similar problem on
> alpha.

Marcelo, please apply this.  Not only does it indeed fix
problems on Sparc64 and Alpha, it also is ACK'd by Alan
and already present in 2.5.x

Thanks.
