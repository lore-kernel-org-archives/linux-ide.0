From: Tejun Heo <tj@kernel.org>
Subject: Re: ata: BUG in ata_sff_hsm_move
Date: Fri, 29 Jan 2016 06:52:14 -0500
Message-ID: <20160129115214.GM32380@htj.duckdns.org>
References: <CACT4Y+b_JsOxJu2EZyEf+mOXORc_zid5V1-pLZSroJVxyWdSpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36252 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbcA2LwQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2016 06:52:16 -0500
Content-Disposition: inline
In-Reply-To: <CACT4Y+b_JsOxJu2EZyEf+mOXORc_zid5V1-pLZSroJVxyWdSpw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@redhat.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, syzkaller <syzkaller@googlegroups.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>

Hello, Dmitry.

On Thu, Jan 28, 2016 at 12:35:43PM +0100, Dmitry Vyukov wrote:
> Hello,
> 
> I episodically hit the following BUG while running syzkaller fuzzer:
> 
> ata2: protocol 2 task_state 0 (dev_stat 0x41)
> ------------[ cut here ]------------
> kernel BUG at drivers/ata/libata-sff.c:1302!
...
> So the unexpected state is HSM_IDLE.

Hmmm... the port interrupt handler checks for IDLE before calling into
hsm_move, so the only explanation would be that something is resetting
it to IDLE inbetween.  ce7514526742 ("libata: prevent HSM state change
race between ISR and PIO") describes and fixes the same problem.  The
fix seems correct and I can't find anywhere else where this can
happen.  :(

Can you please post the kernel log leading to the BUG?  Also, I don't
think that condition needs to be BUG.  I'll change it to WARN.

Thanks.

-- 
tejun
