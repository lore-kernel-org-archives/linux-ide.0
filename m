From: Tejun Heo <htejun@gmail.com>
Subject: Re: Linux v2.6.22-rc3
Date: Fri, 01 Jun 2007 11:19:28 +0900
Message-ID: <465F8230.2040105@gmail.com>
References: <alpine.LFD.0.98.0705252008210.26602@woody.linux-foundation.org>  <9d2cd630705270801m2826be60p3f802c502b26c531@mail.gmail.com>  <46599E6B.1000209@pobox.com>  <9d2cd630705270907y4722653cpf79f073fa8f12f08@mail.gmail.com>  <alpine.LFD.0.98.0705270922030.26602@woody.linux-foundation.org>  <9d2cd630705271315x7030c91ew2f175c921c022880@mail.gmail.com>  <465AA536.6080608@gmail.com> <9d2cd630705280707h4921900fxc93a07a87f0bdf66@mail.gmail.com> <465BF244.5080200@gmail.com> <alpine.LFD.0.98.0705290924350.26602@woody.linux-foundation.org> <465F6F48.8080804@gmail.com> <alpine.LFD.0.98.0705311830360.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:36661 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbXFACUl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 May 2007 22:20:41 -0400
Received: by nz-out-0506.google.com with SMTP id n1so376328nzf
        for <linux-ide@vger.kernel.org>; Thu, 31 May 2007 19:20:40 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0705311830360.26602@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: Gregor Jasny <gjasny@googlemail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello,

Linus Torvalds wrote:
> On Fri, 1 Jun 2007, Tejun Heo wrote:
>> Gregor's cdrom has broken SRST support which is extremely rare and
>> broken.
> 
> Well, the concept is neither rare nor arguably all that broken. 
> 
> The paper standards floating around in the industry are so much toilet 
> paper. The only standard that seems to really matter is what Windows has 
> traditionally done. We may not like it, but there it is...
> 
> This bites us more when it comes to the real el-cheapo stuff, notably when 
> it comes to various USB mass storage things (which have some random 
> USB->flash controller cobbled together by a senile llama on crack), and is 
> almost unheard of for anythign that is "server-grade", but when it comes 
> to no-brand random devices, it really does tend to be the case that the 
> only testing they ever had was using Windows.
> 
> And hardware is seldom any different from software: if it wasn't tested, 
> it probably doesn't work.

Yeap, agreed.  SRST on PATA works on most devices tho.  This device is
the first reported one which genuinely doesn't like SRST itself but we
also had a case where a device doesn't report proper diagnostic code and
another one which reports incorrect device class code.

Hardreset on SATA works better because it's much more integral part of
the protocol.  SRST also seems to work better but there is an emulated
PMP device which craps itself if SRST is issued to it.

> So it would be good if somebody knew what the Windows ID/startup sequence 
> was/is. I think we figured it out by trial-and-error for the USB mass 
> storage stuff. But it tends to boil down to: don't do things that aren't 
> absolutely required (for SCSI, it was things like not asking for mode 
> pages that weren't absolutely required, because some devices wouldn't 
> support it, and would simply lock up if you did so!)

Most BIOSen, Windows and old IDE driver don't reset at all during
probing.  They first issue IDENTIFY unconditionally, if that fails,
IDENTIFY_PACKET.  From the beginning, libata has issued reset during
probing.  We've had a few problems regarding this but they have been
worked around successfully till now.  One of the upsides of doing reset
during probing is that the reset code path gets tested a lot and libata
is more likely to recover properly after error conditions.  With SATA,
this is getting more important because errors are much more common and
happen occasionally even on perfectly healthy machines.

As libata gets much wider userbase including old/weird PATA devices, we
seem to be facing more of these broken devices.  We may be reaching the
point where the benefit of doing reset during probing isn't worth the
price we have to pay, at least on PATA.

Jeff, what do you think?

-- 
tejun
