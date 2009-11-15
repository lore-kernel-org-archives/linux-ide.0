From: Luke Ross <luke@lukeross.name>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement
	ATAPI_HORKAGE_NOPIO and apply it to GGW-H10N
Date: Sun, 15 Nov 2009 06:13:28 -0500
Message-ID: <20091115111326.GA21415@lukeross.name>
References: <4857313A.1000405@kernel.org> <48573174.9050103@kernel.org> <20080617094354.338e186b@lxorguk.ukuu.org.uk> <48578080.5030605@kernel.org> <20080617095439.GA9359@lukeross.name> <20080617110450.668f37e2@lxorguk.ukuu.org.uk> <4857ADC3.3040106@kernel.org> <20080618114828.GB19903@lukeross.name> <4858F894.6030409@garzik.org> <4AFDF5A8.1050005@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:57448 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbZKOLp3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Nov 2009 06:45:29 -0500
Received: from relay4-v.mail.gandi.net (relay4-v.mail.gandi.net [217.70.178.78])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 7847F38034
	for <linux-ide@vger.kernel.org>; Sun, 15 Nov 2009 12:14:16 +0100 (CET)
In-Reply-To: <4AFDF5A8.1050005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hi,

On Fri, Nov 13, 2009 at 06:11:20PM -0600, Robert Hancock wrote:
>
> Luke/Tejun, do you have some error output from those wodim or growisofs  
> errors? It would be useful to know what commands those were that failed  
> and whether they were also an unusual data size.

The only information I still have is on the bug:

http://bugzilla.kernel.org/show_bug.cgi?id=10091

It felt like it must have been something very edge-case, as only 
nVidia_chipset+LG_drive+Linux seemed to show the issue. Linux on the 
nVidia with a SATA Lite-On drive worked fine; Linux on an Intel ICH with 
AHCI and the LG drive worked fine; Windows XP on the nVidia with the LG 
drive worked fine.

I've since upgraded the motherboard to a newer nVidia chipset (8300) and 
the drive to a newer LG (GGW-H20L) and these both play fine with AHCI - 
so I no longer have the original hardware to test with.

Luke
