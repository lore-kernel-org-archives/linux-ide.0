From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] misc reset updates (repost)
Date: Tue, 11 Apr 2006 22:16:44 +0900
Message-ID: <11447614041095-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.239]:52599 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750792AbWDKNQr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:16:47 -0400
Received: by wproxy.gmail.com with SMTP id i11so920393wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:16:46 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is repost of misc-reset-updates patchset.  Previous posting
didn't have proper head message and patch numbers were incorrect.
This repost is to reduce the amount of confusion.

This patchset updates reset mechanism.  Cable type is set early in
probeinit, @verbose argument is removed from reset methods and missing
error messages are added.

This patchset is against

  upstream (c2a6585296009379e0f4eff39cdcb108b457ebf2)

Thanks.

--
tejun


