From: Tejun Heo <htejun@gmail.com>
Subject: Re: Panics with libata functions in stack.
Date: Fri, 28 Jul 2006 13:28:43 +0900
Message-ID: <44C9927B.5060706@gmail.com>
References: <20060727180027.GM27144@technolalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:60884 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750760AbWG1E2t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jul 2006 00:28:49 -0400
Received: by py-out-1112.google.com with SMTP id s49so510991pyc
        for <linux-ide@vger.kernel.org>; Thu, 27 Jul 2006 21:28:49 -0700 (PDT)
In-Reply-To: <20060727180027.GM27144@technolalia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicholas Dronen <ndronen@technolalia.com>
Cc: linux-ide@vger.kernel.org

Nicholas Dronen wrote:
> Hi, linux-ide:
> 
> We have a workstation with a dual-core Pentium 4 3.4 Ghz processor that
> started to panic last Friday.  The machine stays up for 15 minutes to
> a few hours, then it panics again.  We suspect a hardware problem, but
> I'd like to ask here whether there's newer libata or other code that
> fixes the panic.
> 
> I've seen two panics since I heard about the problem and the stack trace
> each time has been:
> 
>   Badness in i8042_panic_blink at drivers/input/serio/i8042.c:988
>   i8042_panic_blink +0x188/0x1a0
>   panic +0xc/0x147
>   die +0x164/0x16b
>   vprintk +0x136/0x149
>   do_page_fault +0x0/0x5b6
>   do_page_fault +0x3f0/0x5b6
>   ata_to_sense_error +0x40/0x299 [libata]
>   recalc_task_prio +0x128/0x133
>   activate_task +0x88/0x95
>   try_to_wakeup +0x222/0x22d
>   autoremove_wake_function +0xd/0x2d
>   __wake_up_common +0x36/0x51
>   do_page_fault +0x0/0x5b6
>   error_code + 0x2f/0x38
>   ata_to_sense_error +0x40/0x299 [libata]
>   ata_scsi_qc_complete +0x17/0x2d [libata]
>   ata_qc_complete +0x6b/0x7b [libata]
>   ahci_interrupt +0x100/0x151 [ahci]
>   handle_IRQ_event +0x25/0x4f
>   do_IRQ +0xb0/0x130
>   common_interrupt +0x18/0x20
>   unix_detach_fds +0x2e/0x31
> 
> (Anything confusing about the stack might be due to the fact that I
> wrote it down by hand.)
> 
> The kernel came with RedHat EL 4.0.  Uname -r shows 2.6.9-5.ELsmp.
> In case it's useful, here is output from dmesg.

libata has seen a LOT of updates during last few months.  Can you try 
2.6.17.7 or 2.6.18-rc2?

-- 
tejun
