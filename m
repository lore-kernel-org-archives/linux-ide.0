From: Tejun Heo <tj@kernel.org>
Subject: Re: Adding port multiplier support to a LLDD
Date: Mon, 23 Jun 2008 09:22:24 +0900
Message-ID: <485EECC0.40902@kernel.org>
References: <5d74c5720806211335i12cd4764j2109703ab224b1cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37495 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbYFWAWe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jun 2008 20:22:34 -0400
In-Reply-To: <5d74c5720806211335i12cd4764j2109703ab224b1cb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Miesfeld <miesfeld@gmail.com>
Cc: linux-ide@vger.kernel.org

Mark Miesfeld wrote:
> Hi,
> 
> I wonder if someone could give me a broad outline of what is needed to
> add port multiplier support to a low-level SATA device driver through
> libata in a 2.6.26 kernel.
> 
> I'm working on a driver for a new SOC (460EX) that AMCC has.  The chip
> has support for SATA and support for port multipliers through
> command-based switching.
> 
> For our in-house validation boards I have the driver working on a
> 2.6.19 kernel and implemented the port multiplier support within the
> driver itself since libata didn't yet have port multiplier support.
> 
> Our customer evaluation boards (Canyonlands) are using a 2.6.26
> kernel.  Stefan Roese at DENX has ported the 2.6.19 driver to 2.6.26
> but without port multiplier support.  In 2.6.26 the libata port
> multiplier support looks pretty good, I was hoping I can add the
> support to the 2.6.26 driver fairly easily by going through libata.
> 
> What basic steps should I take?

The following thread should help.

http://thread.gmane.org/gmane.linux.ide/24799

-- 
tejun
