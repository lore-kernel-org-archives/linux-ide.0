From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] pata_it821x: fix section mismatch warning
Date: Mon, 25 Jun 2007 20:29:30 -0400
Message-ID: <20070626002930.GA30419@devserv.devel.redhat.com>
References: <20070625104222.6bc805e9.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56003 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbXFZA3i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Jun 2007 20:29:38 -0400
Content-Disposition: inline
In-Reply-To: <20070625104222.6bc805e9.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: ide <linux-ide@vger.kernel.org>, alan@redhat.com, jgarzik <jgarzik@pobox.com>, bzolnier@gmail.com

On Mon, Jun 25, 2007 at 10:42:22AM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix section mismatch when CONFIG_HOTPLUG=n (but functions are used
> for resume):
> 
> WARNING: drivers/ata/pata_it821x.o(.text+0x3f): Section mismatch: reference to .init.text: (between 'it821x_reinit_one' and 'it821x_program_udma')
> WARNING: drivers/ata/pata_it821x.o(.text+0x691): Section mismatch: reference to .init.text: (between 'it821x_init_one' and 'it821x_passthru_set_dmamode')
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Acked-by: Alan Cox <alan@redat.com> 
