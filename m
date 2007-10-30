From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.24-rc1 1/2] sata_promise: ASIC PRD table bug workaround,
 take 2
Date: Tue, 30 Oct 2007 09:28:12 -0400
Message-ID: <4727316C.8060004@garzik.org>
References: <200710301320.l9UDKndW028161@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34323 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbXJ3N2O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 09:28:14 -0400
In-Reply-To: <200710301320.l9UDKndW028161@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, Alexander Sabourenkov <screwdriver@lxnt.info>

Mikael Pettersson wrote:
> Second-generation Promise SATA controllers have an ASIC bug
> which can trigger if the last PRD entry is larger than 164 bytes,
> resulting in intermittent errors and possible data corruption.
> 
> Work around this by replacing calls to ata_qc_prep() with a
> private version that fills the PRD, checks the size of the
> last entry, and if necessary splits it to avoid the bug.
> Also reduce sg_tablesize by 1 to accommodate the new entry.
> 
> Tested on the second-generation SATA300 TX4 and SATA300 TX2plus,
> and the first-generation PDC20378.
> 
> Thanks to Alexander Sabourenkov for verifying the bug by
> studying the vendor driver, and for writing the initial patch
> upon which this one is based.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> --
> Changes since previous version:
> * use new PDC_MAX_PRD constant to initialise sg_tablesize
> 
>  drivers/ata/sata_promise.c |   87 ++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 83 insertions(+), 4 deletions(-)

applies 1-2 to #upstream-fixes


