From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: AHCI driver problem on ICH (Re: AHCI driver problem on SB700/SB800 w/ Acer Ferrari One)
Date: Fri, 13 May 2011 22:44:29 +0200
Message-ID: <201105132244.29605.rjw@sisk.pl>
References: <201105120025.34531.rjw@sisk.pl> <BANLkTimqxmbpP1-+HxhPQS-YoLTh=bHd1Q@mail.gmail.com> <201105132222.11582.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50443 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758906Ab1EMUn4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 May 2011 16:43:56 -0400
In-Reply-To: <201105132222.11582.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Michael Leun <lkml20100708@newton.leun.net>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Friday, May 13, 2011, Rafael J. Wysocki wrote:
> On Friday, May 13, 2011, Tejun Heo wrote:
> > Hello,
> > 
> > Can you guys please take a look at bug#34692?  It seems to be the same problem.
> > 
> >   https://bugzilla.kernel.org/show_bug.cgi?id=34692
> 
> Yes, same issue.
> 
> > The offending commit seems to be 270dac35c2.  Does reverting it
> > resolves the problem for you guys too?
> 
> Yes, it does.

Would you object if I asked Linus to revert that commit?

Rafael
