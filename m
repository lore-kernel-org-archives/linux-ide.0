From: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>
Subject: Re: Remove obsoleted "idex=noprobe" kernel parameter
Date: Wed, 12 Mar 2008 04:47:59 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0803120418580.12249@Soyuz-KT.TeNet.Odessa.UA>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Te.NeT.UA ([195.138.80.34]:56966 "EHLO te.net.ua"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbYCLCsJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Mar 2008 22:48:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com


 	Hi,

  Why this option is obsoleted ? It can be used on many systems when Linux 
still tries to detect disabled in the BIOS IDE controller - you may 
significantly reduce boot time, without bunch of the "ide reset succeed" 
messages.
  So embedded people use IDE as hardware interface to different 
controlling systems - how they can tell Linux, now without "idex=noprobe" 
option, not to probe _this_ IDE controller ?
  So can be said about "obsoleted "idex=base[,ctl[,irq]]" kernel 
parameters" - now nobody, who make simple custom hardware, can tell legacy 
IDE driver about different hardware resources, which is normal for other 
Linux subsystems - see for example LPT or most network cards kernel boot 
parameters.
  Its pitifully, especial for embedded people, that Linux becoming less 
configurable system ;(


 		Rus
