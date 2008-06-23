From: wessels <wessels147@gmail.com>
Subject: Re: SB700 AHCI causes disk power cycle
Date: Mon, 23 Jun 2008 13:52:37 +0200
Message-ID: <a58c5fe70806230452p419de51et1060953af0a2aa6d@mail.gmail.com>
References: <a58c5fe70806221052w7c93b342hdaf44fb27983534a@mail.gmail.com>
	 <485EEE16.1060701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:55934 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbYFWLwo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2008 07:52:44 -0400
Received: by yw-out-2324.google.com with SMTP id 9so876599ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 23 Jun 2008 04:52:39 -0700 (PDT)
In-Reply-To: <485EEE16.1060701@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

> From your report on sb600.
>
> kernel: ata4: SError: { RecovComm Persist PHYRdyChg 10B8B }
> kernel: ata4.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
> kernel:          res 40/00:3c:0d:bd:c9/00:00:0b:00:00/40 Emask 0x10 (ATA bus error)
>
> This combined with the incremented start stop count looks very much
> like the harddisk went offline briefly and came back for whatever
> reason.  I doubt the ahci driver even with its all might can do that.
>
> Can you please try to hook up the faulting harddrive to a separate
> power supply?
>
>  http://modtown.co.uk/mt/article2.php?id=psumod
>
> --
> tejun
>

Thank you for your interest,

I'll test the system with a bigger power supply. But under full load
(cpu, disk and network) these systems consume about 70 watts.
They are powered by either an antec earthwatt 380W or a
seasonic something energy efficient. The antec also powers an opensolaris
server with 7 disks on a sb700 without a problem.
There's one other thing, I did mentioned, the error occurs on both disks.
Although one channel gets more errors than the other. This behaviour is
the same on all three machines.
I'll arrange a couple of seagates to test if it's limited to the
western digital disks.
Currently I'm running the vm's on a nfs share, keep my fingers crossed, no
disk power cycles. But I'll have to test that a bit longer.

I'll be away till next tuesday so please be patient for my results.

Regards,

Wessels
