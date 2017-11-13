From: Taras Kondratiuk <takondra@cisco.com>
Subject: Re: Manual unbind of ATA devices causes use-after-free
Date: Mon, 13 Nov 2017 12:09:27 -0800
Message-ID: <151060376750.7561.9196983678072496472@takondra-t460s>
References: <150957868766.7160.13267337838101258462@takondra-t460s>
 <20171103131937.GQ3252168@devbig577.frc2.facebook.com>
 <150972673653.5502.7168940193960185267@takondra-t460s>
 <20171106152452.GA3252168@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:18308 "EHLO
        rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbdKMUJ3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Nov 2017 15:09:29 -0500
In-Reply-To: <20171106152452.GA3252168@devbig577.frc2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, xe-linux-external@cisco.com, Lin Ming <minggr@gmail.com>

Hi Lin,

Quoting Tejun Heo (2017-11-06 07:24:52)
> Hello,
> =

> On Fri, Nov 03, 2017 at 09:32:16AM -0700, Taras Kondratiuk wrote:
> > Also even if sg_release() is called before ata_host_release() there is
> > still no guarantee that the last reference will be dropped, because
> > sg_release() schedules sg_remove_sfp_usercontext() to do actual release
> > and the work may not be completed in time.
> =

> Hmmm, we didn't use to put in ata device structs in the kobject tree,
> so this wasn't an issue.  This was changed by 9a6d6a2ddabb ("ata: make
> ata port as parent device of scsi host") while adding the transport
> support.  While doing that, we didn't change the release path to match
> it, so the failure.
> =

> cc'ing Lin.  Lin, can you take a look at this?

I'm ready to test whenever you have something. If you don't have time to
look at this then can you recommend a proper way to fix it. Is it better
to change device hierarchy back to previous state (revert 9a6d6a2ddabb)
or add reference counting to ata_host?
