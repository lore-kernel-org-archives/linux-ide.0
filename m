From: Hein-Pieter van Braam <hp@syntomax.com>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 23:48:44 +0100
Message-ID: <1196722124.6362.17.camel@liza>
References: <4751A2DA.6030403@rtr.ca>
	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>
	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>
	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>
	 <47544B3C.2010901@rtr.ca> <1196712661.6362.5.camel@liza>
	 <475465F7.7050705@rtr.ca> <1196714235.6362.9.camel@liza>
	 <47546CF6.30301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a80-126-0-120.adsl.xs4all.nl ([80.126.0.120]:44043 "EHLO
	ifolder.erca.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbXLCWuS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 17:50:18 -0500
In-Reply-To: <47546CF6.30301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

> Man, what a quirky BIOS!

Hum... I can pvcreate on the md device just fine, but after that, pvscan
won't find it... 

I have a suspicion that there's a BIOS doing some sector hiding or
replacement of sorts... 

*facepalm*


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

