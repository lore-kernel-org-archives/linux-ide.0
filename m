From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/13] libata: fix handling of race between timeout and
 completion
Date: Thu, 26 Jan 2006 22:55:59 -0500
Message-ID: <43D999CF.7020707@pobox.com>
References: <11379893774038-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:3514 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750802AbWA0D4D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 22:56:03 -0500
In-Reply-To: <11379893774038-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> If a qc completes after SCSI timer expires but before libata EH kicks
> in, the qc gets completed but the scsicmd still gets passed to libata
> EH resulting in ->eng_timeout invocation with NULL qc.  Currently none
> of ->eng_timeout callbacks handles this properly.  This patch makes
> ata_scsi_error() bypass ->eng_timeout and handle this rare case.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Doesn't look right to me.  If the qc gets completed, then the SCSI 
command should have also been completed.

AFAICS the race is this:  if the qc is completed, then there is no 
active tag, so ata_qc_from_tag() correctly returns NULL.  This case is 
really an "error has already been handled" case.  It looks really wrong 
to even touch a scsicmd.  I would just clear the eh_cmd list and be done 
with it.

	Jeff


