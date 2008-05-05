From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Marvell 88SE6121 PATA in 2.6.25 (ahci)
Date: Mon, 05 May 2008 10:52:59 -0400
Message-ID: <481F1F4B.508@garzik.org>
References: <20080505045537.GA24381@gozer.dminteractive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36785 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755938AbYEEOxB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 May 2008 10:53:01 -0400
In-Reply-To: <20080505045537.GA24381@gozer.dminteractive.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Hokenson <kernel+marvell@gozer.org>
Cc: linux-ide@vger.kernel.org

Mike Hokenson wrote:
> So, I guess the AHCI driver has taken over for the PATA controller,
> but something must not be right... The controller doesn't see link
> and the drive doesn't show up anywhere, but the BIOS sees it fine.
> 
> Any ideas? Should I disable PATA_MARVELL?


AHCI takes over the entire controller, but does not yet support PATA 
devices.

	Jeff


