From: Bas Bloemsaat <bas.bloemsaat@gmail.com>
Subject: Re: SATA_SX4: data corruption with simultaneous writes
Date: Wed, 29 Dec 2004 09:31:07 +0100
Message-ID: <7c4668e5041229003166ebfc2e@mail.gmail.com>
References: <20041228134745.GA13912@solarsystems.de>
Reply-To: Bas Bloemsaat <bas.bloemsaat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.194]:65350 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261352AbUL2IbH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Dec 2004 03:31:07 -0500
Received: by rproxy.gmail.com with SMTP id y7so204240rne
        for <linux-ide@vger.kernel.org>; Wed, 29 Dec 2004 00:31:07 -0800 (PST)
In-Reply-To: <20041228134745.GA13912@solarsystems.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

FWIW, we've experienced similar problems with software raid systems on
this controller.

In two machines, with 4 and 3 disks connected to the controllers, WD
Raptors, 36.7GB. Tested both ReiserFS (which I unjustly blamed at
first) and ext3. Kernels 2.6.7-2.6.9

Funny thing (or not so funny actually) was that after a while the when
/dev/md0 (sdb-c-d-e) got stressed bad enough fs corruption got worse
and even kernel panics would occur. That's strange, because the system
disk was on /dev/sda, which was not even on that controller. But this
was only when stressed, so it strikes me as related to the parent
call.

Anyway, the specs of these machines were pretty similar to
Christian's. P4 (2.8 and 3.2) on intel boards (D865GBFL I believe).
1GB mem in each machine.

I haven't been able to dive into this, as the machines are at work
and, well, working now. Without the disks on those controllers, that
is.

On Tue, 28 Dec 2004 14:47:45 +0100, Christian Vogel
<chris@solarsystems.de> wrote:
> I want to report data corruption that is happening here with a
> promise sx4 SATA controller during simultaneous writes to four connected
> disks, using kernel 2.6.9.
> 

*snip*
