From: Christoph Burger-Scheidlin <andersin@freenet.de>
Subject: Re: ide dma bug?
Date: Mon, 5 Sep 2005 12:39:14 +0100
Message-ID: <200509051239.14713.andersin@freenet.de>
References: <20050904201844.GA12464@pog.tecnopolis.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hermes.iu-bremen.de ([212.201.44.23]:64395 "EHLO
	hermes.iu-bremen.de") by vger.kernel.org with ESMTP
	id S1750771AbVIELji (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Sep 2005 07:39:38 -0400
Received: from localhost (demetrius.iu-bremen.de [212.201.44.32])
	by hermes.iu-bremen.de (Postfix) with ESMTP id 27F52393B2
	for <linux-ide@vger.kernel.org>; Mon,  5 Sep 2005 13:39:26 +0200 (CEST)
Received: from hermes.iu-bremen.de ([212.201.44.23])
 by localhost (demetrius [212.201.44.32]) (amavisd-new, port 10024) with ESMTP
 id 06023-01 for <linux-ide@vger.kernel.org>;
 Mon,  5 Sep 2005 13:39:25 +0200 (CEST)
Received: from helena.world.iu-bremen.de (mailhost.world.iu-bremen.de [212.201.44.34])
	by hermes.iu-bremen.de (Postfix) with ESMTP id F12D639182
	for <linux-ide@vger.kernel.org>; Mon,  5 Sep 2005 13:39:24 +0200 (CEST)
Received: from phoenix.burgerhome.de (p54861D46.dip0.t-ipconnect.de [84.134.29.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by helena.world.iu-bremen.de (Postfix) with ESMTP id AEEAA1EE0F
	for <linux-ide@vger.kernel.org>; Mon,  5 Sep 2005 13:39:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by phoenix.burgerhome.de (Postfix) with ESMTP id D4D257ECB60
	for <linux-ide@vger.kernel.org>; Mon,  5 Sep 2005 13:33:05 +0200 (CEST)
Received: from phoenix.burgerhome.de ([127.0.0.1])
 by localhost (phoenix [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 17806-10 for <linux-ide@vger.kernel.org>;
 Mon,  5 Sep 2005 13:33:02 +0200 (CEST)
Received: from localhost (router.burgerhome.de [192.168.0.1])
	by phoenix.burgerhome.de (Postfix) with ESMTP id 988307ECB3C
	for <linux-ide@vger.kernel.org>; Mon,  5 Sep 2005 13:33:02 +0200 (CEST)
In-Reply-To: <20050904201844.GA12464@pog.tecnopolis.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sunday 04 September 2005 21:18, Trevor Cordes wrote:
> I'm getting a couple of times every couple of days:
>
> Sep  1 07:09:53 piles kernel: hdq: dma_intr: bad DMA status (dma_stat=75)
> Sep  1 07:09:53 piles kernel: hdq: dma_intr: status=0x50 { DriveReady
> SeekComplete } Sep  1 07:09:53 piles kernel: ide: failed opcode was:
> unknown
>
> They're running off of the onboard Intel 845D IDE, onboard Promise PDC20276 
> [...] 2 CMD680-based cards. [...] The 8 250's are all IDE masters.  The 4 
> 160's share 2 IDE channels (master+slave). 

I had a similar problem with a SiI680 (and since lspci states that Silicon 
Image was formerly CMD Tech. I thought it might be related). In my case, I 
got lost interrupts and dma errors when I used both channels of the SiI680 
simultaneously. I serialized both channels (kernel parameters ide2=serialize 
ide3=serialize) and the problems went away (I am not sure though how much of 
a performance impact it has).

If you want more detailed info on my scenario to compare it to yours, please 
check bug 5145: http://bugzilla.kernel.org/show_bug.cgi?id=5145 .

Christoph Burger-Scheidlin
