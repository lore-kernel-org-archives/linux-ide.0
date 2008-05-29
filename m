From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] libata: SRST can't be trusted on PMP
 sil3726
Date: Thu, 29 May 2008 10:59:24 +0900
Message-ID: <483E0DFC.4000606@gmail.com>
References: <4833AEFC.2000705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:32762 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670AbYE2B7i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 21:59:38 -0400
Received: by py-out-1112.google.com with SMTP id p76so2615753pyb.10
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 18:59:37 -0700 (PDT)
In-Reply-To: <4833AEFC.2000705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> As in sil4726, SRST can't be trusted on sil3726 causing detection
> problems under certain configuraitons.  I thought it was from the
> Config Disk device but apparently not.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Ping.

-- 
tejun
