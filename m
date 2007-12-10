From: Tejun Heo <htejun@gmail.com>
Subject: Re: Recent kernel hosing partition
Date: Mon, 10 Dec 2007 22:39:54 +0900
Message-ID: <475D41AA.2060205@gmail.com>
References: <14119388.post@talk.nabble.com> <475CEFF8.5050707@gmail.com>	 <f68177890712100208o27d71584l685520d2e9ecf5bd@mail.gmail.com>	 <475D11A1.1070700@gmail.com> <f68177890712100347i3a03df38n36cffd00c8603ae1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:21760 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbXLJNkD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 08:40:03 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1632091rvb
        for <linux-ide@vger.kernel.org>; Mon, 10 Dec 2007 05:39:59 -0800 (PST)
In-Reply-To: <f68177890712100347i3a03df38n36cffd00c8603ae1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Business Kid <business.kid@gmail.com>
Cc: linux-ide@vger.kernel.org

Business Kid wrote:
>     Yeah, dd will do that but I'm not too sure whether that would be
>     helpful.  
> 
> That's a bit rough! Hexedit with style?  :-).

:-)

>     The drive is triggering all sorts of errors.  Can you post the
>     result of 'smartctl -a /dev/sdX' where sdX is the offending drive.  Also
>     please restore cc to linux-ide@vger.kernel.org
>     <mailto:linux-ide@vger.kernel.org>.
> 
> 
> Attached smartctl -a /dev/sda > smartctl.out
> 
> I see where you're going, and I think you're wrong. The drive is only 2
> months old. I had heavy toolchain compiles and massive copies/ deletions
> pass of without incident on sda8 while F7's root partition (sda3) was
> lightly loaded by comparison. sda3 picked up _all_ the errors.  I never
> hit an error on the hard work - no dodgy exits. The console stuff on
> sda3 was all fine. It only screwed every application I was running under
> X - Firefox particularly. I could still compile with the tools & libs on
> sda3 when X was screwed. Badblocks never found a thing (e2fsck -cf).
> Lost+found is empty on every other partition.

Right, it doesn't look like your harddrive is bad.

> Sadly, "errors all over the place" is common enough with Via chipsets
> and Seagate disks.  I've seen it before. I'm stuck with Via in this box.
> I would not have bought Seagate, but when someone gives it to you and
> you're unemployed...

I'm not aware of any specific issues with via + Segate drives.  Have
pointers?

> Another issue here is that the old ide driver could get through the
> mess, whereas the newer one cannot. I get "Drive reset: success" and the
> old ide driver recovers, whereas the new one goes out to lunch. The log
> snippets show a 60 seconds gap between errors. That's a 60 second freeze.

Hmmm...

1. So, the IDE driver suffers from error conditions too?  Do you have
logs around?

2. Do you have logs of libata driver goes out to lunch?

3. Can you post boot log from you current setup?

Thanks.

-- 
tejun
