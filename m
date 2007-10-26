From: Jim Paris <jim@jtan.com>
Subject: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Date: Fri, 26 Oct 2007 00:02:26 -0400
Message-ID: <20071026040226.GA26960@jim.sh>
References: <56020.194.255.108.253.1192004925.squirrel@root.dusted.dk> <20071012174153.69556b32.akpm@linux-foundation.org> <47105C53.7040603@lix-world.net> <471DC52B.20802@gmail.com> <471F2647.4030304@lix-world.net> <47214593.1080102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:48206 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbXJZECy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Oct 2007 00:02:54 -0400
Content-Disposition: inline
In-Reply-To: <47214593.1080102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Steen Eugen Poulsen <sep@lix-world.net>, Andrew Morton <akpm@linux-foundation.org>, lists@dusted.dk, Linux Kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, bruce.allen@aei.mpg.de

Tejun Heo wrote:
> [please don't drop cc.  restored]
> 
> Steen Eugen Poulsen wrote:
> >Tejun Heo skrev:
> >>All these are caused by smartd.  Updating should fix the problem.
> >
> >Okay, but there is no newer smartd than what I'm using. (5.37)
> 
> Bruce?  Original thread can be read from...
> 
> http://thread.gmane.org/gmane.linux.kernel/588972

The fixes were added in smartmontools CVS, but there hasn't been a
release since then.

-jim
