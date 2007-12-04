From: Philip Langdale <philipl@overt.org>
Subject: Re: Enabling MSI in sata_nv
Date: Mon, 03 Dec 2007 17:56:52 -0800
Message-ID: <4754B3E4.60208@overt.org>
References: <47537304.2030801@overt.org> <87f94c370712031055h4c359ee9w59fd076fedcc8b9f@mail.gmail.com> <475455FF.2060707@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from usul.saidi.cx ([204.11.33.34]:59167 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750730AbXLDB5B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 20:57:01 -0500
In-Reply-To: <475455FF.2060707@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> 
> MSI is pretty flaky, but we default it to 'on' for AHCI, which is the
> "enhanced mode" side of the sata_nv chip.

If it's new enough. MCP55 has no ahci mode.

> So it is likely that it works on newer boards -- but even though Mark
> Lord's response was mistaken (he thought sata_mv was being discussed),
> he was right too...  sata_nv has stability problems and I would prefer
> not to enable MSI just yet, until we cure the other problems.

Fair enough. Well, just chalk me down as a data point where it seems
to be working.

--phil
