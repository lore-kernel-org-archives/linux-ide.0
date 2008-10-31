From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2 #upstream-fixes] sata_via: fix support for 5287
Date: Fri, 31 Oct 2008 01:45:38 -0400
Message-ID: <490A9B82.7070704@garzik.org>
References: <48FDF935.6010307@kernel.org> <48FDF95C.8090809@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50927 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbYJaFpo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Oct 2008 01:45:44 -0400
In-Reply-To: <48FDF95C.8090809@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Joseph Chan <JosephChan@via.com.tw>

Tejun Heo wrote:
> 5287 used to be treated as vt6420 but it didn't work.  It's new family
> of controllers called vt8251 which hosts four SATA ports as M/S of the
> two ATA ports.  This configuration is rather peculiar in that although
> the M/S devices are on the same port, each have its own SCR (or
> equivalent link status/control) registers which screws up the
> port-link-device hierarchy assumed by libata.  Another controller
> which falls into this category is ata_piix w/ SIDPR access.
> 
> libata now has facility to deal with this class of controllers named
> slave_link.  A low level driver for such controllers can just call
> ata_slave_link_init() on the respective ports and libata will handle
> all the difficult parts like following up with single SRST after
> hardresetting both ports.
> 
> This patch creates new controller class vt8251, implements slave_link
> aware init sequence and config space based SCR access for it and moves
> 5287 to the new class.
> 
> This patch is based on Joseph Chan's larger patch which was created
> before slave_link was implemented in libata.
> 
>   http://thread.gmane.org/gmane.linux.kernel.commits.mm/40640
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Joseph Chan <JosephChan@via.com.tw>
> ---
>  drivers/ata/sata_via.c |  155 +++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 143 insertions(+), 12 deletions(-)

applied


