From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: convert several bmdma-style controllers to new
 EH
Date: Wed, 14 Jun 2006 04:28:25 +0900
Message-ID: <448F11D9.60308@gmail.com>
References: <20060613115131.GA17964@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:12710 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751169AbWFMT21 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 15:28:27 -0400
Received: by py-out-1112.google.com with SMTP id x31so46418pye
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2006 12:28:26 -0700 (PDT)
In-Reply-To: <20060613115131.GA17964@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert sata_sis, svw, uli and vsc drivers to new EH.  All the drivers
> used to specify ATA_FLAG_SATA_RESET to tell libata to use SATA
> hardreset instead of SRST.
> 
> This patch preserves the behavior by defining private error handler
> for each driver which only supports SATA hardreset.  It is likely that
> all these controllers support SRST and can simply use the stock bmdma
> EH.  The private EH methods will be removed after each driver is
> tested w/ the stock bmdma EH.

I forgot ->freeze/thaw.  Please ignore this and the sata_via patch. 
Will repost them.

-- 
tejun
