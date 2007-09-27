From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Update the blacklist with a few more devices
Date: Thu, 27 Sep 2007 09:45:27 +0900
Message-ID: <46FAFD27.7010107@gmail.com>
References: <20070920152247.172420f1@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:17118 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbXI0ETN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 00:19:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3027052wah
        for <linux-ide@vger.kernel.org>; Wed, 26 Sep 2007 21:19:12 -0700 (PDT)
In-Reply-To: <20070920152247.172420f1@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org, akpm@osdl.org

Alan Cox wrote:
> +	{ "ST3160812AS",	"3.AD",		ATA_HORKAGE_NONCQ, },

Seagate firmware version is 5 chars.  I think the correct string would
be "3.ADJ".  Did you take it from SCSI probe message?

Thanks.

-- 
tejun

