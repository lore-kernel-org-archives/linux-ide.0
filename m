From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] new Power Management for libata, take 3
Date: Fri, 30 Jun 2006 12:44:17 -0400
Message-ID: <44A554E1.6000601@pobox.com>
References: <11514757842728-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43195 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751416AbWF3Qob (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2006 12:44:31 -0400
In-Reply-To: <11514757842728-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, all.
> 
> This is the third take of new-power-management patchset.  Changes from
> the last take[1] are...
> 
> * Patches #1-7 are merged to #upstream and thus dropped from this
>   patchset.
> 
> * libata-reimplement-controller-wide-PM patch has been reimplemented
>   to include support for ap->port_suspend() and ap->port_resume().

OK, two minor changes, and I'm ready to pull this.

1) Create ap->dflags or similar, for dynamic port flags.  We shouldn't 
waste too much time worrying about port flag bits, since they apparently 
change all the time anyway :)  Just create a second variable for the 
overflow, and start moving flags that drivers never see into there.

2) Ditch patch #3, I think ata_flush_cache() is more appropriate in 
libata-core, in case other users appear.


