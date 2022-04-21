Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7792BC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 21 Apr 2022 15:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351585AbiDUP1Y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiDUP1X (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 21 Apr 2022 11:27:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AE543AC0
        for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2022 08:24:33 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n8so5205728plh.1
        for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2022 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2JlTE8rVe4wrB+PjFdFtyIEmw0WzZvH7ugv0zmVajeo=;
        b=hn2gQPEtkGhTGkqg3FeJ7nomTp49/BXpWEsw/znzdWHSv1nHP6kv+np9TFHksjAIU+
         ik40c2z0uGsQUyoCsevdh80baYLwJzdHZFXoOljhaiOV/pyOY7z/Q+0Wkxzd7T6sl+M7
         cOkYiT4P8UWDCn5M1rPKAkoxVNzZiq73g1/bhJZjA3H44vBXW1XcDN6/v5ra7SoG+nbD
         LA0G4DWrH10nroCGkKpCOeM4NcYn10Od3bueSIi+t8P85RMH3dk64TZvXa+JB7lzmIc8
         SRkYJAd/C0pvTOPiA1zXuEPskVvMvrEAJc9AjH5ba9fLG+cxXA5rXiAQPQKPWLOlxpnz
         CF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2JlTE8rVe4wrB+PjFdFtyIEmw0WzZvH7ugv0zmVajeo=;
        b=ITXfBsVytOnG/U+5Qg9ARSr1j6Mulj93h+2RbpAPf2YaaE83sj+ZaTcDgGvr25fKB7
         cbeOxLiNnL3qCZDp6AND6Z966Hhy2olwWuaUtKPPwcpsrZ/EeAuqWANOig6mfRVQyLqm
         EPR8FYV1KegfmUP11KCHXs0EdrFzytioOw5R5W8GyggCUCrt5hEEhzahZ+k2mcdaD8hg
         i+Zyyyhu6p9K09fusgJ5yFZ6vn7rFjXLr5/ObRwaohGv9+rXV/bM+fXUNGVWN1rwJ6xT
         QOCTyMA+y9GTE+QwmzgXTgBm90n/UVNLSyzZKgpy4JHM8c31SDCVdSWWQeuyKM9DrVUk
         6BPg==
X-Gm-Message-State: AOAM531XHXurwFlUznW8vaQHpVpgZ8Umvz8kfqBnNbeMP/+5ZL56Rjg3
        pKgA/ZUe8wA4cQmJ2xSGK4G1dOqz+mV64wLNhXVr2g==
X-Google-Smtp-Source: ABdhPJyzqnAbQClIHgqFidaycjDNd4gSgRzlpuSxHm5xQi92PJ3O//c4YeewlDtFDN21k0oyH0sho4hOp8DNbQu9dlY=
X-Received: by 2002:a17:90b:1e0e:b0:1d2:8906:cffe with SMTP id
 pg14-20020a17090b1e0e00b001d28906cffemr192690pjb.220.1650554672791; Thu, 21
 Apr 2022 08:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <165051164674.3740862.4706111262486927842.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220421055041.GB20772@lst.de>
In-Reply-To: <20220421055041.GB20772@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Apr 2022 08:24:21 -0700
Message-ID: <CAPcyv4j84kdh9yunQ+BnQJL=BKB1kCOw4bhkEqWnBQf+YPt+Dg@mail.gmail.com>
Subject: Re: [PATCH] ahci: Add a generic 'controller2' RAID id
To:     Christoph Hellwig <hch@lst.de>
Cc:     damien.lemoal@opensource.wdc.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "IDE/ATA development list" <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Apr 20, 2022 at 10:50 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Apr 20, 2022 at 08:27:26PM -0700, Dan Williams wrote:
> > As mentioned here [1], the pain of continuing add new and different
> > device-ids for RAID mode to this file [2] has been heard. Ideally this
> > device-id would not matter and the class code would remain
> > PCI_CLASS_STORAGE_SATA_AHCI regardless of the RAID mode, but other
> > operating systems depend on the class code *not* being AHCI when the
> > device is in RAID mode. That said, going forward there is little reason
> > for new server RAID ids to be added as they can simply reuse one of the
> > existing ids even for a new controller. Server software RAID features
> > continue to be supported on Linux. Client software RAID features
> > continue to be not supported and the recommendation there remains to set
> > the device to AHCI mode in platform firmware.
>
> I thought client switched to vmd as well now?

Yes, I believe so, but the RAID metadata and features like caching etc
are still forked.

> Either way the patch itself looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks.
