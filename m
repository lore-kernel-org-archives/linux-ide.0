From: Micael Beronius <micael.beronius@telia.com>
Subject: Re: Marvell 6141 - Am I too early?
Date: Sun, 19 Aug 2007 14:57:53 +0200
Message-ID: <200708191457.54372.micael.beronius@telia.com>
References: <loom.20070804T113004-944@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxf1.bahnhof.se ([213.80.101.25]:59792 "EHLO mxf1.bahnhof.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbXHSNZC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Aug 2007 09:25:02 -0400
Received: from localhost (mxf1.local [127.0.0.1])
	by mxf1-reinject (Postfix) with ESMTP id A57405D7C
	for <linux-ide@vger.kernel.org>; Sun, 19 Aug 2007 14:57:57 +0200 (CEST)
Received: from mxf1.bahnhof.se ([127.0.0.1])
	by localhost (mxf1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VL0n-yi6WMpf for <linux-ide@vger.kernel.org>;
	Sun, 19 Aug 2007 14:57:55 +0200 (CEST)
Received: from neon.beronius.com (h-143-183.A213.cust.bahnhof.se [85.24.143.183])
	by mxf1.bahnhof.se (Postfix) with ESMTP id 6A8D85C29
	for <linux-ide@vger.kernel.org>; Sun, 19 Aug 2007 14:57:55 +0200 (CEST)
Received: from helium (helium [10.1.200.191])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by neon.beronius.com (Postfix) with ESMTP id B571B41D3
	for <linux-ide@vger.kernel.org>; Sun, 19 Aug 2007 14:57:55 +0200 (CEST)
In-Reply-To: <loom.20070804T113004-944@post.gmane.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


On Saturday 04 August 2007 12.11.48 I wrote:
> I have an Asus M2N32WS Pro motherboard (amd64), which has the Marvell 6141
> controller on board (1 eSata, 3 internal sata and one PATA).
>
> Well, I have been trying to get this controller to work, as I have a raid
> set of 9 disks to get going. But reading everything I can on the Marvell
> 6141 does not make me more clever exactly.. ;-)


Just to close this thread for people searching in the archives on this topic;

I have now tried different source trees on this, including the libata git 
mv-ahci-pata branch and I can confirm that the sata on the Marvell 6141 or at 
least on this motherboard does not work reliable with any simple PCI ID 
patch, contrary to what some posts earlier this year may have indicated 
elsewhere.

i.e. Yes I was to early ;-) 

Cheers,

  - Micael
