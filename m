From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.21-rc7-mm1 BUG at kernel/sched-clock.c:175 init_sched_clock()
Date: Tue, 01 May 2007 11:02:02 +0200
Message-ID: <4637020A.8070400@gmail.com>
References: <462E4C4D.9020806@gmail.com> <20070425011654.222a2b4b.akpm@linux-foundation.org> <462F1481.8010807@gmail.com> <20070425085432.GD17130@htj.dyndns.org> <20070425093044.GE17130@htj.dyndns.org> <462FE982.7030906@gmail.com> <46354620.4060902@gmail.com> <4635DC15.6090705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:28083 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031601AbXEAJDV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2007 05:03:21 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1844327wra
        for <linux-ide@vger.kernel.org>; Tue, 01 May 2007 02:03:21 -0700 (PDT)
In-Reply-To: <4635DC15.6090705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Berck E. Nash" <flyboy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello,

Berck E. Nash wrote:
> Tejun Heo wrote:
> 
>> Hmmm... Once properly initialized, ahci is highly unlikely to cause
>> runaway IRQs which results in nobody cared.  It has proper IRQ mask and
>> pending bits allowing the driver to reliably detect when and why the
>> controller is raising interrupt and disable it if necessary.  Can you
>> try without the NVIDIA module?
> 
> I'm beginning to think it was a one-time hardware error of some sort.
> I've been running 2.6.21-rc7-mm2 for awhile now and the problem hasn't
> reoccurred, so I think you can consider the matter settled...

Hmmmmmmmmmmmm... Please let me know if this thing happens again.

-- 
tejun
