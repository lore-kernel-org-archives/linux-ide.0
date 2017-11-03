From: Taras Kondratiuk <takondra@cisco.com>
Subject: Re: Manual unbind of ATA devices causes use-after-free
Date: Fri, 03 Nov 2017 09:32:16 -0700
Message-ID: <150972673653.5502.7168940193960185267@takondra-t460s>
References: <150957868766.7160.13267337838101258462@takondra-t460s>
 <20171103131937.GQ3252168@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103131937.GQ3252168@devbig577.frc2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, xe-linux-external@cisco.com
List-Id: linux-ide@vger.kernel.org

Quoting Tejun Heo (2017-11-03 06:19:37)
> Hello,
> =

> On Wed, Nov 01, 2017 at 04:24:47PM -0700, Taras Kondratiuk wrote:
> > Manual unbind/remove unconditionally invokes devres_release_all which
> > calls ata_host_release() and frees ata_host/ata_port memory while it is
> > still being referenced (e.g as a parent of SCSI host).
> > =

> > Is there a reason why ata_host is using derves which is not refcounted?
> > Does it make sense to add recounting to ata_host?
> =

> Hmm... the removal path is supposed to drain everything synchronously.
> What kind of controller is it?

It drains synchronously if scsi_host_put(ap->scsi_host) in
ata_host_release() releases the last scsi_host reference. But when the issue
happens there is one more reference to scsi_host because sg device is
still open. The last reference will be dropped from sg_release.

I forgot to mention that the disk may not be clearly unmounted when I'm
unbinding it, but IMO it shouldn't cause use-after-free in the kernel.
Also even if sg_release() is called before ata_host_release() there is
still no guarantee that the last reference will be dropped, because
sg_release() schedules sg_remove_sfp_usercontext() to do actual release
and the work may not be completed in time.

Driver is AHCI PCI.
