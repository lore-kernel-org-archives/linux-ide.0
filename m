From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [git patches] libata fixes
Date: Tue, 30 Oct 2007 20:46:25 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0710302045310.31325@fbirervta.pbzchgretzou.qr>
References: <20071030184502.GA27246@havoc.gtf.org>
 <alpine.LFD.0.999.0710301151000.30120@woody.linux-foundation.org>
 <47278206.2080601@garzik.org> <alpine.LFD.0.999.0710301225370.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:38047 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbXJ3Tq0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 15:46:26 -0400
In-Reply-To: <alpine.LFD.0.999.0710301225370.30120@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Mikael Pettersson <mikpe@it.uu.se>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


On Oct 30 2007 12:31, Linus Torvalds wrote:
>On Tue, 30 Oct 2007, Jeff Garzik wrote:
>> 
>> Can we change git-am to accept two dashes as well as three?  :)
>> 
>> It seems pretty common, not just with Mikael but several others who send
>> patches to me.
>
>Well, git-am actually used to be a lot less strict about the dashes, and 
>we've made it *more* strict rather than less, because the more of these 
>breaks we accept, the more likely it is that something that was intended 
>to be part of the message gets thrown out.. So I'll say that I'm a bit 
>nervous about extending it again.

I would not add --. It is already used ("-- " is) in the mail world as a
signature separator. Let's stay with ---, which is also what quilt generates.
>
>The reason for the three dashes is actually that that is what a *diff* 
>starts with. So if you look at what "closes" a description as far as 
>git-am is concerned, they are currently all things that are likely to 
>start a patch: "Index: " or "diff -" or "--- <filename>", and that last 
>case was then extended to be "manual break" even without the filename 
>information.
>
>See git/builtin-mailinfo.c: patchbreak().
>
>But you could try to sell it to Junio. He's the maintainer, and while I 
>care about some other things and will argue violently against them, when 
>it comes to something like this, Junio is the guy to go to.
>
>That said, I really think you could just try to educate the people you 
>work with. Maybe they just never even realized that "three dashes" is what 
>you're supposed to use!
>
>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

