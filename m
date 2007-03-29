From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [3/6] 2.6.21-rc4: known regressions
Date: Thu, 29 Mar 2007 22:24:33 +0800
Message-ID: <b6a2187b0703290724l1ca26fa4vdb73f3ae82d6514f@mail.gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	 <b6a2187b0703261046r46782eedv64464ceddb44bc27@mail.gmail.com>
	 <1175065468.4017.1.camel@chaos>
	 <200703281543.47049.maximlevitsky@gmail.com>
	 <20070328180457.GA4253@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.179]:15945 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbXC2OYh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Mar 2007 10:24:37 -0400
Received: by ik-out-1112.google.com with SMTP id c21so154357ika
        for <linux-ide@vger.kernel.org>; Thu, 29 Mar 2007 07:24:35 -0700 (PDT)
In-Reply-To: <20070328180457.GA4253@mellanox.co.il>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Cc: Maxim <maximlevitsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@lists.osdl.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Jens Axboe <jens.axboe@oracle.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

On 3/29/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
> > Quoting Maxim <maximlevitsky@gmail.com>:
> >                       The patch below is a temporally fix, until
> >       clock-events and clocksources will get proper suspend/resume
> >       hooks:
> Bingo!

I confirmed that it suspend/resume disk/ram all works on my X60s with
CONFIG_HPET_TIMER=y and CONFIG_NO_HZ unset.

But suspend to disk still hang with CONFIG_NO_HZ=y no matter what
setting CONFIG_HPET_TIMER is set to.

Thanks,
Jeff.
