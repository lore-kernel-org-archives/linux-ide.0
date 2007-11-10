From: Matthias Schniedermeyer <ms@citd.de>
Subject: Re: [PATCH] Add quirk to set AHCI mode on ICH boards
Date: Sat, 10 Nov 2007 12:20:29 +0100
Message-ID: <20071110112029.GA25827@citd.de>
References: <20071109020235.GA2031@ceren> <20071109023129.GA25581@havoc.gtf.org> <4733D421.7000505@rtr.ca> <20071109034622.GB25581@havoc.gtf.org> <20071109120425.543971bf@the-village.bc.nu> <20071109233215.GA22498@citd.de> <47352095.4010502@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from enyo.dsw2k3.info ([195.71.86.239]:45707 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444AbXKJLUp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Nov 2007 06:20:45 -0500
Content-Disposition: inline
In-Reply-To: <47352095.4010502@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, Riki Oktarianto <rkoktarianto@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-ide@vger.kernel.org

On 09.11.2007 22:08, Jeff Garzik wrote:
> Matthias Schniedermeyer wrote:
>> And on the topic of "broken" BIOSes. I have a little empathy for the MB 
>> manufactures as non-RAID AHCI royaly screws Windos, so not supporting it 
>> reduces their support costs enough to overlook screwing the non-windos 
>> faction.
>
> non-RAID AHCI works just fine on Windows.

Last i know is that Intel doesn't provide an AHCI driver for the 
non-RAID version. (For whatever political reason). That is even 
documented in the german "c't", they even had an articel about "patching 
in the Device-IDs" so the RAID-AHCI driver accepts the non-RAID AHCI 
chipsets.

And i can second that, when i configure my @home MB (ASUS P5B = non-RAID) 
to AHCI neither XP nor Vista work.

@work i tried to install Vista on an AHCI-configured machine and aborted 
that "expriment" after about 2 hours. In IDE-mode it took Vista about 3 
Minutes to reach the point where i aborted the AHCI experiment.


So i must say: My milage varies.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

