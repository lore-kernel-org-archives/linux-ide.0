From: Alan Cox <alan@redhat.com>
Subject: Re: [KJ][PATCH] SPIN_LOCK_UNLOCKED cleanup in drivers/ata/pata_winbond.c
Date: Wed, 11 Apr 2007 11:38:57 -0400
Message-ID: <20070411153857.GA19968@devserv.devel.redhat.com>
References: <20070411152846.GA11449@arun.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48146 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049AbXDKPjE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Apr 2007 11:39:04 -0400
Content-Disposition: inline
In-Reply-To: <20070411152846.GA11449@arun.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Milind Arun Choudhary <milindchoudhary@gmail.com>
Cc: kernel-janitors@lists.osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, alan@redhat.com

On Wed, Apr 11, 2007 at 08:58:46PM +0530, Milind Arun Choudhary wrote:
> remove SPIN_LOCK_UNLOCKED, use DEFINE_SPINLOCK instead
> 
> Signed-off-by: Milind Arun Choudhary <milindchoudhary@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>
