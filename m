From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/5] libata: prefer hardreset
Date: Mon, 28 Jan 2008 11:47:13 +0900
Message-ID: <479D4231.7090605@gmail.com>
References: <12011017011072-git-send-email-htejun@gmail.com> <1201101701480-git-send-email-htejun@gmail.com> <479D416A.7040007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:6914 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbYA1CrT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 21:47:19 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2695809wah.23
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 18:47:19 -0800 (PST)
In-Reply-To: <479D416A.7040007@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Tejun Heo wrote:
>> -	/* prereset() might have modified ehc->i.action */
>> -	if (ehc->i.action & ATA_EH_HARDRESET)
>> -		reset = hardreset;
>> -	else if (ehc->i.action & ATA_EH_SOFTRESET)
>> -		reset = softreset;
>> -	else {
> 
> Seems we'll need this chunk.  Will post updated version.

Eeeeek... Never mind.  I was confused.  Sorry about the noise.

-- 
tejun
