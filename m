From: Hans Mueller <hans42mueller@googlemail.com>
Subject: Re: [Bug 16142] r8169: Kernel Panic when a lot of data is
 transferred through network interface
Date: Sat, 3 Jul 2010 13:41:49 +0200
Message-ID: <20100703134149.63fd8c6d@cbook.fritz.box>
References: <20100618074510.GD32368@liondog.tnic>
	<20100619005045.2173fcce@cpc>
	<20100619100511.GA31429@liondog.tnic>
	<20100619132708.030fe408@cpc>
	<20100623080200.GB5010@liondog.tnic>
	<20100625185846.72171be0@cpc>
	<20100630065426.GA1857@liondog.tnic>
	<20100630200254.45ab84d1@cpc>
	<20100630183138.GA11036@liondog.tnic>
	<20100703094918.03007437@cbook.fritz.box>
	<20100703082304.GA25293@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45505 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab0GCLhw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Jul 2010 07:37:52 -0400
Received: by bwz1 with SMTP id 1so1987900bwz.19
        for <linux-ide@vger.kernel.org>; Sat, 03 Jul 2010 04:37:50 -0700 (PDT)
In-Reply-To: <20100703082304.GA25293@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

Hi

On Sat, 3 Jul 2010 10:23:04 +020I0
Borislav Petkov <bp@alien8.de> wrote:
> Ok, this confirms my suspicion that it is shared-irq related. Also, we
> already verified that switching to libata does fix the issue for you so
> you are good to go. Considering the DEPRECATED status of ide, I have a
> very little incentive in hunting this thing further down, so let's leave
> it at that.

Okey good. :)

 
> Jonas, big thanks for your hard work with testing patches and ideas. I
> really appreciate it! :)
You're welcome. :)

Big thanks to all of you who tried to resolve the bug, or helped in
another way.
I do especially emphasize this, as it seems not to standard to answer
bugreports at all. (At least on the b43 bugreport list; I reported a
bug as their driver seems to have destroyed my wifi card. Don't
missundersstand me I know this can happen, but I exspected the will to
stop the driver from destroying other peoples hardware.)


--
Regards/Gruss Jonas
