From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Wed, 20 Dec 2006 13:30:22 +0900
Message-ID: <4588BC5E.6020205@gmail.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:20232 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964871AbWLTEas (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 23:30:48 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2074759uga
        for <linux-ide@vger.kernel.org>; Tue, 19 Dec 2006 20:30:47 -0800 (PST)
In-Reply-To: <4588B3D5.4030406@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Gary Hade <garyhade@us.ibm.com>, Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, Jeff Garzik <jgarzik@pobox.com>

Tejun Heo wrote:
> I would be surprised if Kovid's sda not detected case is caused by this.
>  For GoVault (that's SATAPI right?), yeah, maybe.  For an ATA disk, no
> way (hopefully).
> 
> Can you consult with quantum about it?  If they verify your fix (ie,
> GoVault sometimes take more than 150ms to transmit the first D2H Reg FIs
> after SRST), I'll push similar patch upstream.
> 
> Hmm.. or do we have to wait !BSY here as old IDE did?

More thoughts.

* IIRC, ata_piix reports 0xff if SATA link is broken.  0x80 or something
similar if link established && waiting for the first FIS.  Not sure
whether this always holds but it tends to work that way.  So, 0xff
status means phy link broken, which shouldn't happen after SRST.  Hmmm..

* Recently in ata_bus_softreset() and waiting functions, we've added the
assumption status==0xff indicates empty port.  This is taken from the
IDE layer and proven to work for PATA devices.  I'm not sure we can
safely use this to SATA devices tho.  If PHY is broken or the first FIS
isn't received, arbitrary value (sometimes accidentally) chosen by the
controller is used which may as well be 0xff.  But, then again, many
controllers do mean that there is no devices by 0xff status including
ata_piix w/ its now infamous phantom device problems.

I think we should honor 0xff iff SCR on/offline status is not available.
 How does that sound?

-- 
tejun
