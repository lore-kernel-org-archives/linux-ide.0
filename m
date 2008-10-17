From: Alan Hourihane <alanh@fairlite.co.uk>
Subject: Re: VIA SATA/PATA problem
Date: Fri, 17 Oct 2008 19:11:40 +0100
Message-ID: <1224267100.13924.450.camel@jetpack.demon.co.uk>
References: <1223559916.13924.13.camel@jetpack.demon.co.uk>
	 <48F3FFD3.6090009@kernel.org>
	 <1223990866.13924.182.camel@jetpack.demon.co.uk>
	 <48F55676.1070806@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fairlite.demon.co.uk ([80.176.228.186]:46834 "EHLO
	fairlite.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbYJQSL5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Oct 2008 14:11:57 -0400
In-Reply-To: <48F55676.1070806@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Wed, 2008-10-15 at 11:33 +0900, Tejun Heo wrote:
> Alan Hourihane wrote:
> > 00:0a.3 RAID bus controller [0104]: VIA Technologies, Inc. VT6421 IDE
> > RAID Controller [1106:3249] (rev 50)              
> > 
> > I still need to do Mikael's suggestion of plugging it into an x86 box
> > and checking it's PCI config space.
> 
> I was hoping it was 5287 which sata_via currently doesn't fully support.
>  I think you'll need to try the PCI config space trick.
> 
> Thanks.
> 
I dumped the PCI config space via "lspci -xxx" and this is the diff
compared to an x86 box.

--- mips.pciraid   2008-10-17 02:33:35.000000000
+0100                                     
+++ x86.pciraid 2008-10-17 02:34:00.000000000
+0100                             
@@ -1,8 +1,8
@@                                                                 
-00:0a.3 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID
Controller 
(rev
50)                                                                        
-00: 06 11 49 32 07 00 90 82 50 00 04 01 00 20 00
00                            
-10: 91 18 00 10 a1 18 00 10 b1 18 00 10 c1 18 00
10                            
-20: 61 18 00 10 01 10 00 10 00 00 00 00 06 11 49
32                            
-30: 00 00 ff ff e0 00 00 00 00 00 00 00 09 01 00
00                            
+01:0b.3 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID
Controller 
(rev
50)                                                                        
+00: 06 11 49 32 07 00 90 02 50 00 04 01 00 40 00
00                            
+10: a1 df 00 00 91 df 00 00 81 df 00 00 61 df 00
00                            
+20: 41 df 00 00 01 d8 00 00 00 00 00 00 06 11 49
32                            
+30: 00 00 8f ff e0 00 00 00 00 00 00 00 09 01 00
00                            
 40: 33 03 f1 44 0e af 00 00 00 01 00 03 00 00 00
00                            
 50: 00 00 00 00 00 00 00 00 00 10 10 00 05 00 10
00                            
 60: 00 00 ff ff 00 00 00 00 00 00 00 00 00 00 ff
ff                            
@@ -10,7 +10,7
@@                                                               
 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00                            
 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00                            
 a0: 0b f2 c9 35 10 ac c0 00 a8 a8 a8 a8 ff 00 b6
b6                            
-b0: 0f 0f 0f 0f 34 00 00 00 00 00 20 00 00 00 00
00                            
+b0: 0f 0f 1f 1f 34 00 00 00 00 00 20 00 00 00 00
00                            
 c0: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00
00                            
 d0: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00
00                            
 e0: 01 00 02 00 00 00 00 00 50 01 49 32 06 11 49 32

I think the b0 line differences are to do with me not having an 80core
cable plugged in on the x86 box, and I did on the mips.

The other earlier stuff looks reasonable as it's probably just the
mem&io ranges.

If others can take a peek and spot anything obvious I'd be glad to try
it here.

If there's nothing obvious, then I guess it's deeper MMIO register
poking ??

Alan.

