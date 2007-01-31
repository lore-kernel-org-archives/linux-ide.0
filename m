From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Wed, 31 Jan 2007 20:00:09 +0900
Message-ID: <45C076B9.3030106@gmail.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com> <20061221171035.GC6171@us.ibm.com> <20070130015507.GA30069@us.ibm.com> <45BEF492.9000000@gmail.com> <20070130233735.GA7483@us.ibm.com> <45BFE8BC.3000906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:54679 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933011AbXAaLAU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 06:00:20 -0500
Received: by ug-out-1314.google.com with SMTP id 44so137730uga
        for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2007 03:00:19 -0800 (PST)
In-Reply-To: <45BFE8BC.3000906@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Gary Hade <garyhade@us.ibm.com>, Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, konradr@us.ibm.com

Jeff Garzik wrote:
> SRST is specified to take no longer than 31 seconds from the clearing to
> the SRST bit to the clearing of the BSY bit.
> 
> Look through the software reset protocol documentation (ATA/ATAPI-7
> volume 2), mainly the device state machines.

Jeff, this is different delay.  We're short circuiting the 31sec wait
when the reported status is 0xff to avoid wasting half a minute on port
which has no device but is showing 0xff because bus datalines are not
pulled down (PATA) or the specific controller is made to emulate 0xff
when link isn't established yet (SATA).

This never matters for PATA devices because no sane device reports 0xff
as the status register value regardless of its state - 0xff is the
special value indicating no device attached and data bus is floating,
and 150ms is more than enough to allow the device to report its status
register value (the spec says >= 2ms).

Some SATA controllers use 0xff to indicate empty port.  This seldomly
matters as we have the almighty SStatus register to check device
presence (there is a bug regarding this, patch pending).

This GoVault drive fails because ata_piix doesn't have SCR while using
0xff to indicate port not ready (dunno exact which state causes 0xff
status tho) while the GoVault drive fails to clear that state in 150ms
(not 30s).  The libata sees 0xff after SRST if GoVault drive is attached
and thinks that the port is empty.  So, I'm afraid there is no easy way
out here but to wait longer for 0xff to clear.  As Kovid suggested just
a few secs should be enough.

Thanks.

-- 
tejun
