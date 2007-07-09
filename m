From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: CHRP PCI fixup for Pegasos IDE (looking for testers)
Date: Mon, 9 Jul 2007 17:43:25 +0100
Message-ID: <20070709174325.7cb19968@the-village.bc.nu>
References: <46924C27.8020100@genesi-usa.com>
	<20070709160656.2666ef61@the-village.bc.nu>
	<46925CBC.1020100@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44952 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760875AbXGIQg6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 12:36:58 -0400
In-Reply-To: <46925CBC.1020100@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: linux-ide@vger.kernel.org

> I don't understand what you mean by the ifdef being wrong. I don't
> see how else I can make any kind of check for it. If the fix needs

if defined(CONFIG_FOO) || defined(CONFIG_FOO_MODULE)

> The viaide->irq check is just me being careful. I know for a fact the
> only way the Pegasos is set up on every firmware revision is that
> the PCI interrupt line for the IDE controller is set to 14. If it's

Cool. Thats fine then.
