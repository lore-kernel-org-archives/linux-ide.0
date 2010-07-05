From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Bug 16142] r8169: Kernel Panic when a lot of data is
 transferred through network interface
Date: Mon, 5 Jul 2010 14:11:39 +0200
Message-ID: <20100705121138.GA4811@a1.tnic>
References: <20100623080200.GB5010@liondog.tnic>
 <20100625185846.72171be0@cpc>
 <20100630065426.GA1857@liondog.tnic>
 <20100630200254.45ab84d1@cpc>
 <20100630183138.GA11036@liondog.tnic>
 <20100703094918.03007437@cbook.fritz.box>
 <20100703082304.GA25293@liondog.tnic>
 <20100703134149.63fd8c6d@cbook.fritz.box>
 <20100703115305.GA26168@liondog.tnic>
 <20100705134401.30c8112c@cbook>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:55209 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754891Ab0GEMLp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jul 2010 08:11:45 -0400
Content-Disposition: inline
In-Reply-To: <20100705134401.30c8112c@cbook>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans Mueller <hans42mueller@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

From: Hans Mueller <hans42mueller@googlemail.com>
Date: Mon, Jul 05, 2010 at 01:44:01PM +0200

> even if this is quite offtopic and I'm not sure whether linux-ide
> sould be still in the Cc field, I answert to all to leave nobody with
> half of the story :)

Right.

> > Did you also add the wireless maintainer to the Cc of your bugreport
> > - "John W. Linville" <linville@tuxdriver.com>  [...]
> 
> No that is the only thing I did not. I followed the instructions from:
> http://linuxwireless.org/en/users/Drivers/b43#bug_reporting
> It wasn't mentioned to Cc anybody as far as I know :)
> 
> 
> 
> > [...] along with a detailed
> > description of what the problem is, which kernel, how to reproduce along
> > with dmesg?
> 
> I attached the text of the original mail (but not the attachments as
> there should be no need for them in here; if I am wrong with this, ask
> me for them :) )
> If there is anything wrong with the bugreport, feel free to criticize.

Yep, it looks good. Bottom line is: The bug report should try to
plausibly lay out what the symptoms are and how to reproduce them, if
possible. Better be too verbose than not to mention something which
might turn out important.

Btw, does MacOS recognize your wlan card at all or is it completely
bricked? And does it freeze only after you reboot from Linux?

> I am aware that this is offtopic, so do not spend to much time
> on it, I am going to send a copy of the original mail to the wireless
> maintainer, as you suggested, and see what will happen.

Yes, good luck :)

-- 
Regards/Gruss,
Boris.
