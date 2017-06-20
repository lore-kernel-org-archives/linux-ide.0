From: Minwoo Im <dn3108@gmail.com>
Subject: Re: [PATCH] libata: do not initialise statics to 0 ERROR fix.
Date: Tue, 20 Jun 2017 10:03:50 +0900
Message-ID: <CAKv8XUWocFo1QnfOGS8tAy28a4wZxaa+pL9BmcW43_NWjs1_jQ@mail.gmail.com>
References: <1497682984-5554-1-git-send-email-dn3108@gmail.com> <20170619173835.GA12062@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f182.google.com ([209.85.213.182]:36098 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752710AbdFTBDv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jun 2017 21:03:51 -0400
Received: by mail-yb0-f182.google.com with SMTP id t7so32838484yba.3
        for <linux-ide@vger.kernel.org>; Mon, 19 Jun 2017 18:03:51 -0700 (PDT)
In-Reply-To: <20170619173835.GA12062@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On 6/20/17, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Sat, Jun 17, 2017 at 04:03:04PM +0900, Minwoo Im wrote:
>> ERROR: do not initialise statics to 0 in four lines in libata-core.c.
>> Signed-off-by: Minwoo Im <dn3108@gmail.com>
>
> I don't think there's much value in sweeping the code base with
> checkpatch.  We can fix them when changing code around them or there's
> a meaningful gain from it (e.g. doc updates which improve doc
> processing) but otherwise I think it's churns for churns' sake.
>
> Thanks.
>
> --
> tejun
>

(resending in plain text to mail loop)

Hi Tejun,

I completely agree with your thought.
Thanks for giving your opinion.

Minwoo.
