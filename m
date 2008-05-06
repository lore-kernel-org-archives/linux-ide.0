From: "Chris Smith" <smitty1elkml@gmail.com>
Subject: .config changes affecting Intel 82801GBM/GHM ICH7 SATA IDE
Date: Mon, 5 May 2008 21:49:20 -0400
Message-ID: <9b53a56d0805051849w6ce23fbp70a0ac17cf0ffaa0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:55308 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbYEFBtV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2008 21:49:21 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1428800rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 05 May 2008 18:49:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello, linux-ide.
 I cannot boot any of the recent release kernels.  My last good kernel
is gentoo 2.6.25-rc8-git3.
 After doing
#cat /proc/config | gunzip >> .config && make menuconfig
 and then exiting immediately, the terminal has output like this for
anything after the last good kernel that I've tried:

[snip]
scripts/kconfig/mconf arch/x86/Kconfig
.config:19:warning: trying to assign nonexistent symbol SEMAPHORE_SLEEPERS
.config:287:warning: trying to assign nonexistent symbol PM_LEGACY
.config:514:warning: trying to assign nonexistent symbol
MAC80211_RC_DEFAULT_SIMPLE
.config:526:warning: trying to assign nonexistent symbol MAC80211_RC_SIMPLE
.config:600:warning: trying to assign nonexistent symbol BLK_DEV_HD_IDE
.config:661:warning: trying to assign nonexistent symbol IDE_ARCH_OBSOLETE_INIT
.config:909:warning: trying to assign nonexistent symbol SK98LIN
.config:942:warning: trying to assign nonexistent symbol IWL3945_QOS
.config:1510:warning: trying to assign nonexistent symbol USB_PERSIST
.config:1831:warning: trying to assign nonexistent symbol NFS_DIRECTIO

I'm working on my git-fu, and will hopefully manage my very first
bisect as soon as this weekend.
Something in the area of the removal of IDE_ARCH_OBSOLETE_INIT seems
about the right place to begin.
Casting about on Google and Gmane have afforded few clues.  I didn't
think this hardware so old, but, hey.
If somebody could clue-bat me with advice or a link to a tutorial to
save time, that would be a blessing.
Cheers,
-- 
Christopher Smith
Pursuer of knowledge
