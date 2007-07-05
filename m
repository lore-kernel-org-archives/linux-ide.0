From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/10] libata: remove irq_on from ata_bus_reset() and ata_std_postreset()
Date: Thu, 05 Jul 2007 19:18:26 +0900
Message-ID: <468CC572.4000806@gmail.com>
References: <468B5C97.1000803@tw.ibm.com> <468B5D98.1020708@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:26060 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758393AbXGEKSf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jul 2007 06:18:35 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1808300nze
        for <linux-ide@vger.kernel.org>; Thu, 05 Jul 2007 03:18:35 -0700 (PDT)
In-Reply-To: <468B5D98.1020708@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@enoyolf.org>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Patch 1/10:
>   After checking, it seems calling irq_on() in ata_bus_reset() and ata_std_postreset()
> are leftover of the EDD reset. Remove them.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
