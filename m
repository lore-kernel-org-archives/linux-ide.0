From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_cs5536: ATA driver for Geode companion chip
Date: Wed, 3 Oct 2007 21:59:37 +0100
Message-ID: <20071003215937.123c95ee@the-village.bc.nu>
References: <yq14ph8xg3z.fsf@sermon.lab.mkp.net>
	<20071003203118.GA2916@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54916 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751532AbXJCUyu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 16:54:50 -0400
In-Reply-To: <20071003203118.GA2916@cosmic.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: "Martin K. Petersen" <mkp@mkp.net>, linux-ide@vger.kernel.org, info-linux@geode.amd.com

> I have to discourage this patch just on principle, because I don't like
> the idea of working around the VSA.  That said, it seems that Alan is 
> willing to take on the extra code, and there isn't anything technically
> deficient here, so I'm fine with this going in.

I'd prefer to go via the PCI virtualisation(but with the timings fixed)
but there are boxes out there where this doesn't work.

Ideally what I'd like would be a suggestion of how to tell if the VSA is
active on this so that we can use VSA if present.
