From: "Ryan Earl" <heretic@clanhk.org>
Subject: Re: siimage and drive order problem
Date: Fri, 26 Dec 2003 07:14:39 -0600 (CST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <34449.209.163.161.49.1072444479.squirrel@mail.clanhk.org>
References: <20031226085450.A4045@nettis.grimsta>
Reply-To: heretic@clanhk.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palace.clanhk.org ([64.5.48.96]:20203 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S265178AbTLZNS5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Dec 2003 08:18:57 -0500
In-Reply-To: <20031226085450.A4045@nettis.grimsta>
List-Id: linux-ide@vger.kernel.org
To: Daniel Brahneborg <daniel.com@wtnord.net>
Cc: linux-ide@vger.kernel.org

On Friday 26 December 2003 07:54 am, Daniel Brahneborg wrote:
The motherboard has two
> additional serial-ata slots on a VIA chip, and a normal
> IDE disk on ide0.
> My problem is that when I boot with siimage.c enabled
> or try to insert it as a module after booting, it forces
> the drives on that card to become hda and hdb

Are you sure about the module?  If you boot with your southbridge's ATA
driver
built directly into the kernel it should be initialized first, and show your
PATA ports starting at hda.  After those are assigned, if you modprobe 
siimage those ports should be hde and hdg or hdi and hdk if that
southbridge
has 4 PATA ports.  It does right?

That's what works for me anyway with a KT333 chipset = via82cxxx
southbridge.
What does the ordering mess up that modifications to fstab or raidtab 
couldn't fix?  You bootloader should have some way of setting a different 
root directory right after the POST.

-ryan



