From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH Linux 2.6.12 00/09] NCQ: generic NCQ completion/error-handling
Date: Mon, 4 Jul 2005 07:53:37 +0200
Message-ID: <20050704055332.GA7249@suse.de>
References: <20050626152105.D86561FB@htj.dyndns.org> <20050627143344.GI11633@suse.de> <20050630073633.GF2243@suse.de> <42C3CEA5.9040509@gmail.com> <20050630152620.GZ2243@suse.de> <20050701002035.GA24878@htj.dyndns.org> <20050701085912.GB2243@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:6045 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261425AbVGDFwN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jul 2005 01:52:13 -0400
Content-Disposition: inline
In-Reply-To: <20050701085912.GB2243@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Fri, Jul 01 2005, Jens Axboe wrote:
> >  I converted most of debug messages I've used during development into
> > warning messages when posting the patchset and forgot about it, so
> > I've never posted the debug patch.  Sorry about that.  Here's a small
> > patch which adds some more messages though.  The following patch also
> > adds printk'ing FIS on each command issue in ahci.c:ahci_qc_issue(),
> > if you think it would fill your log excessively, feel free to turn it
> > off.  It wouldn't probably matter anyway.
> 
> I will have to kill the issue part of the patch, that would generate
> insane amounts of printk traffic :-)
> 
> I'll boot the kernel and report what happens.

It triggered last night, but the old kernel was booted. This was the
log:

ahci ata1: stat=d0, issuing COMRESET
ata1: recovering from error
ata1: status=0x01 { Error }
ata1: error=0x80 { Sector }
SCSI error : <0 0 0 0> return code = 0x8000002
sda: Current: sense key=0x3
    ASC=0x11 ASCQ=0x4
end_request: I/O error, dev sda, sector 66255899
Buffer I/O error on device sda2, logical block 8018923
lost page write due to I/O error on sda2
ata1: status=0x01 { Error }
ata1: error=0x80 { Sector }
SCSI error : <0 0 0 0> return code = 0x8000002
sda: Current: sense key=0x3
    ASC=0x11 ASCQ=0x4
end_request: I/O error, dev sda, sector 66239043
Buffer I/O error on device sda2, logical block 8016816
lost page write due to I/O error on sda2
ata1: recovering from error
ata1: status=0x01 { Error }
ata1: error=0x80 { Sector }
SCSI error : <0 0 0 0> return code = 0x8000002
sda: Current: sense key=0x3
    ASC=0x11 ASCQ=0x4
end_request: I/O error, dev sda, sector 66239051
Buffer I/O error on device sda2, logical block 8016817
lost page write due to I/O error on sda2
ata1: status=0x01 { Error }
ata1: error=0x80 { Sector }
SCSI error : <0 0 0 0> return code = 0x8000002
sda: Current: sense key=0x3
    ASC=0x11 ASCQ=0x4
end_request: I/O error, dev sda, sector 35137043

Which just continues. I'll boot the right kernel now. I removed the
reset dependency on the read_log_page() issue, I'm suspecting we still
need that to kick start the drive after an error.

-- 
Jens Axboe

