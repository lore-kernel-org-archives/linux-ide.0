From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH Linux 2.6.12 00/09] NCQ: generic NCQ completion/error-handling
Date: Fri, 8 Jul 2005 10:03:48 +0200
Message-ID: <20050708080347.GA7050@suse.de>
References: <20050626152105.D86561FB@htj.dyndns.org> <20050627143344.GI11633@suse.de> <20050630073633.GF2243@suse.de> <42C3CEA5.9040509@gmail.com> <20050630152620.GZ2243@suse.de> <20050701002035.GA24878@htj.dyndns.org> <20050701085912.GB2243@suse.de> <20050704055332.GA7249@suse.de> <20050706125500.GA1373@suse.de> <20050706130004.GB1373@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:1964 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262279AbVGHICq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jul 2005 04:02:46 -0400
Content-Disposition: inline
In-Reply-To: <20050706130004.GB1373@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi,

Ok, one more error, this time from irq context:

AHCI: ata1: error irq, status=40000001 stat=51 err=04 sstat=00000113
serr=00000000
ata1: aborting commands due to error.  active_tag -1, sactive 00000001
ahci: sactive 1
ata1: recovering from error
sactive=0
ata1: failed to read log page 10h (-110)
ata1: resetting...
ata1: started resetting...
ata1: end resetting, sstatus=00000113
ata1: status=0x01 { Error }
ata1: error=0x80 { Sector }
SCSI error : <0 0 0 0> return code = 0x8000002
sda: Current: sense key=0x3
    ASC=0x11 ASCQ=0x4
end_request: I/O error, dev sda, sector 2120875
Buffer I/O error on device sda2, logical block 2045
lost page write due to I/O error on sda2

-- 
Jens Axboe

