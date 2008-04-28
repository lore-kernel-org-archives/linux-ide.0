From: Mark Lord <liml@rtr.ca>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Mon, 28 Apr 2008 19:42:21 -0400
Message-ID: <481660DD.80103@rtr.ca>
References: <48163C5D.9050605@rtr.ca> <48164AE8.4070106@rtr.ca> <481659B5.7090703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2917 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934176AbYD1XmX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Apr 2008 19:42:23 -0400
In-Reply-To: <481659B5.7090703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Tejun Heo wrote:
> Hello, Mark.
> 
> Mark Lord wrote:
>>> Are there controllers which *can* handle such a mix (ahci, sil24 ?)
> 
> Yeap, sil24 can.  ahci can currently only do device based switching but 
> ahci 2.0 can do it too.
> 
>>> So it looks like a I need a .qc_defer() function which examines all 
>>> links
>>> from the common host port for activity, and then asks for command 
>>> deferral
>>> when the new command has a different protocol than those that are 
>>> outstanding.
>>>
>>> Weird that none of the other LLDs need this.  Or do they?
> 
> So, none of the others needs this.
..

Mmm.. I just plugged the same PM + drives into my sata_sil24 card here,
and that driver went bonkers when I did the same test.

Had to reboot eventually to recover.

Weird.
