From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [QUESTION] in ata_scsi_pass_thru()
Date: Thu, 01 Dec 2005 20:59:42 -0500
Message-ID: <438FAA8E.9010502@pobox.com>
References: <438D5742.3000804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:25053 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964779AbVLBB7t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Dec 2005 20:59:49 -0500
In-Reply-To: <438D5742.3000804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: russb@emc.com, Linux-ide <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hi, all.
> 
> In the translation function ata_scsi_pass_thru(), when it determines 
> that the command cannot be translated and should be finished early, it 
> does NOT set sense data or result code.  This seems buggy.  Is this 
> intentional?

Yes, a bug.

	Jeff



