From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata_if_xfermask() word 51 fix
Date: Tue, 30 Jan 2007 09:15:20 -0500
Message-ID: <45BF52F8.5020009@garzik.org>
References: <20070129122847.GC11895@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45889 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965462AbXA3OPW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Jan 2007 09:15:22 -0500
In-Reply-To: <20070129122847.GC11895@xi.wantstofly.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-ide@vger.kernel.org

Lennert Buytenhek wrote:
> If word 53 bit 1 isn't set, the maximum PIO mode is indicated by
> the upper 8 bits of word 51, not the lower 8 bits.  Fixes PIO mode
> detection on old Compact Flash cards.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

applied


