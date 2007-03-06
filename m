From: Dave Dillow <dave@thedillows.org>
Subject: Re: [PATCH, RFT, v2] sata_mv: convert to new EH
Date: Tue, 06 Mar 2007 01:57:41 -0500
Message-ID: <1173164261.3416.15.camel@obelisk.thedillows.org>
References: <20070225233454.GA31282@havoc.gtf.org>
	 <1173158201.3416.8.camel@obelisk.thedillows.org>
	 <45ED039E.20608@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.knology.net ([24.214.63.101]:45228 "EHLO smtp.knology.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965817AbXCFG5o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 01:57:44 -0500
In-Reply-To: <45ED039E.20608@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Tue, 2007-03-06 at 01:01 -0500, Jeff Garzik wrote:
> Dave Dillow wrote:
> > BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> > BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> > BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
> > BUG: at drivers/ata/sata_mv.c:1245 mv_qc_issue()
[snip]
> Does the attached patch fix things?  It should apply on top of 
> linux-2.6.git upstream, or libata-dev.git#mv-eh.  This patch merely 
> reverts commit e728eabea110da90e69c05855e3a11174edb77ef.

Nope, heaps of BUG: at drivers/ata/sata_mv.c:1241 mv_qc_issue()

Mainline 2.6.21-rc2 survives moving 4GB around, and reading 30GB or so,
but I've not tried anything too stressful yet. I'll leave it up for a
bit on that for testing.

On 2.6.20-rc6, I started getting errors like

sd 1:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdb, sector 6295
sd 0:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sda, sector 6439

repeating in the logs (with different sectors), and I couldn't get the
drives to come back without a reboot. Unfortunately, I cannot find the
logs for the boot and the first set of errors, so this is fairly useless
now.

I'll just leave 2.6.21-rc2 up overnight and see how it goes.

Dave
