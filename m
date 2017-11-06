From: Tejun Heo <tj@kernel.org>
Subject: Re: Manual unbind of ATA devices causes use-after-free
Date: Mon, 6 Nov 2017 07:24:52 -0800
Message-ID: <20171106152452.GA3252168@devbig577.frc2.facebook.com>
References: <150957868766.7160.13267337838101258462@takondra-t460s>
 <20171103131937.GQ3252168@devbig577.frc2.facebook.com>
 <150972673653.5502.7168940193960185267@takondra-t460s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:46203 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbdKFPY4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Nov 2017 10:24:56 -0500
Content-Disposition: inline
In-Reply-To: <150972673653.5502.7168940193960185267@takondra-t460s>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Taras Kondratiuk <takondra@cisco.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, xe-linux-external@cisco.com, Lin Ming <minggr@gmail.com>

Hello,

On Fri, Nov 03, 2017 at 09:32:16AM -0700, Taras Kondratiuk wrote:
> Quoting Tejun Heo (2017-11-03 06:19:37)
> > Hello,
> > 
> > On Wed, Nov 01, 2017 at 04:24:47PM -0700, Taras Kondratiuk wrote:
> > > Manual unbind/remove unconditionally invokes devres_release_all which
> > > calls ata_host_release() and frees ata_host/ata_port memory while it is
> > > still being referenced (e.g as a parent of SCSI host).
> > > 
> > > Is there a reason why ata_host is using derves which is not refcounted?
> > > Does it make sense to add recounting to ata_host?
> > 
> > Hmm... the removal path is supposed to drain everything synchronously.
> > What kind of controller is it?
> 
> It drains synchronously if scsi_host_put(ap->scsi_host) in
> ata_host_release() releases the last scsi_host reference. But when the issue
> happens there is one more reference to scsi_host because sg device is
> still open. The last reference will be dropped from sg_release.

I see.

> I forgot to mention that the disk may not be clearly unmounted when I'm
> unbinding it, but IMO it shouldn't cause use-after-free in the kernel.

Oh, it shouldn't.  It's a bug.

> Also even if sg_release() is called before ata_host_release() there is
> still no guarantee that the last reference will be dropped, because
> sg_release() schedules sg_remove_sfp_usercontext() to do actual release
> and the work may not be completed in time.

Hmmm, we didn't use to put in ata device structs in the kobject tree,
so this wasn't an issue.  This was changed by 9a6d6a2ddabb ("ata: make
ata port as parent device of scsi host") while adding the transport
support.  While doing that, we didn't change the release path to match
it, so the failure.

cc'ing Lin.  Lin, can you take a look at this?

Thanks.

-- 
tejun
