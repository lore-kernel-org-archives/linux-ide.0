From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: restore pci_intx() handling
Date: Thu, 17 Sep 2009 16:49:56 -0400
Message-ID: <4AB2A0F4.6010301@garzik.org>
References: <4AB1058F.3070108@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50793 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752978AbZIQUt4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Sep 2009 16:49:56 -0400
In-Reply-To: <4AB1058F.3070108@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org, Thomas Jarosch <thomas.jarosch@intra2net.com>

On 09/16/2009 11:34 AM, Tejun Heo wrote:
> Commit a5bfc4714b3f01365aef89a92673f2ceb1ccf246 dropped explicit
> pci_intx() manipulation from ahci because it seemed unnecessary and
> ahci doesn't seem to be the right place to be tweaking it if it were.
> This was largely okay but there are exceptions.  There was one on an
> embedded platform which was fixed via firmware and now bko#14124
> reports it on a HP DL320.
>
>    http://bugzilla.kernel.org/show_bug.cgi?id=14124
>
> I still think this isn't something libata drivers should be caring
> about (the only ones which are calling pci_intx() explicitly are
> libata ones and one other driver) but for now reverting the change
> seems to be the right thing to do.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Thomas Jarosch<thomas.jarosch@intra2net.com>
> ---
>   drivers/ata/ahci.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

applied


