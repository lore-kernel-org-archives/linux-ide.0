Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5795FC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  4 May 2022 18:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376931AbiEDSg6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 May 2022 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377146AbiEDSgu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 4 May 2022 14:36:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CECE2DEE
        for <linux-ide@vger.kernel.org>; Wed,  4 May 2022 11:22:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq17so4491615ejb.4
        for <linux-ide@vger.kernel.org>; Wed, 04 May 2022 11:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azQ8sWCnz/WIz9gx757KP54kS0UJB42kEHdJ90hMQlI=;
        b=TGN9imabgriFl447VR+LtalCql2Ru1FM30YxNTrRXmNp2/aqSQe997eejilXBWN//u
         GLL7PEuW6j459zsXmON4fgRMpLVmy4AeFXc6ipyOPPq4NZahAq6TXZNADjmVrlQQdnt5
         DczkC/efB8FuKeTl9T9HqInWj7/2oPQ1dOleE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azQ8sWCnz/WIz9gx757KP54kS0UJB42kEHdJ90hMQlI=;
        b=u1JGuNWhO3xjVuHrOMj7rXshuPIpJiA2R3DbOJaEcqaPFvWkp/HfngR8aMcT+bTxue
         fRf4OQ9PWkhY5lSB9oSA9b8oqw/kPShvfe7zfsqo0Rxqtfkkj/bZM25JRcUMYlfEvMTl
         CaqnEXFdxYZfT+weNuoE6FPd45ZPftTKWSS1KCU9kk4QU6wGCZFDGKSnuNZtycsikeRR
         FyQiXlFX7wJdoqzWSHTh29hhhYFbK3Rz3rgsyAZhfTYTESesdMy2yXN1LChILlI2CtYj
         Z7yfxMuv3asahDK1hT24VYsZ+P2FkFgSssuhiPAnqmietSloIEo419ivfdHG1euBU9vf
         PrBg==
X-Gm-Message-State: AOAM532Avf/RknYUZFb8ISTThpTOUMjS0Wbl2PyYPIaEl4BtI2tQhqFx
        NeLkmRa16XKxz/+xcrhwFqDjYLt0zs8Vh6pktU4=
X-Google-Smtp-Source: ABdhPJys/fcmpkCWDrrp0OIZ4Tud+pDKO4Q7Mj+kQi90uzun9SvdeLeW+9RkBB4ITrfxo9/UNv5M8w==
X-Received: by 2002:a17:906:a08b:b0:6cf:65bc:e7de with SMTP id q11-20020a170906a08b00b006cf65bce7demr21877039ejy.220.1651688569825;
        Wed, 04 May 2022 11:22:49 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id zp26-20020a17090684fa00b006f3ef214e62sm5937951ejb.200.2022.05.04.11.22.49
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 11:22:49 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id n10so4485265ejk.5
        for <linux-ide@vger.kernel.org>; Wed, 04 May 2022 11:22:49 -0700 (PDT)
X-Received: by 2002:a05:6512:b12:b0:44a:ba81:f874 with SMTP id
 w18-20020a0565120b1200b0044aba81f874mr15410699lfu.449.1651688238925; Wed, 04
 May 2022 11:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
In-Reply-To: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 May 2022 11:17:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
Message-ID: <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
Subject: Re: [PATCH RFC v6 00/21] DEPT(Dependency Tracker)
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>, duyuyang@gmail.com,
        johannes.berg@intel.com, Tejun Heo <tj@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@lge.com, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, sj@kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, ngupta@vflare.org,
        linux-block <linux-block@vger.kernel.org>,
        paolo.valente@linaro.org, Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        jack@suse.com, Jeff Layton <jlayton@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, May 4, 2022 at 1:19 AM Byungchul Park <byungchul.park@lge.com> wrote:
>
> Hi Linus and folks,
>
> I've been developing a tool for detecting deadlock possibilities by
> tracking wait/event rather than lock(?) acquisition order to try to
> cover all synchonization machanisms.

So what is the actual status of reports these days?

Last time I looked at some reports, it gave a lot of false positives
due to mis-understanding prepare_to_sleep().

For this all to make sense, it would need to not have false positives
(or at least a very small number of them together with a way to sanely
get rid of them), and also have a track record of finding things that
lockdep doesn't.

Maybe such reports have been sent out with the current situation, and
I haven't seen them.

                 Linus
