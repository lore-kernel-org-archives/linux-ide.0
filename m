From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA Shutdown issue confuses (sda)
Date: Thu, 29 Nov 2007 11:23:50 +0900
Message-ID: <474E22B6.2020304@gmail.com>
References: <21360.16619.qm@web56311.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:16016 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758174AbXK2CX4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 21:23:56 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2016106wah
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 18:23:56 -0800 (PST)
In-Reply-To: <21360.16619.qm@web56311.mail.re3.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dark Sylinc <dark_sylinc@yahoo.com.ar>
Cc: linux-ide@vger.kernel.org, hmh@debian.org

Dark Sylinc wrote:
> So you're saying:
> 1) Don't spin down to avoid the problem

Yes.

> 2) Flush cache solves the problem

No.

> I'm seeing:
> 1) The hdd is not spun down by shutdown and the
> problem persists
> 2) By spinning down /dev/sdX in shutdown(8) the
> problem disappears. Flush cache doesn't seem to
> influence the emergency shutdown problem.
> 
> That's why I'm confused.
> May be I've missed something in the code.

If I and you are looking at the same patch, you're misreading the
patch.  From the patch description...

 I'm attaching a patch that fixes it. It basically follows
 http://linux-ata.org/shutdown.html and *SKIPS* the drive shutdown when
 the respective /sys/block/sdX/device/scsi_disk:*/manage_start_stop
 exists (leaving it for the kernel to do).

>> So, the patch isn't in the package yet?
> 
> I checked yesterday both Debian's unstable and
> testing, and the patch wasn't there.

Eeeeekk....

-- 
tejun
