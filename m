From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] Remove sync waiting code from libata
Date: Sat, 8 Sep 2007 11:17:31 -0600
Message-ID: <20070908171731.GB6809@parisc-linux.org>
References: <20070907024632.GH27404@parisc-linux.org> <46E259DD.5090609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:40906 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbXIHRRc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 13:17:32 -0400
Content-Disposition: inline
In-Reply-To: <46E259DD.5090609@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Sat, Sep 08, 2007 at 05:14:21PM +0900, Tejun Heo wrote:
> Matthew Wilcox wrote:
> > By using the scsi async probing code, we can remove the 'sync' argument
> > from ata_scsi_scan_host():
> 
> Hmmm... How so?  @sync is there to keep device numbering stable even
> when SCSI scan fails due to allocation failure.  I don't see how async
> probing changes that.

async probing also keeps device numbering stable.  As long as the device
responds within ten seconds (and the current code has half a second as
the timeout), it'll get the same number it would have had, even though
other hosts have successfully completed their probes during that time.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
