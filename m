From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.21-rc7] sata_promise: SATAII-150/300 TX4 port numbering
 fix
Date: Sat, 28 Apr 2007 14:49:22 -0400
Message-ID: <46339732.8000205@garzik.org>
References: <200704222228.l3MMSadi026578@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53402 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998AbXD1StY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 14:49:24 -0400
In-Reply-To: <200704222228.l3MMSadi026578@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> There is a known problem with sata_promise on SATAII-150/300 TX4
> controller cards: it enumerates drives in an order that differs
> from the port numbers printed on the controller cards. However,
> Promise's BIOS and Linux driver both get the order right.
> 
> I investigated Promise's Linux driver (v1.01.0.23), and found
> that it explicitly changes the mapping from logical port number
> to ATA engine MMIO address on the SATAII TX4 cards. It does this
> on all SATAII TX4 cards, without inspecting revision etc. The
> SATAII TX2plus cards continue to use the same mapping that was
> used for the first-generation chips.
> 
> This patch updates sata_promise to use the new port number to
> ATA engine mapping on SATAII TX4 cards, which fixes the drive
> enumeration order problem on those cards. Tested on 300 TX4,
> 300 TX2plus, and SATAII-150 TX2plus chips.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> ---
> This patch should apply to 2.6.21-rc7 and libata#upstream.
> It won't apply to libata#ALL because of the massive changes
> for the new init model. I will do a new and cleaner patch for
> #ALL once I can get it as a patch in -mm (I don't do git).

ACK; dropped, awaiting rediff and resend against new init model

FWIW:  The new init model was applied to #upstream, and subsequently 
merged into #ALL (which always is a superset of #upstream).  So from 
your description, it sounds like your #upstream may not have been updated.

FWIW2:  When I note that libata-dev.git has been rebased, this means 
that you will need to delete the #upstream branch on your side, and 
download it again.

	Jeff


