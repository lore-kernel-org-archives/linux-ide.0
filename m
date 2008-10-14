From: Alan Hourihane <alanh@fairlite.co.uk>
Subject: Re: VIA SATA/PATA problem
Date: Tue, 14 Oct 2008 14:27:46 +0100
Message-ID: <1223990866.13924.182.camel@jetpack.demon.co.uk>
References: <1223559916.13924.13.camel@jetpack.demon.co.uk>
	 <48F3FFD3.6090009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fairlite.demon.co.uk ([80.176.228.186]:34982 "EHLO
	fairlite.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbYJNN1t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 09:27:49 -0400
In-Reply-To: <48F3FFD3.6090009@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Tue, 2008-10-14 at 11:11 +0900, Tejun Heo wrote:
> Alan Hourihane wrote:
> > Hi,
> > 
> > I've got a VIA SATA/PATA PCI RAID card installed in a MIPS box, which
> > obviously doesn't run the BIOS on the card.
> > 
> > When booting these messages appear....
> 
> Care to post lspci -nn?

Sure...

00:0a.0 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller [1106:3038] (rev
62)                                                    
00:0a.1 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller [1106:3038] (rev
62)                                                    
00:0a.2 USB Controller [0c03]: VIA Technologies, Inc. USB 2.0
[1106:3104] (rev
65)                                                                              
00:0a.3 RAID bus controller [0104]: VIA Technologies, Inc. VT6421 IDE
RAID Controller [1106:3249] (rev 50)              

I still need to do Mikael's suggestion of plugging it into an x86 box
and checking it's PCI config space.

Alan.

