From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Wed, 20 Dec 2006 12:53:57 +0900
Message-ID: <4588B3D5.4030406@gmail.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <20061220032941.GA8903@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:34188 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964849AbWLTDyL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 22:54:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2065769uga
        for <linux-ide@vger.kernel.org>; Tue, 19 Dec 2006 19:54:10 -0800 (PST)
In-Reply-To: <20061220032941.GA8903@us.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, Jeff Garzik <jgarzik@pobox.com>

Howdy,

Gary Hade wrote:
> I noticed that Tejun recently provided a "libata: handle 0xff status 
> properly" patch that is now in mainline that improves this code
>   re: http://marc.theaimsgroup.com/?l=linux-ide&m=116038642105802&w=2
> but I found that the check still failed but more silently and with no 
> retries.
> 
> I decided to try increasing the delay that preceeds the above 
> check [ msleep(150); ] and found that a change from 150ms to 
> 1000ms caused the problem to disappear. 

Aieeee, 150ms not enough for the device to send the first FIS after SRST?

> I then replaced the msleep(150); with:
>     {
>         int i, ms = 5;
>         msleep(ms);
>         ata_port_printk(ap, KERN_INFO, "status @ %d ms: 0x%x\n",
>                                         ms, ata_check_status(ap));
>         for (i = 1; i <= 20; i++) {
>             ms += 50;
>             msleep(50);
>             ata_port_printk(ap, KERN_INFO, "status @ %d ms: 0x%x\n",
>                                             ms, ata_check_status(ap));
>         }
>     }
> 
> Output for two cable placement configurations (0xFF check failure 
> and 0xFF check success) are included below.  Note that there are 
> cable placement configurations for both the hard drive and 
> GoVault where the initial status is 0xff. i.e. both transition 
> from 0xff to 0x7f when BSY bit is cleared but it is taking MUCH 
> longer for the GoVault (600-700ms for GoVault and <5ms for 
> hard drive).  It does not appear that the 0xff starting status
> is device specific.
> 
> So, it appears that we have a situation with this SATA controller 
> where a 0xFF status is not an accurate indication that there is
> no device.  
> 
> Although the 150ms to 1000ms delay increase works for the GoVault 
> device I am not sure if it is the best long term fix for the problem.

I would be surprised if Kovid's sda not detected case is caused by this.
 For GoVault (that's SATAPI right?), yeah, maybe.  For an ATA disk, no
way (hopefully).

Can you consult with quantum about it?  If they verify your fix (ie,
GoVault sometimes take more than 150ms to transmit the first D2H Reg FIs
after SRST), I'll push similar patch upstream.

Hmm.. or do we have to wait !BSY here as old IDE did?

-- 
tejun
