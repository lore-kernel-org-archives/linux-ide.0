From: Ingo Molnar <mingo@elte.hu>
Subject: Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017
	ata_sff_hsm_move+0x45e/0x750()
Date: Sat, 10 Jan 2009 14:24:12 +0100
Message-ID: <20090110132412.GB14049@elte.hu>
References: <200901091334.55823.borntraeger@de.ibm.com> <200901101009.13699.borntraeger@de.ibm.com> <20090110104114.633cacd8@lxorguk.ukuu.org.uk> <200901101242.05203.borntraeger@de.ibm.com> <49688B63.5030105@ru.mvista.com> <20090110122130.318cf168@lxorguk.ukuu.org.uk> <20090110130745.GA14049@elte.hu> <49689EA8.20506@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:37779 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbZAJNZE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jan 2009 08:25:04 -0500
Content-Disposition: inline
In-Reply-To: <49689EA8.20506@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, lkml <linux-kernel@vger.kernel.org>


* Jeff Garzik <jeff@garzik.org> wrote:

> Ingo Molnar wrote:
>> 871af12: libata: Add 32bit PIO support
>
> What happens when you back this out?

yep, that's the one that looked most suspect to me too so i already 
reverted it in tip/out-of-tree.

But in the normal tip/master test cycle the box takes about 50 minutes to 
build its random kernel and reboot into it (800 MHz P3), so i started a 
full automated bisection instead driven from a faster box.

The bug triggers deterministically so whatever leads to it, we should have 
it within ~20 minutes with a bit of luck (== there's no other bug in the 
bisection run that makes bisection more difficult).

The current bisection state is:

 # bad:  [9a100a44] Merge git://git.kernel.org/pub/scm/linux/kernel/gi
 # good: [9e42d0cf] Merge git://git.kernel.org/pub/scm/linux/kernel/gi
 # good: [e441d54d] Btrfs: add permission checks to the ioctls
 # bad:  [cd764695] Merge git://git.kernel.org/pub/scm/linux/kernel/gi
 # bad:  [a419df8a] Merge branch 'upstream-linus' of git://git.kernel.
 # good: [61bce0f1] pid: generalize task_active_pid_ns

and "871af12: libata: Add 32bit PIO support" is still in the bisection 
window.

	Ingo
