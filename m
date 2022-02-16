Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D652FC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 16 Feb 2022 07:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiBPHM4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:12:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiBPHMz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2022 02:12:55 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70F59BAF5
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 23:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644995554; x=1676531554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CGvzGEO6H0Vv782UdYzwFn2xFK4FwUxx8fKugTOPQL8=;
  b=lgyuhqXvA8dir+Tka0fzHM7auzbDoCUrr3cBq3FOc+UuopKbSQrdHnUB
   Pbcre5RwF7Xn9DrSmatX+a6M6D983r4HPDrr7l+meghtMVOOQ5J1nRZ+9
   DM9YRcvdchaFy4uKlzh53MXrx7yuNWjxWEOgWrnNps7N73J0G3eeHU9ET
   ZOLqi9IDWooQgfLMMAGXZ2PyKzKO7dLrWcAsNFgG6T0KrSfLnZ5W5FLDL
   pH6k1YZ4TMpoeGFpryAsdjXmdGSg6qRszbjnpZ2aFiU6OMA0m5PVxzuL3
   /ZhxP7sabZNF8zbZ/NbMl8/pa1OsuLrx9+4mYmPI9HNHM9Hfxb0X1fJc4
   g==;
X-IronPort-AV: E=Sophos;i="5.88,373,1635177600"; 
   d="scan'208";a="304975253"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 14:37:34 +0800
IronPort-SDR: PF1i+4j6qELu3P1AKhe9J/Jiw+kOLlnF6JPwlUt8iDOIVfex1WARaX0a1PcliHjpSked/JUfMD
 +KOKVxA25duHlGyMNg45K6eeNjuq14+4a7AJRNPWSdtAn7thODxYLTWkZxRt1cJtvOliQHrsHc
 FNitOtXXAtkHKZtVr6hQ1doCtIUjH46lm5usII/RxaYXcqOmlqLXhHXdGrdK9ekL7nKASHmITb
 vxwIOFdpEJdWyS0DCDmCwx8UbdcG1I2pZ5i9Qizf1nm9cFU2E8vFmJTLjnnapt+vTxKV8L6AUV
 7CucySANO0rO6zna+LGmG9aN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 22:10:22 -0800
IronPort-SDR: r9m9ax2YTFLY5+boKHI5dA0uag7/aXHHGJg48aVPvZc56KznGjXc4u6biWsdub384a/H/QucpV
 T4yvTIBjbQSqR7MHGqkyKespAUfpq7rZjvajnrr0AR52gk7reN723CM6taGAfICgnypbhhV71i
 YJpdAHZLb5bLgp0TdZlWYeTNfMYMChmOKz2dL250C5F+sWVqrtSQcV8nRCDDTUL9g9kEUPDRzG
 FL9yhwQQq7m0YDUNO5AxBQazF4Lerber4fXzg+gJU326OxYIE0z0Qux/0r8euWIcdIpCL6quoe
 igs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 22:37:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jz7YT12wWz1SVp4
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 22:37:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644993451; x=1647585452; bh=CGvzGEO6H0Vv782UdYzwFn2xFK4FwUxx8fK
        ugTOPQL8=; b=LCiPWDmy/wDI9DZBJkajNtBqe8X5r+11fnaTaBf8Kbsbq2tUdhe
        gETKJ9RgJ/Xbri5R05zB8BaD9Ft+ponZLq7aIs8vQsV1b1QFZamGODCpBAA/TokJ
        cBqZEvXvZc7Pn7OC1JMxvH8KH+v+K1+/rrG2c9tM/8i8FZwQ9baooRAdmPx7qoq/
        SFZO2XKB1UpA97RQm56x3IVR6ka22Nq8cWVTN7pqaurmVzcIWLykV1aDrS1//maB
        9/3P6U/owNBDKC75Zj6g5pgEQHndXfeaY7GEPpO/qB/NRWDQSq0ioGuNUA2ABrtq
        bUHvu3kOhVquB2kMomuqOfHejGOTqCFXofQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jfeuXeCyabg2 for <linux-ide@vger.kernel.org>;
        Tue, 15 Feb 2022 22:37:31 -0800 (PST)
