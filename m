From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Add ata_piix's own resume function
Date: Sat, 27 May 2006 01:05:34 +0200
Message-ID: <20060526230534.GA3640@suse.de>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:11631 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751677AbWEZXFx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 19:05:53 -0400
Content-Disposition: inline
In-Reply-To: <1148634262.2310.7.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Fri, May 26 2006, zhao, forrest wrote:
> For ata_piix resume operation, it first waits for BUSY bit clear,
> then calls ata_device_resume().

This has the problem that it introduces scsi specific knowledge into
ata_piix, something that is both a violation and a problem because we
are moving libata away from scsi. I think the best way to currently do
this is to introduce a ata_port_ops hook (pre_resume()?) that waits for
busy clear and gets called in ata_device_resume is probably the way to
go.

-- 
Jens Axboe

