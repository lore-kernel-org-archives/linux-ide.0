From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Thu, 22 Dec 2016 12:19:02 -0500
Message-ID: <20161222171902.GC31216@htj.duckdns.org>
References: <CAP8WD_bZWeLBhLXqJG5uDwBe+zBubw+A+ecSuaihOuwvw9QoCQ@mail.gmail.com>
 <20161202170705.GB6033@htj.duckdns.org>
 <CAP8WD_bUW9cAAQpvenL73sxvpoxNYwZdRqpj92YWEyanK51+0g@mail.gmail.com>
 <20161205192310.GA30331@mtj.duckdns.org>
 <CAP8WD_becq+h2=-g7t-6Pp1psmkCCvdB0YUcg+wYPocUP4dYdw@mail.gmail.com>
 <20161212170154.GA13864@htj.duckdns.org>
 <CAP8WD_YMtnsuYmJHGz1eLmrQNemsB1Z6Soyb6f72brAfMNUNeg@mail.gmail.com>
 <CAP8WD_ZoJgrdsDZNR4uN8HWESO5MyuNc1xN_F2an8GfP8nKcLA@mail.gmail.com>
 <20161222163711.GB29161@htj.duckdns.org>
 <CAP8WD_ay1uKc0JLPr8MWQKT2N=rdqeH+hKkOCVMt76NcmK4hAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33199 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965341AbcLVRTE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 22 Dec 2016 12:19:04 -0500
Received: by mail-yw0-f194.google.com with SMTP id s68so15229313ywg.0
        for <linux-ide@vger.kernel.org>; Thu, 22 Dec 2016 09:19:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAP8WD_ay1uKc0JLPr8MWQKT2N=rdqeH+hKkOCVMt76NcmK4hAA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: whiteheadm@acm.org
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

Hello,

On Thu, Dec 22, 2016 at 12:14:43PM -0500, tedheadster wrote:
> It looks to me that when something is 'platform' it is not expected to
> ever go away, and that generally includes irqs. There are calls to
> platform_get_irq() but there isn't even a function called
> platform_put_irq() or platform_free_irq().

But it works fine if we open and release an explicit devres group, so
the problem isn't there.  The problem is why platform device
destruction isn't triggering devres release of all associated
resources.

Thanks.

-- 
tejun
