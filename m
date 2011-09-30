From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata: make DVD drive recognisable on systems with Intel
 Sandybridge CPT chipset
Date: Thu, 29 Sep 2011 20:09:13 -0700
Message-ID: <20110930030913.GE10425@mtj.dyndns.org>
References: <1316656512-4829-1-git-send-email-ming.lei@canonical.com>
 <20110924015859.GZ29319@htj.dyndns.org>
 <DEC3922D1904474A8862C7BFF516EA9A16E813AA@ORSMSX101.amr.corp.intel.com>
 <CACVXFVN20XfKab+7SVtT_BCLN0hs-sFHbhTzknF0gNGneERNUg@mail.gmail.com>
 <20110925000345.GD29319@htj.dyndns.org>
 <CACVXFVOo3CYxGJrwi0cZRwx=PWaK16EEuMfN1WDzFFA=TU0AuA@mail.gmail.com>
 <CACVXFVMWn4o3WKznydUqdhfZK2xTQ-+=SFqYtP0J4DzagWphcQ@mail.gmail.com>
 <CACVXFVPR2qA-N2wi6c2ranOLuhRVuQQ5nhdE=4m1hxjW-Z=Ohw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49789 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105Ab1I3DJS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Sep 2011 23:09:18 -0400
Received: by iaqq3 with SMTP id q3so1344660iaq.19
        for <linux-ide@vger.kernel.org>; Thu, 29 Sep 2011 20:09:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACVXFVPR2qA-N2wi6c2ranOLuhRVuQQ5nhdE=4m1hxjW-Z=Ohw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: "Heasley, Seth" <seth.heasley@intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hello,

Sorry about the delay.

On Wed, Sep 28, 2011 at 12:58:25PM +0800, Ming Lei wrote:
> On Mon, Sep 26, 2011 at 3:23 PM, Ming Lei <ming.lei@canonical.com> wrote:
> 
> > How about this one below?

The patch itself looks good but please read on.

> After testing, I found the patch above does not make DVD drive work.
> But plus the below[1], dvd drive starts to working. Since piix_sidpr_sata_ops
> is hardcode in ata_piix.c, looks like it is a bit difficult to figure
> out a clean fix.

Sorry about that.  I forgot that sidpr ops selection was dynamic. :(
Hmmm... it seems we already have dynamic switch to control 32bit PIO -
ATA_PFLAG_PIO32.  How about the following then?

* define PIIX_FLAG_PIO16 and set it in the port_info for SNBs.

* define piix_port_start() which sets PFLAG_PIO32 iff !PIIX_FLAG_PIO16
  and then call ata_bmdma_port_start() and use it in piix_sata_ops.

Thank you.

-- 
tejun
