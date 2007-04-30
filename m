From: "Berck E. Nash" <flyboy@gmail.com>
Subject: Re: 2.6.21-rc7-mm1 BUG at kernel/sched-clock.c:175 init_sched_clock()
Date: Mon, 30 Apr 2007 06:07:49 -0600
Message-ID: <4635DC15.6090705@gmail.com>
References: <462E4C4D.9020806@gmail.com> <20070425011654.222a2b4b.akpm@linux-foundation.org> <462F1481.8010807@gmail.com> <20070425085432.GD17130@htj.dyndns.org> <20070425093044.GE17130@htj.dyndns.org> <462FE982.7030906@gmail.com> <46354620.4060902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:63214 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423181AbXD3MHx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Apr 2007 08:07:53 -0400
Received: by py-out-1112.google.com with SMTP id a29so1312403pyi
        for <linux-ide@vger.kernel.org>; Mon, 30 Apr 2007 05:07:52 -0700 (PDT)
In-Reply-To: <46354620.4060902@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:

> Hmmm... Once properly initialized, ahci is highly unlikely to cause
> runaway IRQs which results in nobody cared.  It has proper IRQ mask and
> pending bits allowing the driver to reliably detect when and why the
> controller is raising interrupt and disable it if necessary.  Can you
> try without the NVIDIA module?

I'm beginning to think it was a one-time hardware error of some sort.
I've been running 2.6.21-rc7-mm2 for awhile now and the problem hasn't
reoccurred, so I think you can consider the matter settled...

Thanks,
Berck
