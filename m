From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple PowerMac/PowerBook IDE controller
Date: Tue, 01 Dec 2009 21:43:47 +0100
Message-ID: <m2hbsazapo.fsf@igel.home>
References: <20091201070834.6A840B7B63@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:53260 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbZLAUnp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Dec 2009 15:43:45 -0500
In-Reply-To: <20091201070834.6A840B7B63@ozlabs.org> (Benjamin Herrenschmidt's
	message of "Tue, 01 Dec 2009 18:08:33 +1100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org, tj@kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> This is a libata driver for the "macio" IDE controller used on most Apple
> PowerMac and PowerBooks. It's a libata equivalent of drivers/ide/ppc/pmac.c

Tried it on my iBook G4 and I got an oops during probing, in
pata_macio_common_init+0x378/0x614.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
