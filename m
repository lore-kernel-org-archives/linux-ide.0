From: Dave Jones <davej@redhat.com>
Subject: Re: Linux v2.6.22-rc3
Date: Fri, 1 Jun 2007 14:20:56 -0400
Message-ID: <20070601182056.GA11716@redhat.com>
References: <9d2cd630705280707h4921900fxc93a07a87f0bdf66@mail.gmail.com> <465BF244.5080200@gmail.com> <alpine.LFD.0.98.0705290924350.26602@woody.linux-foundation.org> <465F6F48.8080804@gmail.com> <alpine.LFD.0.98.0705311830360.26602@woody.linux-foundation.org> <465F8230.2040105@gmail.com> <46604E62.1000105@pobox.com> <alpine.LFD.0.98.0706010955390.3957@woody.linux-foundation.org> <466058F8.4050107@pobox.com> <alpine.LFD.0.98.0706011047000.3957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:36876 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761090AbXFASVI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Jun 2007 14:21:08 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706011047000.3957@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Gregor Jasny <gjasny@googlemail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Fri, Jun 01, 2007 at 10:59:51AM -0700, Linus Torvalds wrote:

 > > I'm mainly interested in hearing feedback from Fedora 7 damage, before making
 > > a major decision about the probing code.  If this is a single dain bramaged
 > > device, we should avoid punishing the majority.  But if this is a trend, it
 > > warrants careful reconsideration.
 > 
 > I thought the default in Fedora was to use the PATA driver first? If so, 
 > you're going to miss a lot of cases that "just work", because they use the 
 > old driver.

There are no old drivers in F7 and beyond.

# CONFIG_IDE is not set

	Dave

-- 
http://www.codemonkey.org.uk
