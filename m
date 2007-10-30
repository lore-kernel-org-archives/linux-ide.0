From: Tejun Heo <htejun@gmail.com>
Subject: Re: PMP device port link speed issues
Date: Tue, 30 Oct 2007 12:58:36 +0900
Message-ID: <4726ABEC.6060305@gmail.com>
References: <2A6F278C5B66C4459AF4013E77A40CD301003529@zin33exm20.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:32973 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbXJ3D6p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 23:58:45 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2348776wah
        for <linux-ide@vger.kernel.org>; Mon, 29 Oct 2007 20:58:44 -0700 (PDT)
In-Reply-To: <2A6F278C5B66C4459AF4013E77A40CD301003529@zin33exm20.fsl.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kalra Ashish-B00888 <ashish.kalra@freescale.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Kalra Ashish-B00888 wrote:
> Hello Tejun,
> 
> This patch will surely fix my problem, but won't it be better to set
> each PMP device port link speed directly to

Also, please verify it actually fixes the problem you're seeing.

Thanks.

-- 
tejun
