From: Tejun Heo <htejun@gmail.com>
Subject: ATA tape drive STT3401A needs DRQ HSM workaround too
Date: Mon, 22 Oct 2007 18:24:20 +0900
Message-ID: <471C6C44.2030607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:63118 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbXJVJYa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Oct 2007 05:24:30 -0400
Received: by nz-out-0506.google.com with SMTP id s18so366362nze
        for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2007 02:24:29 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Albert Lee <albertcc@tw.ibm.com>

Hello, all.

There was a bug report involving ATA tape drive STT3401A and the drive
also sets DRQ with device error and works correctly if the check is
ignored.  I saw patch implementing needed horkage.  What's the plan
here?  Blacklist all tape drives or individual ones as they come up?

Thanks.

-- 
tejun
