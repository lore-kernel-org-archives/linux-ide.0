From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/7] libata: use freeze/thaw for polling PIO
Date: Fri, 13 Jul 2007 15:53:36 +0900
Message-ID: <46972170.30300@gmail.com>
References: <468F3949.5050800@tw.ibm.com> <468F3C2C.4050609@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:4583 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbXGMGxl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 02:53:41 -0400
Received: by nz-out-0506.google.com with SMTP id s18so365483nze
        for <linux-ide@vger.kernel.org>; Thu, 12 Jul 2007 23:53:41 -0700 (PDT)
In-Reply-To: <468F3C2C.4050609@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@enoyolf.org>, Mark Lord <mlord@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> This patch let polling pio codes to use freeze()/thaw() for irq off/on.
> The reason is: some ATAPI devices raises INTRQ even of nIEN = 1.
> Using the host adapter irq mask mechanism, if available, is more reliable than the device nIEN bit.
> 
> ata_qc_set_polling() is also removed since now unused.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

ACK 1-4.

-- 
tejun
