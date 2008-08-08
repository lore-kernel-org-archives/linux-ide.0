From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: issues with sata hotplug?
Date: Fri, 8 Aug 2008 18:54:19 +0100
Message-ID: <20080808185419.69d762bc@lxorguk.ukuu.org.uk>
References: <5D4D272F-5546-4C02-852A-80849A42EC1F@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38019 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754136AbYHHSL2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Aug 2008 14:11:28 -0400
In-Reply-To: <5D4D272F-5546-4C02-852A-80849A42EC1F@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-ide <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

> When I "eject" the drive I see no dmesg output related to hotplug.  I  
> also don't see anything when I plug a drive in.

sata_nv does support hot plug and hot plug events.

> Is there something I'm doing wrong w/regards to SATA hotplug support?

Not that I can see - you can warm plug drives by telling the kernel
yourself about plug/unplug events.

