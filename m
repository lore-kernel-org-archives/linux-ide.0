From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH8 and SATA
Date: Tue, 23 May 2006 07:04:33 +0900
Message-ID: <44723571.1090500@gmail.com>
References: <447169C8.9060708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:25551 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751223AbWEVWEe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 May 2006 18:04:34 -0400
Received: by nz-out-0102.google.com with SMTP id 8so1407929nzo
        for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 15:04:34 -0700 (PDT)
In-Reply-To: <447169C8.9060708@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> BTW, Intel sez:
> 
> "FYI, I added PIIX_FLAG_IGNORE_PCS and was able to boot on ICH8."
> 

Yeap, that should achieve about the same effect as the experimental 
patch Andrew posted; also, about the same phantom bug.

I don't think the phantom device problem is caused by missing 
dev_select.  We have enough dev_select() during classification.

-- 
tejun
