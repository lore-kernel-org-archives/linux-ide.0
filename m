From: Tejun Heo <htejun@gmail.com>
Subject: Re: Some NCQ numbers...
Date: Tue, 03 Jul 2007 17:19:44 +0900
Message-ID: <468A06A0.1020802@gmail.com>
References: <468392CE.6010206@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:57274 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128AbXGCIVE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 04:21:04 -0400
Received: by py-out-1112.google.com with SMTP id u77so3090937pyb
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 01:21:03 -0700 (PDT)
In-Reply-To: <468392CE.6010206@msgid.tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

Michael Tokarev wrote:
> [Offtopic notice: For the first time I demonstrated some
> speed testing results on linux-ide mailinglist, as a
> demonstration how [NT]CQ can help.  But later, someone
> becomes curious and posted that email to lkml, asking
> for more details.  Since that, I become more curious
> as well, and decided to look at it more closely.
> Here it goes...]
> 
> A test drive is Seagate Barracuda ST3250620AS "desktop" drive,
> 250Gb, cache size is 16Mb, 7200RPM.

And which elevator?

-- 
tejun
