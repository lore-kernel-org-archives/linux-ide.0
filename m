From: Tejun Heo <htejun@gmail.com>
Subject: Re: new errors with sata_sil24 with port multiplier
Date: Sun, 04 Nov 2007 11:39:27 +0900
Message-ID: <472D30DF.4060208@gmail.com>
References: <FD6311B7ED175B4480F31633F6098B4DA0EB31@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:7150 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757007AbXKDCjh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Nov 2007 22:39:37 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1472304wah
        for <linux-ide@vger.kernel.org>; Sat, 03 Nov 2007 19:39:36 -0700 (PDT)
In-Reply-To: <FD6311B7ED175B4480F31633F6098B4DA0EB31@ffpglobal_mail.corp.ffplus.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jon Chelton <jchelton@ffpglobal.com>
Cc: linux-ide@vger.kernel.org

Jon Chelton wrote:
> Now that the speed of this drive has been at 1.5gbs, the error has not
> returned under moderate disk load for 20 or so hours.  This is odd
> because 7 other drives on the same controller are working at 3.0gbs.

The drive is faulty or the connector or something else is wrong with the
slot.  You can find out by swapping the positions of the disk in that
slot and another one.

-- 
tejun
