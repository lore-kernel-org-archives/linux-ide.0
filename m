From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [bug] 2.6.27-rc1: I/O errors after resume
Date: Thu, 31 Jul 2008 16:06:40 +0200
Message-ID: <E1KOYng-0000FR-Cr@pomaz-ex.szeredi.hu>
References: <200807281203.38822.j.schneider@uib.de> <20080730011223.8f04ba20.akpm@linux-foundation.org> <E1KOXpA-00005w-Vl@pomaz-ex.szeredi.hu> <200807311531.18377.rjw@sisk.pl>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fxip-0047f.externet.hu ([88.209.222.127]:57019 "EHLO
	pomaz-ex.szeredi.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbYGaOGm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jul 2008 10:06:42 -0400
In-reply-to: <200807311531.18377.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rjw@sisk.pl
Cc: miklos@szeredi.hu, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 31 Jul 2008, Rafael J. Wysocki wrote:
> On Thursday, 31 of July 2008, Miklos Szeredi wrote:
> > With 2.6.27-rc1 things break badly after resume on my T60.  Dmesg and
> > config attached.  2.6.26 worked fine.
> 
> Ugh, lots of stuff in a single message.

Yeah, sorry.  Search for "I/O error" for the interesting parts.

> Anyway, can you try the current -git and report back, please?  It's possible
> that this has been fixed already.

Not fixed:

mszeredi@tucsk:~> uname -a
Linux tucsk 2.6.27-rc1-00156-g94ad374 #17 SMP Thu Jul 31 15:45:10 CEST 2008 x86_64 x86_64 x86_64 GNU/Linux
mszeredi@tucsk:~> dmesg
bash: /bin/dmesg: Input/output error

Seems easily reproducible, so if no better ideas I can try to bisect
it.

Miklos
