From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Date: Thu, 31 Mar 2005 13:35:27 +0200
Message-ID: <20050331113526.GB27731@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F3673231C2@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.elte.hu ([157.181.151.9]:53155 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261360AbVCaLfh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Mar 2005 06:35:37 -0500
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231C2@MAILIT.keba.co.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Florian Schmidt <mista.tapas@gmx.net>


* kus Kusche Klaus <kus@keba.com> wrote:

> I've written a small test program which enables periodic RTC 
> interrupts at 8192 Hz and then goes into a loop reading /dev/rtc and 
> collecting timing statistics (using the rdtscl macro).

getting /dev/rtc handling right for latency measurement is ... tricky.  
The method i'm using under PREEMPT_RT is:

 chrt -f 84 -p `pidof 'IRQ 0'`
 chrt -f 95 -p `pidof 'IRQ 8'`
 ./rtc_wakeup -f 1024 -t 100000

you can get rtc_wakeup from:

 http://www.affenbande.org/~tapas/wiki/index.php?rtc_wakeup

written by Florian Schmidt.

do you see high latencies even with rtc_wakeup?

	Ingo
