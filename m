From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: PATA: RPC now selects HAVE_PATA_PLATFORM for pata platform driver
Date: Tue, 15 Jul 2008 19:44:05 +0100
Message-ID: <20080715184404.GA29991@flint.arm.linux.org.uk>
References: <20080715161250.462581372@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44148 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207AbYGOSol (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jul 2008 14:44:41 -0400
Content-Disposition: inline
In-Reply-To: <20080715161250.462581372@fluff.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-ide@vger.kernel.org

On Tue, Jul 15, 2008 at 05:12:50PM +0100, Ben Dooks wrote:
> The RPC machine type now selects HAVE_PATA_PLATFORM so we can remove
> the special case in the PATA_PLATFORM configuration code.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
