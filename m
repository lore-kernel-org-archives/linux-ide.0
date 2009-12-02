From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple PowerMac/PowerBook IDE controller
Date: Wed, 02 Dec 2009 12:44:00 +0100
Message-ID: <m24oo9zjlr.fsf@igel.home>
References: <20091202003630.29919100851@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:51872 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbZLBLn6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Dec 2009 06:43:58 -0500
In-Reply-To: <20091202003630.29919100851@ozlabs.org> (Benjamin Herrenschmidt's
	message of "Wed, 02 Dec 2009 11:36:29 +1100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org, tj@kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> v2. Better tested now, seems to be reasonably solid.
>
> Addressed Tejun comments and made remove more robust vs. media-bay,
> should also fix Andreas problem.

Thanks, this works fine now, including suspend *and* resume. :-)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
