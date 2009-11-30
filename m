From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata hotplug question
Date: Tue, 01 Dec 2009 10:44:11 +1100
Message-ID: <1259624651.2076.158.camel@pasglop>
References: <1259561052.2076.73.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39917 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840AbZK3XoH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Nov 2009 18:44:07 -0500
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nAUNiCSZ027331
	for <linux-ide@vger.kernel.org>; Mon, 30 Nov 2009 17:44:13 -0600
In-Reply-To: <1259561052.2076.73.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Mon, 2009-11-30 at 17:04 +1100, Benjamin Herrenschmidt wrote:
> So pata_macio is starting to look good, it even suspends and resumes on
> a couple of test laptops, now is time to sort out the last piece of the
> puzzle, which is the hotplug media-bay.
> 
> The old code use to call directly into drivers/ide ide_port_scan()
> etc... from within the mediabay driver. Pretty filthy.
> 
> I'm changing that to something that's even simpler: the macio_driver
> gets a new callback for plug/unplug events from the bay, so it will be
> easy to keep the old driver do whatever drivers/ide cruft it wants
> locally and do something different in libata.
> 
> Now, for libata, I haven't totally figured out what to do though.
> 
> It seems like when the state "changes", I can do something like ahci and
> call ata_ehi_hotplugged() followed by something like ata_port_freeze()
> to kick the EH... at least that's my rough understanding.

One idea that comes to mind (I will try hacking something later today)
is to make ata_link_online() and ata_link_offline() use optional hooks
in the port ops so my driver can replace them instead of using the SATA
PHY stuff. Would that fly ?

Cheers,
Ben.


