From: Tejun Heo <htejun@gmail.com>
Subject: updated new EH and hotplug support are about to be posted...
Date: Tue, 11 Apr 2006 22:08:49 +0900
Message-ID: <20060411130849.GA25147@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:58252 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750812AbWDKNIy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:08:54 -0400
Received: by zproxy.gmail.com with SMTP id o37so1085291nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:08:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, axboe@htj.dyndns.org, Albert Lee <albertcc@tw.ibm.com>, Lukasz Kosewski <lkosewsk@gmail.com>, linux-ide@vger.kernel.org

Hello, people.

It's been another looooooong week.  Build number of my ATA work tree,
which was created at the end of Feburary, is now over 1040 and all my
SATA plugs are worn and unplug easily.  But, hey, hotplug works now.

I'm about to post the following 9 patchsets composed of 97 patches.
The first two patchsets have been posted previously but I'll repost
them for simplicity's sake.

1. misc-reset-updates			: repost (3 patches)
2. implement-and-use-ata_wait_register	: repost (5 patches)
3. misc-ata_bus_probe-updates		: take 1 (3 patches)
4. fixes-errata-workaround-and-reset-updates : take 3 (13 patches)
5. new-EH-framework			: take 2 (16 patches)
6. new-EH-implementation		: take 2 (14 patches)
7. add-NCQ-support			: take 3 (15 patches)
8. prep-for-hotplug-support		: take 1 (15 patches)
9. add-hotplug-support			: take 1 (13 patches)

All patchsets are against the current upstream[1] and stacks on the
previous ones.  However, patchsets 5 and upwards depend on the
following SCSI updates.

implement-scsi_eh_schedule patchset [2]
fix-scsi_kill_request-busy-count-handling patch [3]

new-EH-framwork and new-EH-implementation patchsets received a lot of
updates (all recorded in the head message of the patchests).  NCQ
patchset is largely unchanged except other than addition of sata_sil24
support.

Hotplug supports both warm and hot unplug/plug.  More details are on
the head message of add-hotplug-support patchset and inidividual patch
descriptions.

I'm planning on making combined patches against release kernels
(stable kernel and maybe -rc?) such that the whole EH/NCQ/hotplug can
be tested more widely and impatient and living-on-the-cutting-edge
people don't have to wait till these make it to mainline.

Also, if you guys have any major objection or concerns with the
current design and implementation.  Please let me know early as I'm
gonna start working on port multiplier support on top of these very
soon.

Albert, sata_sil-new_interrupt_handler patch in the patchset
add-hotplug-support implements a private interrupt handler for
sata_sil but sata_sil still needs to use PIO support in libata.
Currently it's okay as irq-driven path and PIO path are completely
separate, but to merge with irq-pio branch, we need to separate PIO
HSM from the standard interrupt handler such that LLDD's private
interrupt handler can drive HSM.

Thanks!

--
tejun

[1] c2a6585296009379e0f4eff39cdcb108b457ebf2
[2] http://article.gmane.org/gmane.linux.ide/9290
[3] http://article.gmane.org/gmane.linux.ide/9487
