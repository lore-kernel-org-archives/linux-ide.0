From: Tejun Heo <htejun@gmail.com>
Subject: Re: dvdrw->cdrom
Date: Mon, 21 Jan 2008 17:49:57 +0900
Message-ID: <47945CB5.4040708@gmail.com>
References: <6d98c5450801110719t3979a4f4j6a515e2c3b7ffcd8@mail.gmail.com> <47944B76.5030804@gmail.com> <Pine.BSO.4.64.0801210243230.22203@transpose.10k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:62766 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757943AbYAUIuC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 03:50:02 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3572614wah.23
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 00:50:02 -0800 (PST)
In-Reply-To: <Pine.BSO.4.64.0801210243230.22203@transpose.10k.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jake <kfc@10k.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

[restoring linux-ide. please don't drop cc's. use reply-to-all.]

Jake wrote:
> Hi, Tejun:
> 
> http://marc.info/?l=linux-ide&m=120069298104580&w=4
> 
> It has been 2 weeks here hunting for some solutions,
> can you recommend anything that I should try? Thank you.

Can you please post full boot log from the working kernel && broken
kernel?  It seems you were using ide-scsi driver previously, right?
Also, w/ libata driver, does the reading part work okay?  Can you read cd's?

-- 
tejun
