From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux v2.6.22-rc3
Date: Fri, 1 Jun 2007 11:30:49 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706011127500.3957@woody.linux-foundation.org>
References: <9d2cd630705280707h4921900fxc93a07a87f0bdf66@mail.gmail.com>
 <465BF244.5080200@gmail.com> <alpine.LFD.0.98.0705290924350.26602@woody.linux-foundation.org>
 <465F6F48.8080804@gmail.com> <alpine.LFD.0.98.0705311830360.26602@woody.linux-foundation.org>
 <465F8230.2040105@gmail.com> <46604E62.1000105@pobox.com>
 <alpine.LFD.0.98.0706010955390.3957@woody.linux-foundation.org>
 <466058F8.4050107@pobox.com> <alpine.LFD.0.98.0706011047000.3957@woody.linux-foundation.org>
 <20070601182056.GA11716@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:37163 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759665AbXFASbe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Jun 2007 14:31:34 -0400
In-Reply-To: <20070601182056.GA11716@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Gregor Jasny <gjasny@googlemail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>



On Fri, 1 Jun 2007, Dave Jones wrote:
> 
> There are no old drivers in F7 and beyond.
> 
> # CONFIG_IDE is not set

Ahh, that's certainly going to root out the issues. Now let's hope that 
people install it..

(Fedora seems to make it hard on purpose to upgrade between major 
revisions, but maybe that's just me not reading the docs as usual ;)

		Linus
