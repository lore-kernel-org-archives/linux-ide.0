From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Date: Thu, 31 Mar 2005 17:22:40 +0200
Message-ID: <20050331152240.GA7509@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F3673231D2@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.elte.hu ([157.181.1.137]:28119 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261469AbVCaPXh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Mar 2005 10:23:37 -0500
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231D2@MAILIT.keba.co.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Florian Schmidt <mista.tapas@gmx.net>


* kus Kusche Klaus <kus@keba.com> wrote:

> The following tests are made with 'IRQ 8' at 95, rtc_wakeup at 89(99):
> * Heavy mmap load, no oom: max jitter:     42.1% (   51 usec)
> * Heavy mmap load, oom:    max jitter:  11989.2% (14635 usec)
>   (but still "missed irqs: 0", so IRQ 8 was also blocked for 14 ms)

did you get any kernel messages in that time? (about missed irqs, etc.)  
Please do a 'dmesg -n 0' to minimize the effect of kernel messages.

	Ingo
