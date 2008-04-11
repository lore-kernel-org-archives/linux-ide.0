From: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Subject: Re: Western Digital GreenPower drives and Linux
Date: Fri, 11 Apr 2008 22:00:28 +0100
Message-ID: <200804112200.28854.tvrtko@ursulin.net>
References: <234148243@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mk-outboundfilter-5-a-2.mail.uk.tiscali.com ([212.74.114.4]:57971
	"EHLO mk-outboundfilter-5-a-2.mail.uk.tiscali.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760110AbYDKU75 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Apr 2008 16:59:57 -0400
In-Reply-To: <234148243@web.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: devzero@web.de
Cc: lkml@metanurb.dk, pernegger@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>


> >I got back from WD's tech support and received a DOS utility which can
> > control this drive feature, apparently using vendor specific commands.
> > With it head unload timer can be disabled or set to a period between
> > 100ms and 25.5s.

Followup with some good news.

Head unload timer settings seems to be persistent across powering off. Having 
set it to a maximum value of 25.5 seconds my disk is now behaving much more 
reasonable.

To actually do it I used FreeDOS floppy image burnt on a CD-RW as a bootable 
image plus wdidle3.exe in the filesystem itself. 

BTW, WD's tech support has gone silent so chances for an easier solution are 
not so great.

Tvrtko
