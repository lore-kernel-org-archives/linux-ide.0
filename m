From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/5] libata: prefer hardreset
Date: Mon, 28 Jan 2008 11:43:54 +0900
Message-ID: <479D416A.7040007@gmail.com>
References: <12011017011072-git-send-email-htejun@gmail.com> <1201101701480-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:62821 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbYA1CoG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 21:44:06 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2694437wah.23
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 18:44:06 -0800 (PST)
In-Reply-To: <1201101701480-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> -	/* prereset() might have modified ehc->i.action */
> -	if (ehc->i.action & ATA_EH_HARDRESET)
> -		reset = hardreset;
> -	else if (ehc->i.action & ATA_EH_SOFTRESET)
> -		reset = softreset;
> -	else {

Seems we'll need this chunk.  Will post updated version.

Thanks.

-- 
tejun
