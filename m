From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add quirk to set AHCI mode on ICH boards
Date: Fri, 09 Nov 2007 22:57:28 -0500
Message-ID: <47352C28.4070604@garzik.org>
References: <20071109020235.GA2031@ceren> <20071109023129.GA25581@havoc.gtf.org> <4733D421.7000505@rtr.ca> <20071109034622.GB25581@havoc.gtf.org> <20071109120425.543971bf@the-village.bc.nu> <47351FE1.4000001@garzik.org> <20071110035424.GB28975@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60834 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764070AbXKJD5g (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Nov 2007 22:57:36 -0500
In-Reply-To: <20071110035424.GB28975@thunk.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, Riki Oktarianto <rkoktarianto@gmail.com>, linux-kernel@vger.

Theodore Tso wrote:
> On Fri, Nov 09, 2007 at 10:05:05PM -0500, Jeff Garzik wrote:
>> By forcing AHCI, your PATA devices will be inaccessible, in a common 
>> configuration.  It also means shuffling users from one driver to another, 
>> which induces breakage.
>>
>> I was speaking wishfully.  Real life intrudes, alas.
> 
> Not even as boot-time option?  I'm curious whether it might allow me
> to use AHCI mode on a T60p laptop; right now I can't because in AHCI
> mode the Ultrabay hard drive device becomes invisible to Linux
> (although not to Windows, interestingly).  I'm currently travelling
> and I don't carry the T60 around anymore, so I can't do the experiment
> right this moment, but given that this would allow the T60 to take
> advantage of ALPM if this works, it would be awfully tempting....

Oh sure, a boot-time option would be fine.

I want to spread AHCI far and wide; it is vastly superior to ata_piix in 
many ways.

I was mainly talking about unconditionally changing behavior from the 
current default, which presents several problems.

	Jeff



