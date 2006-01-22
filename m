From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] libata: various fixes related to EH
Date: Sun, 22 Jan 2006 04:10:42 -0500
Message-ID: <43D34C12.6050108@pobox.com>
References: <11379167103055-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:10726 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932236AbWAVJKw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 04:10:52 -0500
In-Reply-To: <11379167103055-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> Hello, Jeff, Albert.
> 
> This patchset is composed of 12 patches fixing/updating various EH
> related stuff in libata.  Although not all of the patches are
> logically related, they need to be ordered because they modify
> similar parts of code.
> 
> #01	: cosmetic
> #02	: ata_qc_new/free model
> #03	: ata_qc_issue() error handling fix
> #04	: detailed AC_ERR_* flags
> #05	: return AC_ERR_* from issue functions
> #06-07	: ata_eh_qc_retry/complete
> #08-12	: eh synchronization (#12 is the pio/eh sync patch I talked
> 	  about in the thread "update timer for PIO polling - revised")
> 
> Jeff, these are hopefully more acceptable patches from my recent EH
> work.  I'll soon follow up with more pervasive patches.  My working
> version of new EH now does most things described in ATA EH doc
> including reset, revalidation and gearing down.  I've also ported
> Jen's NCQ support over it, and, although it has a few issues, it's
> generally working okay.

At first glance, all 12 patches look pretty good.  Definitely moving in 
the right direction, though I noticed a few things.  Comments will follow...

	Jeff



