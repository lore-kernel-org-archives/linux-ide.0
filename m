From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Tue, 31 Jul 2007 13:23:47 +0100
Message-ID: <20070731132347.04da4600@the-village.bc.nu>
References: <1185880124.3483.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53741 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756263AbXGaMRG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jul 2007 08:17:06 -0400
In-Reply-To: <1185880124.3483.25.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Ham <rah@bash.sh>
Cc: linux-ide@vger.kernel.org

> I'm wondering if there are or will be libata drivers, or any drivers for
> that matter, for hpt374-based SATA cards?

The HPT374 is a PATA controller. Some people ship products with the
HPT37x controllers and PATA/SATA bridges and those should work with the
libata drivers.

