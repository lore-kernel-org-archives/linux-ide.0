From: John Williams <john@pond-weed.com>
Subject: Re: Failed to set xfermode on LITE-ON  LTR-40125S
Date: Fri, 26 Jan 2007 08:15:38 +0000
Message-ID: <20070126081538.7f4c2c85@buffy.scoobygang>
References: <20070125201750.2adbd57c@buffy.scoobygang>
	<45B97A73.6050703@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from john-and-mon.demon.co.uk ([62.49.18.13]:1844 "EHLO
	pond-weed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030817AbXAZIPp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Jan 2007 03:15:45 -0500
In-Reply-To: <45B97A73.6050703@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Fri, 26 Jan 2007 11:50:11 +0800
Albert Lee <albertcc@tw.ibm.com> wrote:

> John Williams wrote:
> > Hello,
> > 
> > I just tried the libata support for PATA in kernel 2.6.20-rc5 and I got
> > this:
> > 
> > scsi1 : pata_sis
> > ata2.00: ATAPI, max UDMA/66
> > ata2.01: ATAPI, max UDMA/33
> > ata2.00: configured for UDMA/33
> > ata2.01: qc timeout (cmd 0xef)
> > ata2.01: failed to set xfermode (err_mask=0x4)
> > ...
> 
> Tejun fixed the problem by ATA_FLAG_SETXFER_POLLING for pata_via.
> Maybe the same fix works for pata_sis.
> 
> Could you please try the attached patch, thanks.
> --
> albert

Yes, that fixed it.
Thanks,
John
