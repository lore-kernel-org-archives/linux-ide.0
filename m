From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/3] libata: Add firmware_default LPM policy
Date: Mon, 11 May 2015 16:28:30 -0400
Message-ID: <20150511202830.GH11388@htj.duckdns.org>
References: <1429370796-5881-1-git-send-email-mjg59@coreos.com>
 <1429370796-5881-3-git-send-email-mjg59@coreos.com>
 <20150422144812.GA10592@htj.duckdns.org>
 <CAPeXnHuSccpYkDRmWO5tKuec2q0WqX7Ktxk_yX9te77xrEe=SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33644 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbbEKU2f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 May 2015 16:28:35 -0400
Content-Disposition: inline
In-Reply-To: <CAPeXnHuSccpYkDRmWO5tKuec2q0WqX7Ktxk_yX9te77xrEe=SA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <matthew.garrett@coreos.com>
Cc: Matthew Garrett <mjg59@coreos.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, kristen@linux.intel.com, sgunderson@bigfoot.com

Hello, Matthew.

On Mon, May 11, 2015 at 01:24:18PM -0700, Matthew Garrett wrote:
> Ok, I've had one person testing this report the following:
> 
> [ 1896.902726] ata1.00: exception Emask 0x0 SAct 0x800 SErr 0x40000 action 0x0
> [ 1896.902735] ata1.00: irq_stat 0x40000008
> [ 1896.902741] ata1: SError: { CommWake }
> [ 1896.902748] ata1.00: failed command: WRITE FPDMA QUEUED
> [ 1896.902758] ata1.00: cmd 61/18:58:88:d5:5d/00:00:0d:00:00/40 tag 11
> ncq 12288 out
>          res 41/04:00:9f:d5:5d/00:00:0d:00:00/40 Emask 0x401 (device error) <F>
> [ 1896.902764] ata1.00: status: { DRDY ERR }
> [ 1896.902768] ata1.00: error: { ABRT }
> [ 1896.912725] ata1.00: supports DRM functions and may not be fully accessible
> [ 1896.932716] ata1.00: supports DRM functions and may not be fully accessible
> [ 1896.942783] ata1.00: configured for UDMA/133
> [ 1896.942815] ata1: EH complete
> 
> which seems to occur in batches. I'm a little confused - isn't it
> legitimate for the phy to report comwake here?

CommWake isn't the problem here.  SError is being dumped just for
information.  The disk is reporting failure on a write command which
is diagnosed as "device error" and thus the link is not reset.  It's
really the device actively reporting command failure.

Thanks.

-- 
tejun
