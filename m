From: Alan Cox <alan@redhat.com>
Subject: Re: [patch 04/30] ACPI driver support for pata
Date: Tue, 6 Mar 2007 09:29:10 -0500
Message-ID: <20070306142910.GB3732@devserv.devel.redhat.com>
References: <200703061037.l26AbrtB019463@shell0.pdx.osdl.net> <45ED649A.20207@gmail.com> <20070306151415.45db1d52@lxorguk.ukuu.org.uk> <45ED783C.6060604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:32866 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266AbXCFObE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 09:31:04 -0500
Content-Disposition: inline
In-Reply-To: <45ED783C.6060604@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, alan@redhat.com, lenb@kernel.org

On Tue, Mar 06, 2007 at 11:18:36PM +0900, Tejun Heo wrote:
> Actually, I have.  I was thinking of higher level helpers.  e.g.
> pacpi_cable_detect() in libata-acpi.c such that sata_nv's cable_detect
> can do.

There is no cable detect feature in ACPI, you try and set a mode and if it
lets you then the cable is probably there. That means you can't do
"pacpi_cable_detect"  easily as a helper because you will corrupt all the timing
set up so far, and potentially on both drives.

I guess we could carefully set PIO 0 back on both and stick big warning signs
on the function about where to use it.

> So that it's more robust && we don't have to alternate between sata_nv,
> pata_acpi depending on BIOS/kernel configuration, and possibly combine
> other low level features with ACPI support.

Makes sense and its easy to move the code around once you are ready to do so.

