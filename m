From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] pata_platform: move ARCH_RPC to use MACH_HAS_PATA_PLATFORM
Date: Mon, 19 Nov 2007 12:50:15 +0000
Message-ID: <20071119125014.GM31701@flint.arm.linux.org.uk>
References: <20071119124340.GJ26444@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40947 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbXKSMvV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 07:51:21 -0500
Content-Disposition: inline
In-Reply-To: <20071119124340.GJ26444@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, Sam Ravnborg <sam@ravnborg.org>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Vincent Sanders <vince@simtec.co.uk>

On Mon, Nov 19, 2007 at 12:43:40PM +0000, Ben Dooks wrote:
> Move ARCH_RPC to using MACH_HAS_PATA_PLATFORM as an example
> of using this new configuration.

I thought that it had been agreed (on linux-arch) that the name of these
options shall be HAVE_foo to enable a driver configuration symbol of
foo.

IOW, this should be HAVE_PATA_PLATFORM not MACH_HAS_PATA_PLATFORM.

(Not sure who introduced MACH_HAS_xxx but added Sam and Mathieu
since they were involved in the discussion over HAVE_xxx.)
