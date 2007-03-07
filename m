From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: 30 second timeout on bootup with Intel ICH7 and AHCI
 (2.6.21-rc2)
Date: Tue, 6 Mar 2007 21:19:14 -0800
Message-ID: <20070306211914.3e983a93@oldman>
References: <20070306150739.21e01b67@freekitty>
	<051701c7606d$7c93ef00$4b00a8c0@donald>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:49218 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932079AbXCGFT0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Mar 2007 00:19:26 -0500
In-Reply-To: <051701c7606d$7c93ef00$4b00a8c0@donald>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rol@as2917.net
Cc: 'Jeff Garzik' <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Wed, 7 Mar 2007 05:02:50 +0100
"Paul Rolland" <rol@as2917.net> wrote:

> Hello Stephen
> 
> > I am seeing a long pause on bootup of this Core2 system if I enable
> > AHCI in the BIOS.  There is only one disc in this system, so when it
> > tries ata2 it is talking to an empty connector. If I turn off AHCI
> > then it seems to be okay.
> 
> Looks like you have some kind of Asus Mobo... Is that correct ?
> It seems that you have the ata2 port that is connected not to a disk,
> but to another disk controller.
> 
> Robert Ancock wrote me :
> "There is something connected, I believe what's actually there on this 
> board on that port is the SiI4723 chip which is connected to two other 
> SATA ports. For whatever reason it gets detected as a drive, and it also 
> seems to be not responding until we do a few resets..
> 
> http://www.siliconimage.com/products/product.aspx?id=64"
> 
> regarding my P5W DH Deluxe motherboard.
> To date, I still don't have any solution for that problem... but it seems
> you have some advance as you wrote : "If I turn off AHCI
> then it seems to be okay."
> 
> I need to test this on my machine too...

Could it be the additional RAID controller (not used). I turned it
off in BIOS as well. Maybe if I turned the other ports on, but then
it would have to probe them.
