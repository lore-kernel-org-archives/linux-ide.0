From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: SATA_SIL: Add a work-around for IXP4xx CPU.
Date: Wed, 16 Dec 2009 00:03:52 +0100
Message-ID: <m3hbrrc013.fsf@intrepid.localdomain>
References: <m3fx8m0vwh.fsf@intrepid.localdomain>
	<4B274694.6020701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:50980 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762621AbZLOXD4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Dec 2009 18:03:56 -0500
In-Reply-To: <4B274694.6020701@kernel.org> (Tejun Heo's message of "Tue, 15
	Dec 2009 17:19:32 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Tejun Heo <tj@kernel.org> writes:

> Hmmm... Given that there are some platforms which have problem with
> mmio and sil3112/4 can do everything via io accesses, it would be nice
> to generalize this so that there's CONFIG_SATA_SIL_NO_MMIO which is
> selected by affected platforms.  Are you interested in doing it?

Unfortunately I no longer have access to that SIL3512 miniPCI card so
I wouln't be able to test on IXP425. Perhaps it's not a problem, testing
on i386 (probably with disabled MMIO BAR) should be enough.

OTOH IIRC SIL3x12 needs to use the MMIO write to start BM DMA, otherwise
the AT-style 64 KB limits apply. I think IXP4xx would benefit from only
ioread8() going through normal IO.

Do you know what platforms have the MMIO problems? What kind of problems
are there, inability to use MMIO at all? (IXP4xx can't do 8/16-bit MMIO
reads).
-- 
Krzysztof Halasa
