From: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Subject: Via SATA already working here [was: not working]
Date: Tue, 14 Sep 2004 22:15:27 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040914201527.GL18257@uvt316-2.ruk.cuni.cz>
References: <20040912191542.GO21202@uvt316-2.ruk.cuni.cz> <414520BB.3080306@wasp.net.au> <20040914094336.GG18257@uvt316-2.ruk.cuni.cz> <311601c90409140803aaa4d31@mail.gmail.com> <20040914175448.GK18257@uvt316-2.ruk.cuni.cz> <4147331A.8040907@pobox.com>
Reply-To: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dec59.ruk.cuni.cz ([195.113.2.17]:35858 "HELO dec59.ruk.cuni.cz")
	by vger.kernel.org with SMTP id S269774AbUINURo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Sep 2004 16:17:44 -0400
Content-Disposition: inline
In-Reply-To: <4147331A.8040907@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Eric Mudama <edmudama@gmail.com>, Brad Campbell <brad@wasp.net.au>, f@uvt316-2.ruk.cuni.cz, linux-ide@vger.kernel.org

On Tue, Sep 14, 2004 at 02:06:18PM -0400, Jeff Garzik wrote:
> Michal 'hramrach' Suchanek wrote:
> >imho it did not query it, it is simply bogus. afaict the drive does not
> >produce write errors so the code cannot query it whatever it does.
> >But i do not know anything about ata or the kernel ata drivers, I did
> >not even try to look.
> >
> >Currently I have another drive attached to the sata dongle and neither
> >bios nor Linux can see it. Perhaps it is because  the drive is switched
> >to slave or it does not like the drive rack.
The drive rack works, just the drive has to be master or cable select.
The weird thing is the driver would report there  is no drive on the
second channel but would not say anything about the first channel where
the drive is connected.
> 
> 
> ahhhhhh, that may be a clue.  If you are attaching a PATA drive via a 
> bridge, that is very different from attaching a SATA drive, in terms of 
> field behavior across the controller spectrum.
> 
> There are limitations on bridges.  Does Brad Campbell's patch (attached) 
> work for you?

Looks great!
I have just compiled my new kernel on the drive connected through sata
using the patched libata driver.

Thanks

Michal Suchanek
