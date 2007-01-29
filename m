From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata_if_xfermask() word 51 fix
Date: Mon, 29 Jan 2007 13:16:55 +0000
Message-ID: <20070129131655.6273af2f@localhost.localdomain>
References: <20070129122847.GC11895@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53034 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751356AbXA2NFH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jan 2007 08:05:07 -0500
In-Reply-To: <20070129122847.GC11895@xi.wantstofly.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Mon, 29 Jan 2007 13:28:47 +0100
Lennert Buytenhek <buytenh@wantstofly.org> wrote:

> If word 53 bit 1 isn't set, the maximum PIO mode is indicated by
> the upper 8 bits of word 51, not the lower 8 bits.  Fixes PIO mode
> detection on old Compact Flash cards.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Acked-by: Alan Cox <alan@redhat.com>
