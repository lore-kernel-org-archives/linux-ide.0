From: Andi Kleen <ak@suse.de>
Subject: Re: More information on ATI IXP failure in git9
Date: Mon, 26 Jun 2006 11:13:30 +0200
Message-ID: <200606261113.30316.ak@suse.de>
References: <200606252359.27671.ak@suse.de> <200606260818.46672.ak@suse.de> <449F9D78.7070503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:30888 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751305AbWFZJOE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jun 2006 05:14:04 -0400
In-Reply-To: <449F9D78.7070503@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo 6t <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Monday 26 June 2006 10:40, Tejun Heo wrote:
> Hello, Andi.
> 
> Andi Kleen wrote:
> > Still doesn't work with it - see http://one.firstfloor.org/~andi/sata3.jpg
> 
> * SATA_IRQ bit is stuck (on all other sil controllers, this gets cleared 
> when SError is cleared)
> 
> * whenever interrupt occurs (from itself or from any other ones sharing 
> the IRQ), irq handler sees SATA_IRQ bit set and thus thinks it just 
> received phy status changed IRQ.
> 
> * phy status change aborts the active command, so no command gets completed.
> 
> I'm attaching two patches.  The first one tries to clear SATA_IRQ by 
> writing 1 to it in thaw() assuming the bit is implemented as W1C (which 
> BTW is out of spec).  The second one kills SATA_IRQ handling completely. 
>   I wish the first one works but if not I'll update the second one such 
> that it applies only to ATI IXP.

Patch 0 and 1 together work, patch 0 only runs into the usual zero err_mask
problem and doesn't find root.

-Andi

