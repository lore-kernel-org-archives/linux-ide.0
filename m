From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: add support for ATA_16 on ATAPI
Date: Mon, 19 Mar 2007 13:30:03 +0900
Message-ID: <45FE11CB.5020500@gmail.com>
References: <45FA8E96.20909@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:8058 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbXCSEaJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 00:30:09 -0400
Received: by wr-out-0506.google.com with SMTP id 41so1274013wry
        for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 21:30:08 -0700 (PDT)
In-Reply-To: <45FA8E96.20909@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> (many months and hours of wasted effort later, still resending..)
> 
> This patch adds support for issuing ATA_16 passthru commands
> to ATAPI devices managed by libata.  It requires the previous
> CDB length fix patch.
> 
> A boot/module parameter, "ata16_passthru=1" can be used to
> globally disable this feature, if ever desired.
> 
> Signed-Off-By: Mark Lord <mlord@pobox.com> ---

It applies with some warnings.

Adds trailing whitespace.
.dotest/patch:47: 
Space in indent is followed by a tab.
.dotest/patch:49:               DPRINTK("bad CDB len=%u, max=%u\n",
Space in indent is followed by a tab.
.dotest/patch:50:                       scmd->cmd_len, max_len);

Other than that.

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
