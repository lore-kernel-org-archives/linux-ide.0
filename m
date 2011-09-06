From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH #upstream-fixes] libata: clear PIO pad area
Date: Tue, 6 Sep 2011 12:16:11 +0100
Message-ID: <20110906121611.007d7537@bob.linux.org.uk>
References: <20110906040905.GD18425@mtj.dyndns.org>
	<4E65F09F.6020508@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:3529 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666Ab1IFLKD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Sep 2011 07:10:03 -0400
In-Reply-To: <4E65F09F.6020508@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, tom.leiming@gmail.com

On Tue, 06 Sep 2011 14:06:23 +0400
Sergei Shtylyov <sshtylyov@mvista.com> wrote:

> Hello.
> 
> On 06-09-2011 8:09, Tejun Heo wrote:
> 
> > ata_sff_data_xfer[32]() use pad area if the transfer size isn't
> > multiple of transfer size; however, this area wasn't cleared and
> > garbage data in pad area could be transferred to the device.  Make
> > sure the pad area is cleared.
> 
> > Signed-off-by: Tejun Heo<tj@kernel.org>
> > Cc: Lei Ming<tom.leiming@gmail.com>
> 
>     And what's the problem with garbage data? Why it's worse than 0s?

It's potentially externally observable on things like an eSATA port so
it probably should be cleared just as we do with network padding.

For the CDB case we clear the rest of the CDB anyway I believe because
some old PATA stuff used to freak if the padding wasn't zero.

