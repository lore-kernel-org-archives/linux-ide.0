From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [RFC] IDE/ATA/SATA controller hotplug
Date: Thu, 12 Aug 2004 14:36:03 +0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <pan.2004.08.12.11.36.02.955485@yahoo.com>
References: <200407272018.i6RKIiYB028210@falcon10.austin.ibm.com> <411A7472.9010606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:60649 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268515AbUHLLgH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Aug 2004 07:36:07 -0400
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1BvDsM-0000fk-00
	for <linux-ide@vger.kernel.org>; Thu, 12 Aug 2004 13:36:06 +0200
Received: from home-33027.b.astral.ro ([81.89.4.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 12 Aug 2004 13:36:06 +0200
Received: from i_p_a_u_l by home-33027.b.astral.ro with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 12 Aug 2004 13:36:06 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004 15:33:06 -0400, Jeff Garzik wrote:

>> I would have to differ with you here.  From conversations and fairly
>> (2 or 3 months ago) experience, the IDE core is not capable of being
>> unloaded.
> 
> As long as the low-level driver can be unloaded, that's sufficient for 
> hardware- and device-hotplug.
> 

Hi Jeff,

On my laptop I have 2 ide buses, ide0 and ide1.
On ide0 I have my hard-drive hda, and on ide1 I have a swappable
cdrom/hard bay as hdc (also I can plug floppy/2nd battery).
I want to be able to hotswap those devices in ide1.
"idectl 1 on/off" from hdparms is broken.
So, I decided to go for modular ide and have the ide module inserted
twice, one time for ide0, and second time for ide1. (of course with 2
different names).
Is this the correct approach ?

I tried to compile IDE as module (kernel 2.6.8-rc4-mm1) in order to have
ide.ko and to be able to insert it with 
insmod ide.ko -o ide0 options="ide1=noprobe"
and
insmod ide.ko -o ide1 options="ide0=noprobe"

Is this supposed to work on a 2.6.x kernel ?
I could not find any ide.ko generated. Only ide-core.ko, ide-generic.ko
and others.

My inspiration was Documentation/ide.txt 

Maybe the docs have to be updated a little bit, but till then, can you
give me some directions on how to proceed further ?

Thanks,
Paul


