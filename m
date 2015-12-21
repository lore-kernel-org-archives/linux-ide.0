From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Mon, 21 Dec 2015 15:24:23 +0000
Message-ID: <yw1xh9jb6d08.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<yw1xwpsa8j2x.fsf@unicorn.mansr.com> <56758F33.20804@candw.ms>
	<yw1xsi2y8ifa.fsf@unicorn.mansr.com> <5675A84F.2070208@candw.ms>
	<yw1xio3u8dgc.fsf@unicorn.mansr.com> <5675BB2F.6060107@candw.ms>
	<CAHp75VdVStVWpucOVkoZHkR3zz034LvRJMQpJk-eLhoA8pjGFg@mail.gmail.com>
	<yw1xegei893o.fsf@unicorn.mansr.com> <5675C452.2080206@candw.ms>
	<yw1xy4cp6o4o.fsf@unicorn.mansr.com> <5676E906.1060603@candw.ms>
	<yw1xpoy16jlt.fsf@unicorn.mansr.com>
	<CAHp75Vedczfn7B-tOEVZi2dOExW8FiAGGA7iTkpuC2wBrsK68g@mail.gmail.com>
	<yw1xa8p47h3w.fsf@unicorn.mansr.com>
	<CAHp75VeT6ZssxiD-c3SqZgAcL5vFuvv4H5AVPz8sypuGkuvqRg@mail.gmail.com>
	<5677D447.40906@candw.ms> <yw1xsi2w574t.fsf@unicorn.mansr.com>
	<5677FC31.1030305@candw.ms> <yw1xlh8o53zh.fsf@unicorn.mansr.com>
	<56780F42.2020907@candw.ms>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:54045 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbbLUPYc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Dec 2015 10:24:32 -0500
