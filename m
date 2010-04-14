From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle
 kernel NULL pointer dereference at 00000024(?)
Date: Wed, 14 Apr 2010 22:46:58 +0200
Message-ID: <20100414204658.GA15929@liondog.tnic>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
 <201004131823.o3DIN5t1018540@demeter.kernel.org>
 <20100414080737.GB23153@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:43208 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755426Ab0DNUrE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Apr 2010 16:47:04 -0400
Content-Disposition: inline
In-Reply-To: <20100414080737.GB23153@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kernelbugs@nebuk.de, kernelbug@develz.org
Cc: linux-ide@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org

From: Borislav Petkov <bp@alien8.de>
Date: Wed, Apr 14, 2010 at 10:07:37AM +0200

Hi,

 [ Mark, please try replying with a simple mail instead over bugzilla
 since it is much easier to work that way, thanks ]

> --- Comment #21 from Marc H. Thoben <kernelbug@develz.org>  2010-04-14 18:42:53 ---
> Created an attachment (id=26001)
>  --> (https://bugzilla.kernel.org/attachment.cgi?id=26001)
> dmesg, normal ide-cd_mod, tainted kernel 2.6.34-rc4
> 
> Pity I couldn't get Nouveau working with 2.6.34-rc4 without recompiling X/Mesa
> - which I am not able to.
> 
> So I ran Nvidia again - but it's the same kernel panic, I believe.

No, tainted kernel doesn't help. The only info I get from this is that
it might be that the proprietary crap interferes with the cdrom. How do
I know it doesn't?

Well, I don't because I can't look at the source code. So the reason
I'm asking you to retry without the nvidia driver is so that we can be
really sure whether there's a bug.

Alternatively, if feel like you must use the nvidia driver, you can
always try libata and use the scsi sr_mod driver for your cdrom. Simply
enable CONFIG_BLK_DEV_SR or since you're using distro kernel, simply
blacklist ide-cd_mod and load sr_mod (or something to that extent -
there should be some description how to do this the debian way so use
your favourite search engine).

-- 
Regards/Gruss,
    Boris.
