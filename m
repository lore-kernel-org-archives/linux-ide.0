From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: hwif->rw_disk() method
Date: Fri, 12 Jan 2007 10:27:00 +0000
Message-ID: <20070112102700.3492bbb5@localhost.localdomain>
References: <45A514AB.2080605@ru.mvista.com>
	<20070110171015.5320fa17@localhost.localdomain>
	<45A63DEF.3010604@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53141 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161054AbXALKPq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 05:15:46 -0500
In-Reply-To: <45A63DEF.3010604@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

>     BTW, I've looked at the clock turnaround code both in drivers/ide/hpt366.c 
> and drivers/ata/pata_hpt3x2n.c and compared it to the HighPoint driver and I'm 
> dazed and confused (again?):  contrary to what HighPoint does (I'm not sure 

Thats how I usually feel after looking at highpoints driver code.


>     ATA_TFLAG_WRITE indicates a write transfer (host-to-device) while 
> hpt3x2n_use_dpll() contrarywise expects the read transfer indication. Comments?

That looks like a bug. The code seems to get the DPLL choice right but
then the caller as you say is incorrect.

Will fix
