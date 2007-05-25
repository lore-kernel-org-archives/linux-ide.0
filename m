From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: sil680 MMIO changes moved to branch
Date: Fri, 25 May 2007 14:29:38 +1000
Message-ID: <1180067378.32247.1105.camel@localhost.localdomain>
References: <4656591A.6090701@garzik.org>
	 <1180066312.32247.1098.camel@localhost.localdomain>
	 <4656655D.7070109@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54311 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887AbXEYE3p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 May 2007 00:29:45 -0400
In-Reply-To: <4656655D.7070109@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan <alan@lxorguk.ukuu.org.uk>

On Fri, 2007-05-25 at 00:26 -0400, Jeff Garzik wrote:
> Just replace the ata_std_softreset() call with code that does MMIO 
> flushes on a safe register?

Yeah well... if just reading altstatus is enough, I don't see the point
of doing anything MMIO-dependant or whatever. I can just add reading of
it after all 3 SRST bit toggles unconditionally.

Ben.


