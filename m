From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: add Marvell support (WIP)
Date: Mon, 21 May 2007 23:23:02 -0400
Message-ID: <46526216.2040000@garzik.org>
References: <20070519054704.GA352@havoc.gtf.org> <22E26940476D1E48AA6F292B5316C9C33823@bes1.peakin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48086 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755116AbXEVDXH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 May 2007 23:23:07 -0400
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C33823@bes1.peakin.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "George T. Joseph (development)" <gtj.devel@peakin.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

George T. Joseph (development) wrote:
> Hi Jeff,
> 
> Two issues with the patch...
> 
> msi has to be disabled for the Marvell or the driver load will throw a
> "nobody cared" message and eventually hang before discovering all the
> drives.
> 
> Light I/O works fine but heavy I/O generates 
> "exception Emask 0x0 Sact 0xb Serr 0x0 action 0x2 frozen"
> Then softreset and identify failures.
> Adding AHCI_FLAG_NO_NCQ to the flags fixes this.
> 
> I've been running with both these changes over your original patch for a
> few months now with no problems.  This is on a very heavily used 4 drive
> mdraid10 array.  


I poked Marvell about this, we'll see what they say.

If I don't hear anything useful, I'll push the no-MSI, no-NCQ version 
upstream.

	Jeff


