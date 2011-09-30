From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata: make DVD drive recognisable on systems with Intel
 Sandybridge CPT chipset
Date: Fri, 30 Sep 2011 16:42:09 -0700
Message-ID: <20110930234209.GC2658@mtj.dyndns.org>
References: <1316656512-4829-1-git-send-email-ming.lei@canonical.com>
 <20110924015859.GZ29319@htj.dyndns.org>
 <DEC3922D1904474A8862C7BFF516EA9A16E813AA@ORSMSX101.amr.corp.intel.com>
 <CACVXFVN20XfKab+7SVtT_BCLN0hs-sFHbhTzknF0gNGneERNUg@mail.gmail.com>
 <20110925000345.GD29319@htj.dyndns.org>
 <CACVXFVOo3CYxGJrwi0cZRwx=PWaK16EEuMfN1WDzFFA=TU0AuA@mail.gmail.com>
 <CACVXFVMWn4o3WKznydUqdhfZK2xTQ-+=SFqYtP0J4DzagWphcQ@mail.gmail.com>
 <CACVXFVPR2qA-N2wi6c2ranOLuhRVuQQ5nhdE=4m1hxjW-Z=Ohw@mail.gmail.com>
 <20110930030913.GE10425@mtj.dyndns.org>
 <CACVXFVPf2opHpR=03iWo4-fOn-UTswUPEqY=v8pbu8hdQY8Y6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45116 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab1I3XmN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2011 19:42:13 -0400
Received: by iaqq3 with SMTP id q3so2296973iaq.19
        for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2011 16:42:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACVXFVPf2opHpR=03iWo4-fOn-UTswUPEqY=v8pbu8hdQY8Y6Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: "Heasley, Seth" <seth.heasley@intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hello,

On Fri, Sep 30, 2011 at 04:39:27PM +0800, Ming Lei wrote:
> On Fri, Sep 30, 2011 at 11:09 AM, Tejun Heo <htejun@gmail.com> wrote:
> Looks It is really a nice and clean idea to fix the problem, follows
> the patch, which
> has been tested OK to recognize DVD in machine with device ID 0x1c00
> chipset.
> 
> Seth, could you help to test the patch on your machines with other pci device
> IDs(0x1c01, 0x1d00, 0x1e00, 0x1e01)?

Yeah, looks good to me.  Please feel free to add

  Acked-by: Tejun Heo <tj@kernel.org>

Thank you.

-- 
tejun
