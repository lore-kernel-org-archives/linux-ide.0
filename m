From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: make CONFIG_IDE_GENERIC default to N
Date: Sun, 29 Jul 2007 00:46:35 +0200
Message-ID: <200707290046.35623.bzolnier@gmail.com>
References: <469E2F81.8080002@alcatel-lucent.com> <46A9E797.5010708@garzik.org> <46AAF193.1050203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:54460 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581AbXG1Xoo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jul 2007 19:44:44 -0400
Received: by ug-out-1314.google.com with SMTP id j3so879623ugf
        for <linux-ide@vger.kernel.org>; Sat, 28 Jul 2007 16:44:43 -0700 (PDT)
In-Reply-To: <46AAF193.1050203@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "P.C.Chan" <pc.chan@alcatel-lucent.com>, linux-ide@vger.kernel.org

On Saturday 28 July 2007, Tejun Heo wrote:
> These days, CONFIG_IDE_GENERIC causes more confusion and
> misconfiguration than it helps.  Especially so because libata is
> linked after the generic driver.  Default to N.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied and Jeff's ACK added, thanks
