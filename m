From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-eh: call freeze hook before port abort
Date: Tue, 07 Apr 2009 15:58:08 -0700
Message-ID: <49DBDA80.2020204@gmail.com>
References: <49DBC7F1.3040801@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:57933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbZDGW5d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 18:57:33 -0400
Received: by ti-out-0910.google.com with SMTP id i7so2567575tid.23
        for <linux-ide@vger.kernel.org>; Tue, 07 Apr 2009 15:57:31 -0700 (PDT)
In-Reply-To: <49DBC7F1.3040801@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>

Hello,

Jeff Garzik wrote:
> This patch looks like it might work for !PMP setups, but I am not so
> sure about PMP.

Looks good to me too.  PMP shouldn't make any difference if the port
is being frozen.  The new behavior is more correct.

> Any comments?  This should help begin addressing the problem where
> hardware needs the DMA engine turned off before accessing the
> taskfile registers -- something needed for ata_port_abort() via
> ata_qc_complete().

Yeah, if this can work around the reported problem, I think this is
the correct way to fix it.

Thanks.

-- 
tejun
