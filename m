From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: add support for ATA_16 on ATAPI
Date: Tue, 20 Mar 2007 00:32:51 +0900
Message-ID: <45FEAD23.7060101@gmail.com>
References: <45FA8E96.20909@rtr.ca> <45FE11CB.5020500@gmail.com> <45FEAC6D.2050100@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:29135 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965889AbXCSPc4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 11:32:56 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1308328wxd
        for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 08:32:56 -0700 (PDT)
In-Reply-To: <45FEAC6D.2050100@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> Here it is again, without the two extraneous spaces.
> 
> This patch adds support for issuing ATA_16 passthru commands
> to ATAPI devices managed by libata.  It requires the previous
> CDB length fix patch.
> 
> A boot/module parameter, "ata16_passthru=1" can be used to
> globally disable this feature, if ever desired.
> 
> Signed-Off-By: Mark Lord <mlord@pobox.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
