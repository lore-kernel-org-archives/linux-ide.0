From: Tejun Heo <htejun@gmail.com>
Subject: Re: timeouts with SiI 4726/3531
Date: Thu, 11 Oct 2007 12:08:34 +0900
Message-ID: <470D93B2.9000603@gmail.com>
References: <87lkaf3moh.fsf@wyrd.be> <87lkadsab5.fsf@wyrd.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:59593 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139AbXJKDIk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 23:08:40 -0400
Received: by wa-out-1112.google.com with SMTP id v27so457994wah
        for <linux-ide@vger.kernel.org>; Wed, 10 Oct 2007 20:08:40 -0700 (PDT)
In-Reply-To: <87lkadsab5.fsf@wyrd.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lieven Marchand <mal@wyrd.be>
Cc: linux-ide@vger.kernel.org

Lieven Marchand wrote:
> I've solved the problem with the timeouts by disabling NCQ on the four
> disks. Apparently there's something in the combination of NCQ+PMP that
> gives problems.

(can't find the original thread) Can you post failing dmesg and the
result of "hdparm -I /dev/sdX"?  So, without PMP, those drives behave
okay with NCQ turned on?

Thanks.

-- 
tejun
