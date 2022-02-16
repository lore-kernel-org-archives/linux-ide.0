Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D3EC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 16 Feb 2022 18:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiBPSPd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Feb 2022 13:15:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbiBPSPd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2022 13:15:33 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914062B1012
        for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2022 10:15:20 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b13so5457747edn.0
        for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2022 10:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsoF6XbVRJnqOxLapkisfvdDBSbyOEKGfv87xWkqHBo=;
        b=H8EZzc3vbZYf96mKzjlBDBIZSlEvwXS9/cmk8gIRTNI1MAwfaOAbt22JaPzIFJh6SU
         haljNM84uLArCZw16a7/Bsg1jw9a9dpDJPFefdN6wlu3bpRuDM6rCoTBfs58oYcxVKD3
         nbRVV3036QZdC6Y3iMcylW2hsU3GnC78jLfj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsoF6XbVRJnqOxLapkisfvdDBSbyOEKGfv87xWkqHBo=;
        b=JsKVevHXnEYZjgBzM7xdsMkPxBh2TvAQeRJa2AfoMxVpUFIyF4h/IFhi/Rf6pu5psI
         HfgrtPPS0jsCg6qGq+1kbLs8mmOz3e95huzhvyerpBk8C9oETMyyn0kVQnf4eu88qGWr
         +lvsejbQWx7Udl0pM3nSD9PRa6Et3fnYCpqRAP+mg7fP38j8Di1oNiySuPExOd394Aa3
         h9ul2bygYhkBu1tYsZYE2ocQx0nHdPJoNOakZqfAG5ekCIUCsLf8NMs838guZdRnViYT
         yTfRnr8AeRRRsCGx0AmFFbEQys9irbYGcSIBMKpNhS/zNUc2n/iQPmwz5CVNc7BKaRVa
         ZUCA==
X-Gm-Message-State: AOAM530IkNMSxJGrLgdi6sghal5q6gmK0Y5cBYo94E4qpTcWlTc+4jL1
        FvQp8l7lkAyBbR/thqL4+rSJKhrtfA4b4jTK3GI=
X-Google-Smtp-Source: ABdhPJyfidiiFv4Tzh/v+/dE7iikjUxVpnpvpu8JV7yXH+jhElX9qUCp4My67sADdy4ihkLfXVMrtg==
X-Received: by 2002:a50:f091:0:b0:410:d100:fd0e with SMTP id v17-20020a50f091000000b00410d100fd0emr4336200edl.150.1645035318895;
        Wed, 16 Feb 2022 10:15:18 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id o20sm2104657edc.84.2022.02.16.10.15.18
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 10:15:18 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id vz16so1291397ejb.0
        for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2022 10:15:18 -0800 (PST)
X-Received: by 2002:ac2:5313:0:b0:443:99c1:7e89 with SMTP id
 c19-20020ac25313000000b0044399c17e89mr289887lfh.531.1645034970931; Wed, 16
 Feb 2022 10:09:30 -0800 (PST)
MIME-Version: 1.0
References: <1644984747-26706-1-git-send-email-byungchul.park@lge.com>
 <1644984964-28300-1-git-send-email-byungchul.park@lge.com>
 <1644984964-28300-3-git-send-email-byungchul.park@lge.com> <94b1cba2-0e78-bbc0-0321-8be70b2b3be2@opensource.wdc.com>
In-Reply-To: <94b1cba2-0e78-bbc0-0321-8be70b2b3be2@opensource.wdc.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Feb 2022 10:09:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfpfWuNQi2SjXQL1ir6iKCpUdBruJ+kmOQP1frH7Zdig@mail.gmail.com>
Message-ID: <CAHk-=wgfpfWuNQi2SjXQL1ir6iKCpUdBruJ+kmOQP1frH7Zdig@mail.gmail.com>
Subject: Re: Report in ata_scsi_port_error_handler()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, linux-ide@vger.kernel.org,
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
        Jens Axboe <axboe@kernel.dk>, paolo.valente@linaro.org,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Feb 15, 2022 at 10:37 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2/16/22 13:16, Byungchul Park wrote:
> > [    2.051040] ===================================================
> > [    2.051406] DEPT: Circular dependency has been detected.
> > [    2.051730] 5.17.0-rc1-00014-gcf3441bb2012 #2 Tainted: G        W
> > [    2.051991] ---------------------------------------------------
> > [    2.051991] summary
> > [    2.051991] ---------------------------------------------------
> > [    2.051991] *** DEADLOCK ***
> > [    2.051991]
> > [    2.051991] context A
> > [    2.051991]     [S] (unknown)(&(&ap->eh_wait_q)->dmap:0)
> > [    2.051991]     [W] __raw_spin_lock_irq(&host->lock:0)
> > [    2.051991]     [E] event(&(&ap->eh_wait_q)->dmap:0)
> > [    2.051991]
> > [    2.051991] context B
> > [    2.051991]     [S] __raw_spin_lock_irqsave(&host->lock:0)
> > [    2.051991]     [W] wait(&(&ap->eh_wait_q)->dmap:0)
> > [    2.051991]     [E] spin_unlock(&host->lock:0)
>
> Sleeping with a spinlock held would be triggering warnings already, so
> these reports seem bogus to me.

Yeah, Matthew pointed out the same thing for another use-case, where
it looks like DEPT is looking at the state at the wrong point (not at
the scheduling point, but at prepare_to_sleep()).

This ata_port_wait() is the exact same pattern, ie we have

        spin_lock_irqsave(ap->lock, flags);

        while (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS)) {
                prepare_to_wait(&ap->eh_wait_q, &wait, TASK_UNINTERRUPTIBLE);
                spin_unlock_irqrestore(ap->lock, flags);
                schedule();

and DEPT has incorrectly taken it to mean that 'ap->lock' is held
during the wait, when it is actually released before actually waiting.

For the spin-locks, this is all very obvious (because they'd have been
caught long ago by much simpler debug code), but the same
prepare_to_wait -> wait pattern can most definitely happen with
sleeping locks too, so they are all slightly suspect.

And yes, the detailed reports are hard to read because the locations
are given as "ata_port_wait_eh+0x52/0xc0". Running them through
scripts/decode_stacktrace.sh to turn them into filename and line
numbers - and also sort out inlining - would help a lot.

Byungchul, could you fix those two issues? Some of your reports may
well be entirely valid, but the hard-to-read hex offsets and the
knowledge that at least some of them are confused about how
prepare_to_wait -> wait actually works makes the motivation to look at
the details much less..

           Linus
