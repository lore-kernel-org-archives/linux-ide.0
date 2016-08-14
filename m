From: Oliver Neukum <oneukum@suse.com>
Subject: Re: Regression - SATA disks behind USB ones on v4.8-rc1, breaking
 boot. [Re: Who reordered my disks (probably v4.8-rc1 problem)]
Date: Sun, 14 Aug 2016 16:14:59 +0200
Message-ID: <1471184099.4879.3.camel@suse.com>
References: <20160813190340.GA29989@amd> <20160814092044.GA20392@amd>
	 <CAGnHSEmtgGO5QjfamnN0VPOO2w-4GrZQvPnbkBVdtWBPTnLieA@mail.gmail.com>
	 <20160814100102.GA31847@amd>
	 <CAGnHSEm-Gww1-bmqZMz6guFDnByUuCFiCLhdrK_LETBH3qcb1Q@mail.gmail.com>
	 <CAGnHSEnXo8VRm5Y6S6axpe-hG6an8ceujLajbZmxbGGDnCGh2w@mail.gmail.com>
	 <alpine.DEB.2.02.1608140322400.9045@nftneq.ynat.uz>
	 <CAGnHSEnwQ-sTMnKaZBGD-n2vu83B5nnWTugO9+44oq7dnVOztw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50967 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595AbcHNOTs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Aug 2016 10:19:48 -0400
In-Reply-To: <CAGnHSEnwQ-sTMnKaZBGD-n2vu83B5nnWTugO9+44oq7dnVOztw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: David Lang <david@lang.hm>, james harvey <jamespharvey20@gmail.com>, Tejun Heo <tj@kernel.org>, regressions@leemhuis.info, gregkh@linuxfoundation.org, hdegoede@redhat.com, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org

On Sun, 2016-08-14 at 10:53 +0000, Tom Yan wrote:
> Btw, why hasn't this been CC'd to linux-scsi at the very least? The
> SCSI disk (sd) driver is obviously the sociopath here. It should
> really differentiate disks from libata and usb-storage/uas, and wait
> for at least a minute to see if there's gonna be an ATA drive popping
> up before enumerating disks from the latter. Sociopaths like me that
> put the root filesystem on an UAS drive should really be ignored.
> Wait, there's NVMe! Problem solved.

We most certainly cannot introduce such a delay. If this really
must be done, we need synchronisation primitives between the
subsystemes, or we need stable names in kernel space.

	Regards
		Oliver


