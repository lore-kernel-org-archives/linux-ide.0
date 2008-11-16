From: Alexander Clausen <alex@gc-web.de>
Subject: Re: Suspend w/ sata_promise
Date: Sun, 16 Nov 2008 18:24:26 +0100
Message-ID: <4920574A.9070501@gc-web.de>
References: <49202CB0.60507@gc-web.de>	<18720.18615.938839.921189@harpo.it.uu.se>	<49204DB2.2040400@gc-web.de> <18720.22011.404066.905870@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server2.gc-web.de ([88.198.38.110]:41227 "EHLO mail.gc-web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbYKPRYg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 12:24:36 -0500
In-Reply-To: <18720.22011.404066.905870@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> Enter the "Integrated Peripherals" BIOS setup page and make sure the
> VT8237 SATA controller is enabled. Also check if there's an option
> anywhere for choosing between raid and non-raid modes, and choose
> non-raid.

It was enabled and set to SATA (not RAID). I suspect there might be buggy hardware involved? I'll
try with a PCI controller next.

Alex
