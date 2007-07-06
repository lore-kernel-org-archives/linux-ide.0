From: Jeff Garzik <jeff@garzik.org>
Subject: Re: + git-libata-all-fix.patch added to -mm tree
Date: Thu, 05 Jul 2007 20:58:21 -0400
Message-ID: <468D93AD.3030409@garzik.org>
References: <200707060041.l660fX3C027811@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52427 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759536AbXGFA6Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jul 2007 20:58:24 -0400
In-Reply-To: <200707060041.l660fX3C027811@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

akpm@linux-foundation.org wrote:
> The patch titled
>      git-libata-all-fix
> has been added to the -mm tree.  Its filename is
>      git-libata-all-fix.patch
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> ------------------------------------------------------
> Subject: git-libata-all-fix
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> drivers/ata/libata-core.c:4253: error: redefinition of 'ata_fill_sg_dumb'
> drivers/ata/libata-core.c:4191: error: previous definition of 'ata_fill_sg_dumb' was here
> drivers/ata/libata-core.c:4375: error: redefinition of 'ata_dumb_qc_prep'
> drivers/ata/libata-core.c:4358: error: previous definition of 'ata_dumb_qc_prep' was here
> 
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/libata-core.c |   79 ------------------------------------
>  1 file changed, 79 deletions(-)

I think Tejun did something similar.

Alas, I only had time to concentrate on 2.6.22-rc before I left for July 
4th.  That left libata-dev.git in a minorly broken state, for everything 
other than #master and #upstream-fixes.  I should have that cleaned up 
in the next day or so.  My apologies.

Whee, bleeding edge...

	Jeff



