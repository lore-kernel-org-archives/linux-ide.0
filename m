From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2 #upstream-fixes] sata_via: fix support for 5287
Date: Sun, 26 Oct 2008 15:46:29 +0900
Message-ID: <49041245.6070905@kernel.org>
References: <48FDF935.6010307@kernel.org> <48FDF95C.8090809@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51090 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbYJZGqk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Oct 2008 02:46:40 -0400
In-Reply-To: <48FDF95C.8090809@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Joseph Chan <JosephChan@via.com.tw>

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

Jeff, this one should have been titled [PATCH 2/2 #upstream-fixes] and
required for vt5287 support.  This didn't appear on #upstream.  Maybe
you missed it due to the wrong title?

Thanks.

-- 
tejun
