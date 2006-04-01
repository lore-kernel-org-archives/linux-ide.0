From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 08/15] libata: don't disable devices from ata_set_mode()
Date: Sat, 01 Apr 2006 14:46:23 -0500
Message-ID: <442ED88F.6050301@pobox.com>
References: <11438230982787-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:6877 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751441AbWDATq3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 14:46:29 -0500
In-Reply-To: <11438230982787-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> When ata_set_mode() fails on a device, make ata_set_mode() return
> error code and pointer to the device instead of disabling it directly.
> This gives more control to higher level driving logic.
> 
> This patch does not change the end result (configured transfer mode)
> although it may make libata repeat mode configuration to the peer of a
> failing device.  Later ata_bus_probe() rewrite will make full use of
> this change.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


