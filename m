From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 05/14] libata: make ->data_xfer return the number of consumed
 bytes
Date: Wed, 05 Dec 2007 09:49:18 +0900
Message-ID: <4755F58E.3020703@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com> <11963468181417-git-send-email-htejun@gmail.com> <4755AAE1.5060000@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:32830 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbXLEAt1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 19:49:27 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6626917wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 16:49:26 -0800 (PST)
In-Reply-To: <4755AAE1.5060000@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Jeff Garzik wrote:
> IMO s/buflen/len/ causes needless patch noise, and makes this harder review

Separating out s/buflen/len/ to a separate patch seemed silly yet I
wanted to renamed it.  :-P

If you want to kill it, I'll kill the renaming.  If you want it in a
separate patch, I'll separate it out.

-- 
tejun
