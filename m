From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [bug] 2.6.27-rc1: I/O errors after resume
Date: Thu, 31 Jul 2008 20:41:35 +0200
Message-ID: <200807312041.35544.rjw@sisk.pl>
References: <200807281203.38822.j.schneider@uib.de> <200807311531.18377.rjw@sisk.pl> <E1KOYng-0000FR-Cr@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56516 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211AbYGaSiv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 14:38:51 -0400
In-Reply-To: <E1KOYng-0000FR-Cr@pomaz-ex.szeredi.hu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, 31 of July 2008, Miklos Szeredi wrote:
> On Thu, 31 Jul 2008, Rafael J. Wysocki wrote:
> > On Thursday, 31 of July 2008, Miklos Szeredi wrote:
> > > With 2.6.27-rc1 things break badly after resume on my T60.  Dmesg and
> > > config attached.  2.6.26 worked fine.
> > 
> > Ugh, lots of stuff in a single message.
> 
> Yeah, sorry.  Search for "I/O error" for the interesting parts.
> 
> > Anyway, can you try the current -git and report back, please?  It's possible
> > that this has been fixed already.
> 
> Not fixed:
> 
> mszeredi@tucsk:~> uname -a
> Linux tucsk 2.6.27-rc1-00156-g94ad374 #17 SMP Thu Jul 31 15:45:10 CEST 2008 x86_64 x86_64 x86_64 GNU/Linux
> mszeredi@tucsk:~> dmesg
> bash: /bin/dmesg: Input/output error
> 
> Seems easily reproducible, so if no better ideas I can try to bisect it.

That would be really helpful.

Thanks,
Rafael