Received: from [10.225.163.73] (unknown [10.225.163.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jz7YF53xcz1Rwrw;
        Tue, 15 Feb 2022 22:37:21 -0800 (PST)
Message-ID: <94b1cba2-0e78-bbc0-0321-8be70b2b3be2@opensource.wdc.com>
Date:   Wed, 16 Feb 2022 15:37:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Report in ata_scsi_port_error_handler()
Content-Language: en-US
To:     Byungchul Park <byungchul.park@lge.com>, linux-ide@vger.kernel.org
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
References: <1644984747-26706-1-git-send-email-byungchul.park@lge.com>
 <1644984964-28300-1-git-send-email-byungchul.park@lge.com>
 <1644984964-28300-3-git-send-email-byungchul.park@lge.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1644984964-28300-3-git-send-email-byungchul.park@lge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/16/22 13:16, Byungchul Park wrote:
> [    2.051040] ===================================================
> [    2.051406] DEPT: Circular dependency has been detected.
> [    2.051730] 5.17.0-rc1-00014-gcf3441bb2012 #2 Tainted: G        W        
> [    2.051991] ---------------------------------------------------
> [    2.051991] summary
> [    2.051991] ---------------------------------------------------
> [    2.051991] *** DEADLOCK ***
> [    2.051991] 
> [    2.051991] context A
> [    2.051991]     [S] (unknown)(&(&ap->eh_wait_q)->dmap:0)
> [    2.051991]     [W] __raw_spin_lock_irq(&host->lock:0)
> [    2.051991]     [E] event(&(&ap->eh_wait_q)->dmap:0)
> [    2.051991] 
> [    2.051991] context B
> [    2.051991]     [S] __raw_spin_lock_irqsave(&host->lock:0)
> [    2.051991]     [W] wait(&(&ap->eh_wait_q)->dmap:0)
> [    2.051991]     [E] spin_unlock(&host->lock:0)

Sleeping with a spinlock held would be triggering warnings already, so
these reports seem bogus to me.

In any case, trying to make sense of these reports is not easy, to say
the least. If you think there is really a bug, then please send a clear
explanation of your findings rather than a raw tool output that did not
go through human analysis.

> [    2.051991] 
> [    2.051991] [S]: start of the event context
> [    2.051991] [W]: the wait blocked
> [    2.051991] [E]: the event not reachable
> [    2.051991] ---------------------------------------------------
> [    2.051991] context A's detail
> [    2.051991] ---------------------------------------------------
> [    2.051991] context A
> [    2.051991]     [S] (unknown)(&(&ap->eh_wait_q)->dmap:0)
> [    2.051991]     [W] __raw_spin_lock_irq(&host->lock:0)
> [    2.051991]     [E] event(&(&ap->eh_wait_q)->dmap:0)
> [    2.051991] 
> [    2.051991] [S] (unknown)(&(&ap->eh_wait_q)->dmap:0):
> [    2.051991] (N/A)
> [    2.051991] 
> [    2.051991] [W] __raw_spin_lock_irq(&host->lock:0):
> [    2.051991] [<ffffffff8178d355>] ata_sff_flush_pio_task+0x45/0xc0
> [    2.051991] stacktrace:
> [    2.051991]       _raw_spin_lock_irq+0x58/0x90
> [    2.051991]       ata_sff_flush_pio_task+0x45/0xc0
> [    2.051991]       ata_exec_internal_sg+0x422/0x690
> [    2.051991]       ata_do_set_mode+0x5ee/0xac0
> [    2.051991]       ata_set_mode+0xfc/0x110
> [    2.051991]       ata_eh_recover+0x1061/0x1360
> [    2.051991]       ata_do_eh+0x3f/0xa0
> [    2.051991]       ata_scsi_port_error_handler+0x432/0x740
> [    2.051991]       ata_scsi_error+0x94/0xc0
> [    2.051991]       scsi_error_handler+0x8d/0x3a0
> [    2.051991]       kthread+0xe3/0x110
> [    2.051991]       ret_from_fork+0x22/0x30
> [    2.051991] 
> [    2.051991] [E] event(&(&ap->eh_wait_q)->dmap:0):
> [    2.051991] [<ffffffff810baa53>] __wake_up_common+0x93/0x1a0
> [    2.051991] stacktrace:
> [    2.051991]       dept_event+0x12b/0x1f0
> [    2.051991]       __wake_up_common+0xb0/0x1a0
> [    2.051991]       __wake_up_common_lock+0x65/0x90
> [    2.051991]       ata_scsi_port_error_handler+0x67a/0x740
> [    2.051991]       ata_scsi_error+0x94/0xc0
> [    2.051991]       scsi_error_handler+0x8d/0x3a0
> [    2.051991]       kthread+0xe3/0x110
> [    2.051991]       ret_from_fork+0x22/0x30
> [    2.051991] ---------------------------------------------------
> [    2.051991] context B's detail
> [    2.051991] ---------------------------------------------------
> [    2.051991] context B
> [    2.051991]     [S] __raw_spin_lock_irqsave(&host->lock:0)
> [    2.051991]     [W] wait(&(&ap->eh_wait_q)->dmap:0)
> [    2.051991]     [E] spin_unlock(&host->lock:0)
> [    2.051991] 
> [    2.051991] [S] __raw_spin_lock_irqsave(&host->lock:0):
> [    2.051991] [<ffffffff8178047c>] ata_port_wait_eh+0x6c/0xc0
> [    2.051991] stacktrace:
> [    2.051991]       _raw_spin_lock_irqsave+0x82/0xa0
> [    2.051991]       ata_port_wait_eh+0x6c/0xc0
> [    2.051991]       ata_port_probe+0x1f/0x30
> [    2.051991]       async_port_probe+0x27/0x50
> [    2.051991]       async_run_entry_fn+0x21/0xa0
> [    2.051991]       process_one_work+0x317/0x640
> [    2.051991]       worker_thread+0x44/0x410
> [    2.051991]       kthread+0xe3/0x110
> [    2.051991]       ret_from_fork+0x22/0x30
> [    2.051991] 
> [    2.051991] [W] wait(&(&ap->eh_wait_q)->dmap:0):
> [    2.051991] [<ffffffff810bb017>] prepare_to_wait+0x47/0xd0
> [    2.051991] stacktrace:
> [    2.051991]       ata_port_wait_eh+0x52/0xc0
> [    2.051991]       ata_port_probe+0x1f/0x30
> [    2.051991]       async_port_probe+0x27/0x50
> [    2.051991]       async_run_entry_fn+0x21/0xa0
> [    2.051991]       process_one_work+0x317/0x640
> [    2.051991]       worker_thread+0x44/0x410
> [    2.051991]       kthread+0xe3/0x110
> [    2.051991]       ret_from_fork+0x22/0x30
> [    2.051991] 
> [    2.051991] [E] spin_unlock(&host->lock:0):
> [    2.051991] [<ffffffff8178046e>] ata_port_wait_eh+0x5e/0xc0
> [    2.051991] stacktrace:
> [    2.051991]       _raw_spin_unlock_irqrestore+0x35/0x80
> [    2.051991]       ata_port_wait_eh+0x5e/0xc0
> [    2.051991]       ata_port_probe+0x1f/0x30
> [    2.051991]       async_port_probe+0x27/0x50
> [    2.051991]       async_run_entry_fn+0x21/0xa0
> [    2.051991]       process_one_work+0x317/0x640
> [    2.051991]       worker_thread+0x44/0x410
> [    2.051991]       kthread+0xe3/0x110
> [    2.051991]       ret_from_fork+0x22/0x30
> [    2.051991] ---------------------------------------------------
> [    2.051991] information that might be helpful
> [    2.051991] ---------------------------------------------------
> [    2.051991] CPU: 1 PID: 53 Comm: scsi_eh_1 Tainted: G        W         5.17.0-rc1-00014-gcf3441bb2012 #2
> [    2.051991] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> [    2.051991] Call Trace:
> [    2.051991]  <TASK>
> [    2.051991]  dump_stack_lvl+0x44/0x57
> [    2.051991]  print_circle+0x384/0x510
> [    2.051991]  ? print_circle+0x510/0x510
> [    2.051991]  cb_check_dl+0x58/0x60
> [    2.051991]  bfs+0xdc/0x1b0
> [    2.051991]  add_dep+0x94/0x120
> [    2.051991]  do_event.isra.22+0x284/0x300
> [    2.051991]  ? __wake_up_common+0x93/0x1a0
> [    2.051991]  dept_event+0x12b/0x1f0
> [    2.051991]  __wake_up_common+0xb0/0x1a0
> [    2.051991]  __wake_up_common_lock+0x65/0x90
> [    2.051991]  ata_scsi_port_error_handler+0x67a/0x740
> [    2.051991]  ? trace_hardirqs_on+0x38/0xe0
> [    2.051991]  ? scsi_eh_get_sense+0x150/0x150
> [    2.051991]  ata_scsi_error+0x94/0xc0
> [    2.051991]  scsi_error_handler+0x8d/0x3a0
> [    2.051991]  ? _raw_spin_unlock_irqrestore+0x63/0x80
> [    2.051991]  ? scsi_eh_get_sense+0x150/0x150
> [    2.051991]  kthread+0xe3/0x110
> [    2.051991]  ? kthread_complete_and_exit+0x20/0x20
> [    2.051991]  ret_from_fork+0x22/0x30
> [    2.051991]  </TASK>


-- 
Damien Le Moal
Western Digital Research
