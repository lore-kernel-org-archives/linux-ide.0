From: Tejun Heo <tj@kernel.org>
Subject: Re: More ata_piix spurious IRQs
Date: Sat, 12 Jun 2010 19:33:09 +0200
Message-ID: <4C13C4D5.5080300@kernel.org>
References: <20100611222746.37b5efa6@server.gazypan.dyndns.org> <1276298006.14011.149.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33512 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888Ab0FLReS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Jun 2010 13:34:18 -0400
In-Reply-To: <1276298006.14011.149.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: jeanseb <jeanseb.valette@free.fr>, 585556@bugs.debian.org, linux-ide@vger.kernel.org

Hello, Ben.

On 06/12/2010 01:13 AM, Ben Hutchings wrote:
> (more details at <http://bugs.debian.org/585556>).
> 
> This is in Debian kernel version 2.6.32-15 which is based on stable
> version 2.6.32.14 but has your backported spurious IRQ handling patch
> taken from SLE11 (References: bnc#445872, bnc#589449).  Any idea what's
> going wrong here?  Is there a piece missing from that fix?

One great thing about traditional IDE is that the IRQ line is not
really under the control of the controller so the device can assert
the IRQ whether the controller want or not and there's nothing much
the driver can do to prevent runaway IRQs if the device is crazy
enough (some devices seem to have problem with toggling nIEN for
example).  Ain't it just great?  :-)

As the spurious interrupt handling kicked in, the spurious interrupts
itself shouldn't cause problem.  It would be polling now, so it's
likely that the device is asserting interrupt and not responding to
commands properly.  Does the drive work in other environments?
e.g. Can the BIOS recognize it and boot from it?

Thanks.

-- 
tejun
