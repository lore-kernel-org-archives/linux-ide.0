Return-Path: <SRS0=8Rmv=Y6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E40C47E49
	for <linux-ide@archiver.kernel.org>; Wed,  6 Nov 2019 01:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B12E21D81
	for <linux-ide@archiver.kernel.org>; Wed,  6 Nov 2019 01:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEh9JxVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfKFBeb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Nov 2019 20:34:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34366 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbfKFBea (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Nov 2019 20:34:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id n13so5839205pff.1;
        Tue, 05 Nov 2019 17:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=72ZZvSEcVH/hwuHhCzZSqSBw1/nm9IeJfjkeex8kPRI=;
        b=BEh9JxVAKr+hBDoq/V5bApxFiaGyfTxcqRMeEQLtc3OXIPawnysCmhn/JIsYr3btTi
         RcBkXwLICty3AJ2R3F/c9obFFEVSTj4Bc5lj5610AGp2K2+zlcsEp02RIa7iq9NxteAZ
         qBtM/RwmCYGy6v2uf+mSRYsAqTN9Ot4hahq5ABKp8ja6+07zXdPvg1yoTDh0v/TZHmN4
         kq8i66PR5iDpanFo5egK5HX1FcSUjtgvPweZkUqlR9tbLK2uHkeU8H18dQx6zcEak5Yn
         VfJk8Z/vvTaCmZ7pQ+PZp1Ytc6Z2PHjmenpM5Cy0H8F/a2CNl/Zb5Uifu8F+yN7UUd8E
         MsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=72ZZvSEcVH/hwuHhCzZSqSBw1/nm9IeJfjkeex8kPRI=;
        b=gZ7rKTQ8XouNglPKpOwbQEPl9tw0AivoKTDpIVKcrwlFuTW0EXs7teyuQPIYpBmp/7
         duhmQfzCmGAwAf49dHCwBTntlFmyc0LCTvyCinfhTChCHlW/MFA188mFbW0wlsj+S7e+
         1h14HVDkWbjvFNRRBxltAVERxWVgE5nK4ELol6QFPqk71cpa9YLYUlm+31GqT2iHvDLb
         er2Z3WWKZ24dtsuglwtE6pWxa1mRCDuMikuo03bnMcbOQs6vCO38ykpr8v5YfbCNZ9ck
         6/CeGbJoopSSmMiusoIZgucgVFSNTuuBxP6J+QmEOgFCWZfl2XkI2/IrnHfaiXzFOj8P
         hGZA==
X-Gm-Message-State: APjAAAXscEZJ/GUUou/PUHjfDsLGWsVN3AeKBeCK3Nxb+uV1CsUbIFMt
        gQUOqGCm9Z1lSXFyhQrY2Vg=
X-Google-Smtp-Source: APXvYqy696PuuuyOXxfVuAVYGPULke2pQdufjpYPZEIacPrbZSzlfODF7IX0LstpudKMjlqxaeuJGg==
X-Received: by 2002:a62:1c08:: with SMTP id c8mr24827pfc.212.1573004069206;
        Tue, 05 Nov 2019 17:34:29 -0800 (PST)
Received: from ?IPv6:2001:df0:0:200c:8d0b:8375:2a32:c157? ([2001:df0:0:200c:8d0b:8375:2a32:c157])
        by smtp.gmail.com with ESMTPSA id a25sm4644273pff.50.2019.11.05.17.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 17:34:28 -0800 (PST)
Subject: Re: [PATCH RESEND v2 0/2] Convert Atari Falcon IDE driver to platform
 device
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
 <7bd80760-0d46-3b3d-16e7-41cbc9169822@kernel.dk>
 <CAMuHMdWFoC8YUbmW8J7tJSsq4b67WkjyRzhkW=yfrEEJJmsZKQ@mail.gmail.com>
 <edb1ab21-9b60-4a25-b18c-76173ae6b28f@gmail.com>
 <CAMuHMdU6mcW_EcmE3bCTRGVCdouFPDoawTVyyGJP50oGES=duA@mail.gmail.com>
 <db487366-b0d7-d65d-70b5-261aa439298b@gmail.com>
 <f02faa63-83bd-6be1-e014-e400d180e10c@physik.fu-berlin.de>
 <6a5e4644-ba7a-079d-d49d-73509bc1cf65@gmail.com>
 <317f3b1e-20a8-65eb-3a26-3bb79dc22786@physik.fu-berlin.de>
 <6fb6c69f-ef48-1b35-bbb2-011c12bb02b6@gmail.com>
Message-ID: <db2838b7-4862-785b-3a1d-3bf09811340a@gmail.com>
Date:   Wed, 6 Nov 2019 14:34:24 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6fb6c69f-ef48-1b35-bbb2-011c12bb02b6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Adrian,

On 5/11/19 7:57 PM, Michael Schmitz wrote:
>
>
> I'd have to test both the impact of missing IDE interrupt support, and 
> that of code size when using either the old 

Code size comparison (replacing legacy IDE by libata): Total: 
Before=2979865, After=3101692, chg +4.09%

120k increase is a little much for me to want to try with my current RAM 
size. I regularly get processes kicked off by the OOM reaper when doing 
a bit of IO loading as is.

Cheers,

     Michael


