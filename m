From: xiangliang yu <yxlraid@gmail.com>
Subject: Re: [PATCH 1/1] AHCI: disabled FBS before softreset handling.
 According to chapter 9.3.9 in AHCI spec, controller should disable FBS before softreset.
Date: Fri, 27 Sep 2013 09:55:55 +0800
Message-ID: <CAP0P+NVtDGwOY3MW7JTGd+HmeFf=214tE50aeK06TZOfpKYYUA@mail.gmail.com>
References: <1380120388-13375-1-git-send-email-yxlraid@gmail.com>
	<20130926141207.GB3482@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:63986 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab3I0Bz5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Sep 2013 21:55:57 -0400
Received: by mail-bk0-f41.google.com with SMTP id na10so747623bkb.0
        for <linux-ide@vger.kernel.org>; Thu, 26 Sep 2013 18:55:55 -0700 (PDT)
In-Reply-To: <20130926141207.GB3482@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

ok, i'll update and re-commit the patch

2013/9/26 Tejun Heo <tj@kernel.org>:
> Please shorten the subject and explain in detail what this patch
> changes how and why along with how you tested it and what, if any,
> behavior changes occur from it.
>
> Thanks.
>
> --
> tejun
