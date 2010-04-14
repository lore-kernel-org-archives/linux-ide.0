From: Borislav Petkov <bp@alien8.de>
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle
 kernel NULL pointer dereference at 00000024(?)
Date: Wed, 14 Apr 2010 10:07:37 +0200
Message-ID: <20100414080737.GB23153@liondog.tnic>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
 <201004131823.o3DIN5t1018540@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:36224 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433Ab0DNIQe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Apr 2010 04:16:34 -0400
Content-Disposition: inline
In-Reply-To: <201004131823.o3DIN5t1018540@demeter.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kernelbugs@nebuk.de, kernelbug@develz.org
Cc: linux-ide@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org

From: bugzilla-daemon@bugzilla.kernel.org
Date: Tue, Apr 13, 2010 at 06:23:05PM +0000

(switching to mail)

> https://bugzilla.kernel.org/show_bug.cgi?id=14994
> 
> 
> 
> 
> 
> --- Comment #19 from Marc H. Thoben <kernelbug@develz.org>  2010-04-13 18:22:58 ---
> Created an attachment (id=25992)
>  --> (https://bugzilla.kernel.org/attachment.cgi?id=25992)
> dmesg, debug ide-cd_mod, untainted kernel, request sense failure 2
> 
> Same as last time. Didn't touch the cdrom this time - didn't even run anything
> that could possibly try to check for an inserted medium.
> 
> Borislav, is this even slightly interesting? Or rather some bug with
> hald-addon-storage?

Ok, no, these are follow-up traces of hung tasks. I'm looking into
the original oops. In the meantime, can you guys both try whether
the problem still occurs with the latest kernel - 2.6.34-rc4 is that
currently.

Thanks.

-- 
Regards/Gruss,
    Boris.
