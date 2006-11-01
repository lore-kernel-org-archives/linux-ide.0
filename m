From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3 #upstream] ahci: kill AHCI_FLAG_RESET_NEEDS_CLO
Date: Wed, 01 Nov 2006 04:22:47 -0500
Message-ID: <45486767.80308@pobox.com>
References: <20061101085833.GP13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32997 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946719AbWKAJWt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 04:22:49 -0500
In-Reply-To: <20061101085833.GP13677@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Now that ahci_softreset() is fixed to automatically perform CLO if
> BSY/DRQ is set on entry, AHCI_FLAG_RESET_NEEDS_CLO is redundant.  Kill
> it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-3


