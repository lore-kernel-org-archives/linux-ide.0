From: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Subject: Re: Via SATA not working here
Date: Tue, 14 Sep 2004 19:54:48 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040914175448.GK18257@uvt316-2.ruk.cuni.cz>
References: <20040912191542.GO21202@uvt316-2.ruk.cuni.cz> <414520BB.3080306@wasp.net.au> <20040914094336.GG18257@uvt316-2.ruk.cuni.cz> <311601c90409140803aaa4d31@mail.gmail.com>
Reply-To: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dec59.ruk.cuni.cz ([195.113.2.17]:56080 "HELO dec59.ruk.cuni.cz")
	by vger.kernel.org with SMTP id S269612AbUINR5F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Sep 2004 13:57:05 -0400
Content-Disposition: inline
In-Reply-To: <311601c90409140803aaa4d31@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Eric Mudama <edmudama@gmail.com>
Cc: Brad Campbell <brad@wasp.net.au>, f@uvt316-2.ruk.cuni.cz, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Tue, Sep 14, 2004 at 09:03:19AM -0600, Eric Mudama wrote:
> On Tue, 14 Sep 2004 11:43:36 +0200, Michal 'hramrach' Suchanek
> <hramrach@centrum.cz> wrote:
> > With 2.6.5 I get the same results.
> > 
> > The libata error message:
> > 
> > ata1: DMA timeout, stat 0x0
> > ATA: abnormal status 0xD0 on prot 0xEC07
> > scsi0: ERROR on channel 0, id0, lin0, CDB: Write (10) 00 01 65 dc e7 00
> > 00 42 00
> > Current sda: sense key Medium Error
> > Additional sense: Write Error - auto reallocation failed
> > end_request: I/O error, dev sda, sector 23452903
> > ATA: abnormal status 0xD0 on prot 0xEC07
> > ATA: abnormal status 0xD0 on prot 0xEC07
> > ATA: abnormal status 0xD0 on prot 0xEC07
> > 
> > Note that the 0xd0 is the same as the ide DMA timeout error.
> 
> Not sure how libata queried the additional sense: key/code/qual etc
> from the drive, since it appears to have gotten a busy timeout.

imho it did not query it, it is simply bogus. afaict the drive does not
produce write errors so the code cannot query it whatever it does.
But i do not know anything about ata or the kernel ata drivers, I did
not even try to look.

Currently I have another drive attached to the sata dongle and neither
bios nor Linux can see it. Perhaps it is because  the drive is switched
to slave or it does not like the drive rack.

Thanks 

Michal Suchanek
