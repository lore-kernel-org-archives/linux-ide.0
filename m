From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] AHCI: disabled FBS before softreset handling.
 According to chapter 9.3.9 in AHCI spec, controller should disable FBS
 before softreset.
Date: Thu, 26 Sep 2013 10:12:07 -0400
Message-ID: <20130926141207.GB3482@htj.dyndns.org>
References: <1380120388-13375-1-git-send-email-yxlraid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ye0-f180.google.com ([209.85.213.180]:59346 "EHLO
	mail-ye0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab3IZOML (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Sep 2013 10:12:11 -0400
Received: by mail-ye0-f180.google.com with SMTP id m15so386352yen.39
        for <linux-ide@vger.kernel.org>; Thu, 26 Sep 2013 07:12:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1380120388-13375-1-git-send-email-yxlraid@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Xiangliang Yu <yxlraid@gmail.com>
Cc: linux-ide@vger.kernel.org

Please shorten the subject and explain in detail what this patch
changes how and why along with how you tested it and what, if any,
behavior changes occur from it.

Thanks.

-- 
tejun
