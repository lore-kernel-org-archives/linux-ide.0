From: Mark Lord <lkml@rtr.ca>
Subject: Re: [git patches] libata fixes
Date: Tue, 14 Nov 2006 13:11:07 -0500
Message-ID: <455A06BB.8020002@rtr.ca>
References: <20061114150454.GA11900@havoc.gtf.org> <4559EFB2.1000809@rtr.ca> <4559F1CE.9040805@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:40203 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S966242AbWKNSLJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Nov 2006 13:11:09 -0500
In-Reply-To: <4559F1CE.9040805@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Any time we return 0 from queuecommand, the SCSI mid-layer expects us
>> to also take care of invoking the done() function.  Where does this now
>> happen for this case (err_mem) ???
> 
> It _already_ happened in the error path of ata_scsi_qc_new(), which is 
> why this is a double-completion bug fix.

Ack. 
