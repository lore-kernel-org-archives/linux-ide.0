Return-Path: <SRS0=f0ic=5K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB85C54FD0
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 14:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F98208E4
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 14:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fhol/5lM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgCYOXN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:23:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40920 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbgCYOXN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Mar 2020 10:23:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id u10so3332329wro.7
        for <linux-ide@vger.kernel.org>; Wed, 25 Mar 2020 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NR2RALCfd8rSS/oDIEHAtXd82vJW7Hsk6ulYdw+wc04=;
        b=fhol/5lM5IvZRvcSRcYglAhotMmsx+h7Mdx0iKzllcDwdCj0ONi8mneAd+IQViE4PP
         Ez/ELSeS5qVugsR0bopiA1WCjg32V8+5lqXuGfSLDIvvMLqBE02nB7zH+PW3U9VVGF0e
         A9nkhBGwhElsFWlPPMYvfy2INjM71FPl54tNoXiZ6ct73rcmb/oKJtaFXKlX09dmcw2Z
         YqknhxJwJtM6WF8DysisY4HcJn5V2aL9h67yq6Do/iYlqsWapzDIyW27+WBjUrnXOrPp
         ekTS+j9OlYylXYSa+c2b0Nbxwj//rcF3QpIqfrnOADMtui8QXENj/1Zcp3L0bjavMmpr
         adog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NR2RALCfd8rSS/oDIEHAtXd82vJW7Hsk6ulYdw+wc04=;
        b=hwruM0/IpHrOSoEDU7JrCHBKLvhN5ybV+mSBixcjdLAkF+Wk8sGDhg8SVaJJ+LuaxF
         /ERHc7cTBzbU8VMYFTlmODGgyLnUW+IUAZ41tGWly3sqYf4uKI4YcUhLU26XCepJZnRo
         2U3el5WdLDLW6a/RrVXyWBNNOYtS8UyD/E0Rq2mGAsG1B4q2BmuG89pvZUbLP1zW0/Ci
         olSznKLvHsSyQPmyYwiVgJy86eBdq0DLIez8ryBlWRqh2mWvuWdOGH1OFfQaJTnr30A7
         Pc/9Ig2OimnLUwMmrMEdkCuYYkfxbRYvc8ef3BqmlSyNLS1kJ0g451uiKOH5dLtpkydn
         lTzA==
X-Gm-Message-State: ANhLgQ01imeohNNdtxoPvCt0swzWoW8NdI6aa3bXlpRAE8QEQ0eeevVt
        g0bKwZcUDbTGRpLePdGYckWrag==
X-Google-Smtp-Source: ADFU+vtTF9vR+W3wWj+2sDb6HXmAtIEH5sqlH6cy58JofmUBn2Cpva5yr3B5Ye5ldkU3jc3+WXdOiA==
X-Received: by 2002:adf:dd86:: with SMTP id x6mr3688680wrl.169.1585146189020;
        Wed, 25 Mar 2020 07:23:09 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id k18sm33137543wru.94.2020.03.25.07.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:23:08 -0700 (PDT)
Date:   Wed, 25 Mar 2020 15:23:06 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Nicolas Chauvet <kwizart@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        pdeschrijver@nvidia.com,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        axboe@kernel.dk, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: tegra124-jetson-tk1: sata doesnt work since 5.2
Message-ID: <20200325142306.GB27961@Red>
References: <20200319074401.GA4116@Red>
 <CABr+WTnBmJsDZPjUxYkG98dTneDD1p8G=uRftVduTGYbY0ruqQ@mail.gmail.com>
 <20200325134003.GA27961@Red>
 <cf63d40c-7b84-60f6-76be-a13255e69c99@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf63d40c-7b84-60f6-76be-a13255e69c99@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Mar 25, 2020 at 02:00:25PM +0000, Jon Hunter wrote:
> 
> On 25/03/2020 13:40, LABBE Corentin wrote:
> > On Thu, Mar 19, 2020 at 08:55:38AM +0100, Nicolas Chauvet wrote:
> >> Le jeu. 19 mars 2020 à 08:44, LABBE Corentin <clabbe@baylibre.com> a écrit :
> >>>
> >>> Hello
> >>>
> >>> sata doesnt work on tegra124-jetson-tk1 on next and master and at least since 5.2 (but 5.1 works).
> >>> [    0.492810] +5V_SATA: supplied by +5V_SYS
> >>> [    0.493230] +12V_SATA: supplied by +VDD_MUX
> >>> [    2.088675] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
> >>> [    2.097643] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
> >>> [    3.314776] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
> >>> [    3.323658] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
> >>> [    5.236964] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
> >>> [    5.245867] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
> >>> [    5.254706] tegra-ahci 70027000.sata: 70027000.sata supply target not found, using dummy regulator
> >>> [    5.310270] phy phy-sata.6: phy poweron failed --> -110
> >>> [    5.315604] tegra-ahci 70027000.sata: failed to power on AHCI controller: -110
> >>> [    5.323022] tegra-ahci: probe of 70027000.sata failed with error -110
> >>> [   35.694269] +5V_SATA: disabling
> >>> [   35.697438] +12V_SATA: disabling
> >>
> >> It looks strange, because (on same device) , I have sata working as
> >> appropriate, but ethernet fails with me.
> >> https://bugzilla.kernel.org/show_bug.cgi?id=206217
> >>
> >> It might worth to have another report.
> >>
> > 
> > Hello
> > 
> > Mine has ethernet works well. But I hit many problem with it and older kernel.
> > Perhaps the 5.1.21, were I am stuck, does not have it.
> > 
> > Anyway, the tegra of kerneci has the same SATA problem.
> > https://storage.kernelci.org/next/master/next-20200325/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-8/lab-baylibre/boot-tegra124-jetson-tk1.txt
> > 
> > Maintainers, any idea on this sata issue ?
> 
> I have checked our bootlogs for v5.6-rc7 and don't see the issue with
> either the tegra_defconfig or the multi_v7_defconfig. I am wondering if
> this could be due a difference in the bootloader version. Currently we
> are testing with a v2019.07 u-boot bootloader. Looks like the kernelci
> board is using an older u-boot. Obviously it should still work, but
> would be good to know if the reason why were are not seeing this is
> because of the bootloader.
> 
> Another thing to check would be the pll_e clock frequency on a working
> build and non-working build to see if there is a difference in the pll
> frequency that is causing this.
> 
> Cheers
> Jon
> 

Hello

My uboot is 2016.01-rc4-00002-g3861d78, so a bit old.
I have a mainline uboot build for this tegra, but still didnt find a clear way to update it.
Did you have a good documentation on how to update it ?
If possible some clear uboot commands to update it via tftp.

Thanks
Regards
