From: Tejun Heo <tj@kernel.org>
Subject: Re: ata: BUG in ata_sff_hsm_move
Date: Fri, 29 Jan 2016 15:24:40 -0500
Message-ID: <20160129202440.GB4534@mtj.duckdns.org>
References: <CACT4Y+b_JsOxJu2EZyEf+mOXORc_zid5V1-pLZSroJVxyWdSpw@mail.gmail.com>
 <20160129115214.GM32380@htj.duckdns.org>
 <CACT4Y+Y_w3msrTw46T8wGpK-j09e6VAoPFa93JSfm+5_kvBAYQ@mail.gmail.com>
 <20160129122317.GO32380@htj.duckdns.org>
 <CACT4Y+Z5SPCKg0bMC2sD-VbCfJPOixzntb+-zfWcU5jufjygmw@mail.gmail.com>
 <CACT4Y+axb-FagKnftWDkOynT8xWoqOw758Q9t_Whs-bZPqU1Xg@mail.gmail.com>
 <20160129181442.GA30391@dhcp-10-15-1-8.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35707 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbcA2UYm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2016 15:24:42 -0500
Content-Disposition: inline
In-Reply-To: <20160129181442.GA30391@dhcp-10-15-1-8.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, syzkaller <syzkaller@googlegroups.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@redhat.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>

Hello, David.

On Fri, Jan 29, 2016 at 12:14:42PM -0600, David Milburn wrote:
> Can ata_sff_hsm_move grab the lock and save off the task_state,
> like this patch?

It's not just the task_state.  Everything the polling path is doing is
dangerous.  It's all pretty confused.

Thanks.

-- 
tejun
