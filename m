From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Date: Mon, 16 Jan 2006 13:31:12 +0100
Message-ID: <20060116123112.GZ3945@suse.de>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:54562 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750709AbWAPM30 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2006 07:29:26 -0500
Content-Disposition: inline
In-Reply-To: <20060113224252.38d8890f.rdunlap@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>

On Fri, Jan 13 2006, Randy.Dunlap wrote:
> From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Add ata_acpi in Makefile and Kconfig.
> Add ACPI obj_handle.
> Add ata_acpi.c to libata kernel-doc template file.

Randy,

Any chance you can add PATA support as well for this? Many of the
notebooks out there with SATA controllers really have PATA devices
behind a bridge, I think it's pretty much a pre-requisite for this to be
considered complete that this is supported as well. The code should be
the same, it just needs to lookup the right taskfiles. Right now on this
T43, it finds nothing.

-- 
Jens Axboe

