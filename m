From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: ata: BUG in ata_sff_hsm_move
Date: Fri, 29 Jan 2016 12:59:49 +0100
Message-ID: <CACT4Y+Y_w3msrTw46T8wGpK-j09e6VAoPFa93JSfm+5_kvBAYQ@mail.gmail.com>
References: <CACT4Y+b_JsOxJu2EZyEf+mOXORc_zid5V1-pLZSroJVxyWdSpw@mail.gmail.com>
 <20160129115214.GM32380@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160129115214.GM32380@htj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@redhat.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, syzkaller <syzkaller@googlegroups.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: linux-ide@vger.kernel.org

On Fri, Jan 29, 2016 at 12:52 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Dmitry.
>
> On Thu, Jan 28, 2016 at 12:35:43PM +0100, Dmitry Vyukov wrote:
>> Hello,
>>
>> I episodically hit the following BUG while running syzkaller fuzzer:
>>
>> ata2: protocol 2 task_state 0 (dev_stat 0x41)
>> ------------[ cut here ]------------
>> kernel BUG at drivers/ata/libata-sff.c:1302!
> ...
>> So the unexpected state is HSM_IDLE.
>
> Hmmm... the port interrupt handler checks for IDLE before calling into
> hsm_move, so the only explanation would be that something is resetting
> it to IDLE inbetween.  ce7514526742 ("libata: prevent HSM state change
> race between ISR and PIO") describes and fixes the same problem.  The
> fix seems correct and I can't find anywhere else where this can
> happen.  :(
>
> Can you please post the kernel log leading to the BUG?  Also, I don't
> think that condition needs to be BUG.  I'll change it to WARN.

Here are two logs, in both cases no kernel messages prior to the bug:
https://gist.githubusercontent.com/dvyukov/5087d633e3620280b6c7/raw/31c9ab1ced92ac5f85cfb15eaf48ec5793c2c3a1/gistfile1.txt
https://gist.githubusercontent.com/dvyukov/825b2e3d5fb80ae08a9a/raw/03c5a4f4c4bd9d0a304a71cda2da4c92f4b7f1ba/gistfile1.txt
