From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata fixes
Date: Tue, 14 Nov 2006 11:41:50 -0500
Message-ID: <4559F1CE.9040805@garzik.org>
References: <20061114150454.GA11900@havoc.gtf.org> <4559EFB2.1000809@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:7363 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966198AbWKNQlx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Nov 2006 11:41:53 -0500
In-Reply-To: <4559EFB2.1000809@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Mark Lord wrote:
> Any time we return 0 from queuecommand, the SCSI mid-layer expects us
> to also take care of invoking the done() function.  Where does this now
> happen for this case (err_mem) ???

It _already_ happened in the error path of ata_scsi_qc_new(), which is 
why this is a double-completion bug fix.

	Jeff


