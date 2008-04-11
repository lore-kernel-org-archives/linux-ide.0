From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] make ali_atapi_dma static
Date: Fri, 11 Apr 2008 19:36:08 +0100
Message-ID: <20080411193608.16e7147b@core>
References: <20080411172827.GC25788@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52357 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760228AbYDKSj5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Apr 2008 14:39:57 -0400
In-Reply-To: <20080411172827.GC25788@cs181133002.pp.htv.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 11 Apr 2008 20:28:27 +0300
Adrian Bunk <bunk@kernel.org> wrote:

> This patch makes the needlessly global ali_atapi_dma static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Acked-by: Alan Cox <alan@redhat.com>
