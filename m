From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: HPT34x progress - and a DMA question
Date: Fri, 19 Dec 2008 13:04:11 +0100
Message-ID: <18763.36283.332499.893530@harpo.it.uu.se>
References: <20081218225152.2ad356d1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:56432 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbYLSMEV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Dec 2008 07:04:21 -0500
In-Reply-To: <20081218225152.2ad356d1@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox writes:
 > The 343/363 crashes if you write ->ctl with a live DMA outstanding. Now
 > its easy enough to fix in the driver - just wrap ata_sff_freeze. It
 > raises an interesting question however - which is should ata_sff_freeze
 > stop any running DMA in the general case ?

FWIW when I added ->freeze and ->thaw to sata_promise I made ->freeze
stop in-flight DMAs. As I read the documentation the ATA engine should
be completely idle after ->freeze so this seemed appropriate.

There was a brief discussion about this at the time, but I don't think
we ever agreed on a definitive "precise semantics" for ->freeze.
