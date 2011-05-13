From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: AHCI driver problem on ICH (Re: AHCI driver problem on SB700/SB800 w/ Acer Ferrari One)
Date: Fri, 13 May 2011 22:20:08 +0200
Message-ID: <201105132220.08760.rjw@sisk.pl>
References: <201105120025.34531.rjw@sisk.pl> <BANLkTimqxmbpP1-+HxhPQS-YoLTh=bHd1Q@mail.gmail.com> <20110513215413.3480d6b5@xenia.leun.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50391 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757347Ab1EMUTq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 May 2011 16:19:46 -0400
In-Reply-To: <20110513215413.3480d6b5@xenia.leun.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Leun <lkml20100708@newton.leun.net>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>

On Friday, May 13, 2011, Michael Leun wrote:
> On Fri, 13 May 2011 19:39:51 +0200
> Tejun Heo <tj@kernel.org> wrote:
> 
> > Can you guys please take a look at bug#34692?  It seems to be the
> > same problem.
> > 
> >   https://bugzilla.kernel.org/show_bug.cgi?id=34692
> > 
> > The offending commit seems to be 270dac35c2.  Does reverting it
> > resolves the problem for you guys too?
> 
> - Does not happen with 2.6.38.6
> 
> - Happens 100% of cases with 2.6.39-rc7 (connect ac adapter or suspend
>   to ram with ac connected and resume with ac disconnected)
> 
> - Reverting 270dac35c26433d06a89150c51e75ca0181ca7e4 fixes issue

I can confirm that.

Thanks,
Rafael
