From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/15] libata: fix ata_set_mode() return value
Date: Sat, 01 Apr 2006 12:34:23 -0500
Message-ID: <442EB99F.702@pobox.com>
References: <11438230972882-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:13787 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751575AbWDAReh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 12:34:37 -0500
In-Reply-To: <11438230972882-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Make ata_set_mode() return correct error value when ata_dev_set_mode()
> fails.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-7