In-Reply-To: <56780F42.2020907@candw.ms> (Julian Margetson's message of "Mon,
	21 Dec 2015 10:40:02 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Viresh Kumar <viresh.linux@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Julian Margetson <runaway@candw.ms> writes:

> On 12/21/2015 9:24 AM, Måns Rullgård wrote:
>> Julian Margetson <runaway@candw.ms> writes:
>>
>>>>>> P.S. Anyway we have to ask Julian to try the kernel with
>>>>>> 8b3444852a2b58129 reverted.
>>>>>>
>>>>> git revert 8b3444852a2b58129
>>>>> error: could not revert 8b34448... sata_dwc_460ex: move to generic DMA driver
>>>>> hint: after resolving the conflicts, mark the corrected paths
>>>>> hint: with 'git add <paths>' or 'git rm <paths>'
>>>>> hint: and commit the result with 'git commit'
>>>> Yeah, that won't work since there are numerous changes afterward.  Just
>>>> revert the entire file back to 4.0 like this:
>>>>
>>>> $ git checkout v4.0 drivers/ata/sata_dwc_460ex.c
>>>>
>>>   CC [M]  drivers/ata/sata_dwc_460ex.o
>>> drivers/ata/sata_dwc_460ex.c:467:36: error: macro
>>> "dma_request_channel" requires 3 arguments, but only 1 given
>>>   static int dma_request_channel(void)
>>>                                      ^
>>> drivers/ata/sata_dwc_460ex.c:468:1: error: expected â€˜=â€™, â€˜,â€™,
>>> â€˜;â€™, â€˜asmâ€™ or â€˜__attribute__â€™ before â€˜{â€™ token
>>>   {
>>>   ^
>>> drivers/ata/sata_dwc_460ex.c: In function â€˜dma_dwc_xfer_setupâ€™:
>>> drivers/ata/sata_dwc_460ex.c:758:31: error: macro
>>> "dma_request_channel" requires 3 arguments, but only 1 given
>>>    dma_ch = dma_request_channel();
>>>                                 ^
>>> drivers/ata/sata_dwc_460ex.c:758:11: error: â€˜dma_request_channelâ€™
>>> undeclared (first use in this function)
>>>    dma_ch = dma_request_channel();
>>>             ^
>>> drivers/ata/sata_dwc_460ex.c:758:11: note: each undeclared identifier
>>> is reported only once for each function it appears in
>>> drivers/ata/sata_dwc_460ex.c: In function â€˜sata_dwc_dma_filterâ€™:
>>> drivers/ata/sata_dwc_460ex.c:1282:35: error: â€˜struct
>>> sata_dwc_device_portâ€™ has no member named â€˜dwsâ€™
>>>    struct dw_dma_slave *dws = hsdevp->dws;
>>>                                     ^
>>> drivers/ata/sata_dwc_460ex.c: In function â€˜sata_dwc_port_startâ€™:
>>> drivers/ata/sata_dwc_460ex.c:1325:17: warning: unused variable
>>> â€˜maskâ€™ [-Wunused-variable]
>>>    dma_cap_mask_t mask;
>>>                   ^
>>> drivers/ata/sata_dwc_460ex.c: At top level:
>>> drivers/ata/sata_dwc_460ex.c:345:28: warning: â€˜sata_dwc_dma_dwsâ€™
>>> defined but not used [-Wunused-variable]
>>>   static struct dw_dma_slave sata_dwc_dma_dws = {
>>>                              ^
>>> drivers/ata/sata_dwc_460ex.c:1279:13: warning:
>>> â€˜sata_dwc_dma_filterâ€™ defined but not used [-Wunused-function]
>>>   static bool sata_dwc_dma_filter(struct dma_chan *chan, void *param)
>>>               ^
>> Those messages do not match the contents of the file from v4.0.
>> For your convenience, here's the file as it should be.
>>
>> $ sha1sum drivers/ata/sata_dwc_460ex.c
>> 0f54dfa3a91591101f5de434c3a631a5cd20ff1a  drivers/ata/sata_dwc_460ex.c
>
> [   16.119186] BUG: spinlock recursion on CPU#0, kworker/u2:1/85
> [   16.124935]  lock: 0xedd2f910, .magic: dead4ead, .owner: kworker/u2:1/85, .owner_cpu: 0
> [   16.132947] CPU: 0 PID: 85 Comm: kworker/u2:1 Not tainted 4.4.0-rc5-Sam460ex-dirty #3
> [   16.140793] Workqueue: events_unbound async_run_entry_fn
> [   16.146119] Call Trace:
> [   16.148582] [ee3cf8c0] [c0049238] do_raw_spin_lock+0x4c/0x100 (unreliable)
> [   16.155491] [ee3cf8e0] [c068af98] _raw_spin_lock_irqsave+0x2c/0x38
> [   16.161721] [ee3cf8f0] [f6a0fd98] sata_dwc_exec_command_by_tag.constprop.9+0x80/0xb4 [sata_dwc_460ex]
> [   16.170954] [ee3cf920] [f6a108c0] sata_dwc_qc_issue+0x6a4/0x6c4 [sata_dwc_460ex]
> [   16.178380] [ee3cf9d0] [c043bdf8] ata_qc_issue+0x338/0x3a0
> [   16.183883] [ee3cfa00] [c0440c84] ata_scsi_translate+0xf4/0x150
> [   16.189813] [ee3cfa20] [c0444080] ata_scsi_queuecmd+0x1e8/0x238
> [   16.195750] [ee3cfa40] [c042511c] scsi_dispatch_cmd+0xd4/0x110
> [   16.201602] [ee3cfa50] [c0427a9c] scsi_request_fn+0x52c/0x55c

Oh, that one again.  My patch still applies.  Here it is as applied to
that revision of the file.

>From what I can tell, that bug has always been there.  Probably nobody
ever tested the driver in a PREEMPT or SMP build, nor with lock
debugging enabled.

-- 
Måns Rullgård

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-ata-sata_dwc_460ex-remove-incorrect-locking.patch

>From 53f3cf096f959a58fe6339f4f8b57b6e749b283e Mon Sep 17 00:00:00 2001
From: Mans Rullgard <mans@mansr.com>
Date: Sat, 19 Dec 2015 15:26:23 +0000
Subject: [PATCH] ata: sata_dwc_460ex: remove incorrect locking

This lock is already taken in ata_scsi_queuecmd() a few levels up the
call stack so attempting to take it here is an error.  Moreover, it is
pointless in the first place since it only protects a single, atomic
assignment.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index fdb0f28..d404af8 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1403,15 +1403,13 @@ static void sata_dwc_exec_command_by_tag(struct ata_port *ap,
 					 struct ata_taskfile *tf,
 					 u8 tag, u32 cmd_issued)
 {
-	unsigned long flags;
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
 
 	dev_dbg(ap->dev, "%s cmd(0x%02x): %s tag=%d\n", __func__, tf->command,
 		ata_get_cmd_descript(tf->command), tag);
 
-	spin_lock_irqsave(&ap->host->lock, flags);
 	hsdevp->cmd_issued[tag] = cmd_issued;
-	spin_unlock_irqrestore(&ap->host->lock, flags);
+
 	/*
 	 * Clear SError before executing a new command.
 	 * sata_dwc_scr_write and read can not be used here. Clearing the PM
-- 
2.6.3


--=-=-=--
