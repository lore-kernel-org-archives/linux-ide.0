Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF713ECAAD8
	for <linux-ide@archiver.kernel.org>; Tue, 20 Sep 2022 09:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiITJHL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 20 Sep 2022 05:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiITJGu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Sep 2022 05:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B4BC0E
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663664678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZuuelmCdZJIaGRmn3zdMaH8fdIOdf58OKHfssRgDa0=;
        b=LASu+IofwF4dm01DmnXJjMDMHAk87QYDIXpfK+L43+w06QxGdhZEQtBT6+wpBzr4PtCzSF
        8Ym3trcUY/j4YU2q2qYCxn/wEeoyOtoI7r5AdADsX9NMZPoH/deookaKPH53q7NAAuEk3A
        KGejvfI0a2KyjwyymArMWXncO5OIiUQ=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-cEId9GTlMwiUlkZ7CIZ1yg-1; Tue, 20 Sep 2022 05:04:36 -0400
X-MC-Unique: cEId9GTlMwiUlkZ7CIZ1yg-1
Received: by mail-vk1-f200.google.com with SMTP id 132-20020a1f148a000000b003777ea36dc8so544296vku.18
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 02:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MZuuelmCdZJIaGRmn3zdMaH8fdIOdf58OKHfssRgDa0=;
        b=QVwCBOXgpmlVNgUseu9eL+EWEkJyaFQsTTAGrAhvT8YexyunHjfUqNWOouH/X10/sh
         GdzKYVBxDGITyV/26ppGL7/isKHuZF2xiF6qkPPQ7R3mxizRR/hJxagHX7xwyb2lYgri
         5ZL5KmDKCxJQ1O2GngVmWhfD7UzJaX4gHGAk/pyHs8ZbhsmH+k8ssTKXmv2aR1cb5aJg
         UuMNHJZkst68B8OMHC5nedS7+9XGuuLxy5mM8aZjybXEXVyvubVAbkyiPBQvbAFGl1an
         ZRoUaD4xNwEhM4x0lyRJIFbdpAVRpf7PzN1bGWNus6gsDef8f+4Cq8QfnSDb8jNSbEjB
         +OBA==
X-Gm-Message-State: ACrzQf01R7PrY3malNqSt1AwF5qxdH6O+47Ve0MyNlz01+7q0GjplsB/
        DBkE5fMjl15tFvPJaZIypOeS7TAFXDwUha9qKVAcNtznfEOFQ3mGIKim14kk73XJCL0RM+XxdUB
        AW8U8q1XBd8pNDrZGMyVTylwmIAU9hXp/xCTt
X-Received: by 2002:a1f:27cc:0:b0:3a2:4fee:940c with SMTP id n195-20020a1f27cc000000b003a24fee940cmr7455987vkn.14.1663664676203;
        Tue, 20 Sep 2022 02:04:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM55mKLjiCZZJ1LGDZ/yFqF/4GbHztomEwHpMG6PRYaEtOgu0iM+5StIwEp3Z6t/kRHvWgGz/Ixn0UtvFyi42LI=
X-Received: by 2002:a1f:27cc:0:b0:3a2:4fee:940c with SMTP id
 n195-20020a1f27cc000000b003a24fee940cmr7455977vkn.14.1663664676009; Tue, 20
 Sep 2022 02:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220919094635.184804-1-ecurtin@redhat.com> <Yyleq43/IBofsMMn@infradead.org>
In-Reply-To: <Yyleq43/IBofsMMn@infradead.org>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Tue, 20 Sep 2022 10:04:20 +0100
Message-ID: <CAOgh=FxMBE_YEC89DmeF9g76aQXrvAH1DvUavS1FhNiXqEYhAg@mail.gmail.com>
Subject: Re: [PATCH] ata: ahci: Enable/Disable ATA Staggered Spin-up by default
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Masney <bmasney@redhat.com>, Al Stone <ahs3@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Joe Konno <joe.konno@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The libahci.ignore_sss flag is something that is set by a number of
performance focused distros. The motivation behind this is to set
ignore_sss in a boolean fashion at compile time rather than depend on
cmdline parsing.

On Tue, 20 Sept 2022 at 07:56, Christoph Hellwig <hch@infradead.org> wrote:
>
> Err, no.  We should not add config options for every damn default.
> If you want to force it on CONFIG_CMDLINE is your friend.
>

