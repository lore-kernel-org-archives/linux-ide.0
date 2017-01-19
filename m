From: Tejun Heo <tj@kernel.org>
Subject: Re: linux-next 20170117 - lockdep whines and BUGs in
 ata_scsi_rbuf_fill()
Date: Thu, 19 Jan 2017 15:24:32 -0500
Message-ID: <20170119202432.GB25390@mtj.duckdns.org>
References: <21348.1484810915@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <21348.1484810915@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: valdis.kletnieks@vt.edu
Cc: Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Jan 19, 2017 at 02:28:35AM -0500, valdis.kletnieks@vt.edu wrote:
> linux-next 20170110 didn't exhibit this.
> 
> Am seeing at boot a lockdep whine, followed by 3 BUGs. ata_scsi_rbuf_fill() is
> in the traceback for all of them.    'git log' hints that it's one of 6 commits
> against drivers/ata/libata-scsi.c by Christoph, but none of them spring out
> as being the guilty party.  This ring any bells, or should I start
> cherrypicking reverts and bisecting?
> 
> (-dirty due to a local patch to net/ipv6/addrconf.c for a VPN issue)

Reverted the offending commit yesterday.  It should be fine now.

Thanks.

-- 
tejun
