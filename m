From: Tejun Heo <tj@kernel.org>
Subject: Re: WARNING: at kernel/lockdep.c:2323
 trace_hardirqs_on_caller+0xb9/0x16c()
Date: Thu, 17 Feb 2011 13:54:43 +0100
Message-ID: <20110217125443.GU19830@htj.dyndns.org>
References: <4D5A90D0.9040403@free.fr>
 <AANLkTimvue3JbYZUMrt0KppE1f_MNSsyyb+Upbputs=5@mail.gmail.com>
 <20110216.180347.71107177.davem@davemloft.net>
 <AANLkTim4NnyyFqprBoGpimquLP=6fjAanCrbqX=RXwC9@mail.gmail.com>
 <20110217112842.GS19830@htj.dyndns.org>
 <4D5D0FFC.40509@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35258 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab1BQMyu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2011 07:54:50 -0500
Content-Disposition: inline
In-Reply-To: <4D5D0FFC.40509@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@free.fr>
Cc: Yong Zhang <yong.zhang0@gmail.com>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

On Thu, Feb 17, 2011 at 01:09:32PM +0100, Daniel Lezcano wrote:
> I applied these patches to linux-next and I blindly fixed some
> minors conflicts. AFAICT, the problem does no longer occur and it
> seems the patches fix the problem. I am not sure I resolved the
> conflict correctly as I know nothing about this subsystem. Shall I
> resend these patches for inclusion and you check they are correct ?

The posted patches are on top of the mainline and the conflicts
against linux-next should be minor.  I'm waiting for Jens to pick up
the patches.  Anyways, there's no harm in posting the rebased patches.

Thanks.

-- 
tejun
