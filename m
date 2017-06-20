From: Minwoo Im <dn3108@gmail.com>
Subject: Re: [PATCH] libata: do not initialise statics to 0 ERROR fix.
Date: Tue, 20 Jun 2017 09:59:46 +0900
Message-ID: <CAKv8XUUp6P3EBU=QdFZKZz49OivLsXJ8c_hX9qvB4EC97db2Ug@mail.gmail.com>
References: <1497682984-5554-1-git-send-email-dn3108@gmail.com> <20170619173835.GA12062@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f171.google.com ([209.85.213.171]:35724 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752482AbdFTA7r (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jun 2017 20:59:47 -0400
Received: by mail-yb0-f171.google.com with SMTP id f192so32903635yba.2
        for <linux-ide@vger.kernel.org>; Mon, 19 Jun 2017 17:59:47 -0700 (PDT)
In-Reply-To: <20170619173835.GA12062@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dn3108@gmail.com
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

good
