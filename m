Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EE0C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 12:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbiCXMu5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiCXMuz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 08:50:55 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE0A5418C
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 05:49:22 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id o20-20020a9d7194000000b005cb20cf4f1bso3205427otj.7
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Io+rMpcEFPjnXyfviFk8sBEJS8sEqBNxnOI0oOS5EZI=;
        b=BfZwL+c/1JjwcN0B1gOInzWvOauehycpUP8KSZRvfZTs6f1XkVoTpFyPFXDGO0bkjL
         nKBZ5zr9RqqaDMOttIZCdlw10rjr3ZJiCyUaob5OPhu912nNplWM8ZBpLe62nBdnRTkW
         2S1C67uWhYK4amUVS8vi56QjCX+HobrdwrBGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Io+rMpcEFPjnXyfviFk8sBEJS8sEqBNxnOI0oOS5EZI=;
        b=MQhXeINvhjkNmvPNTRM0wP3EWi3FC+q8Ecu5BFk7wM/Z8pPpij6cvUXfPEwNTR2UeT
         1LBR2M/pnRmlQZy5oD84Pble4p9FkDSQHFOwCZ/QeATlxw/FBcvETXOTp9eIDUVssDAj
         E0LW5Kpi1YMcclmUaZSzz8iplvJ8GidCQgZNB9DiSnxRql84/Bmg8K+GwF0pOT4tSpYc
         xwDRfrCwqZCnAxYWz92VjOb+sGNTkkyL5+I8BlXd2gxoO38UNwfym7/Qp35i+EfbBFbP
         uz5H+t9l0EhZx29cxHaYhSYNR3rqSOgkYly0JM29ogc0MwhnYWptVhJ6Pq3/aBwC1NRb
         0EsA==
X-Gm-Message-State: AOAM5317lsLyfgEY5eBXLt3NiSU68TQ0q3jfvujuCDuqGgKQXbukpk0w
        OeNtEEOjIj8s7biKzVNAE4Z1SQ==
X-Google-Smtp-Source: ABdhPJzLYvTQ+XJ04GOwueN+Bngl3Lc749loGwJeiBsGbuSdWLLcI6A11U19B+/sB0OJ06c0V3y+pw==
X-Received: by 2002:a05:6830:2a86:b0:5cd:b4b6:ac84 with SMTP id s6-20020a0568302a8600b005cdb4b6ac84mr723276otu.375.1648126161322;
        Thu, 24 Mar 2022 05:49:21 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id 21-20020a056870115500b000dda3a0cb91sm1255649oag.54.2022.03.24.05.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:49:20 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Thu, 24 Mar 2022 07:49:19 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [GIT PULL] ata changes for 5.18-rc1
Message-ID: <Yjxoz+fojG3csrVi@fedora64.linuxtx.org>
References: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wgCt46XN2xuQO3Zj2UoeP472EpyWbrjsDPVZvDHW+rA2g@mail.gmail.com>
 <BL1PR12MB51576EE0517167FDC471AE8EE2189@BL1PR12MB5157.namprd12.prod.outlook.com>
 <4459a2ff-0852-d8fb-a2e8-307d651f728c@opensource.wdc.com>
 <YjwPhvPyJHiDbkOL@infradead.org>
 <55df3e41-6252-47e3-1e2f-bf96dce6c304@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55df3e41-6252-47e3-1e2f-bf96dce6c304@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Mar 24, 2022 at 03:38:00PM +0900, Damien Le Moal wrote:
> On 3/24/22 15:28, Christoph Hellwig wrote:
> > On Thu, Mar 24, 2022 at 08:45:56AM +0900, Damien Le Moal wrote:
> >> Mario, let's check what other distros do first before deciding. Fedora for
> >> sure has a default of 3 and I have never seen any issue with it (and I
> >> have been using Fedora for a long time with many different drives).
> >>
> >> Not sure what distro you are using, but if it is not Fedora, please check.
> >> We should check at least Debian, Ubuntu, SUSE, RHEL and CentOS. I can
> >> check some other minor ones too as I know users.
> > 
> > Debian:
> > 
> > hch@brick:~/work/linux$ grep CONFIG_SATA_MOBILE_LPM_POLICY /boot/config-5.10.0-1*
> > /boot/config-5.10.0-10-amd64:CONFIG_SATA_MOBILE_LPM_POLICY=3
> > /boot/config-5.10.0-11-amd64:CONFIG_SATA_MOBILE_LPM_POLICY=3
> > /boot/config-5.10.0-12-amd64:CONFIG_SATA_MOBILE_LPM_POLICY=3
> 
> Thanks. Debian testing also has the default at 3.
> 
> Mario reported that Ubuntu and Arch also use 3, and that RHEL has 0 as
> default but changes it to 3 after boot.
> 
> Gentoo default config is also 3. Checking CentOS and [open]SUSE now.

CentOS uses the RHEL configs and defaults to 0.  I do agree that
renaming config options can be problematic, but the heads up from Damien
helped. It will not be an issue for Fedora, CentOS, and RHEL.

Justin
 
> So far, it is looking like 3 is a sane default.
> 
> -- 
> Damien Le Moal
> Western Digital Research
