Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48597C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  3 Mar 2022 12:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiCCMZQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Mar 2022 07:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiCCMZP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2022 07:25:15 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCE7F1186
        for <linux-ide@vger.kernel.org>; Thu,  3 Mar 2022 04:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646310270; x=1677846270;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yf5axKjROfKuKvfCFqp+M8GxRouDBYp/bx1mxWv8bj4=;
  b=UvJXay3aK3Tdpl3ij0T+WyVoVI996ZGUl/Wv1aV2pbYGbykC3pDiH5L7
   fYI2vsrvvtDcMTqck0ZyINY25e6e30/5l5xjH9n6IKZZsmMU7Y6JFxWLX
   o6fYaSdcj2mnKRVTwQtHh849jJmicAIRS61DZi6/2Mt7eobINdlkBciqf
   vGSLRFUFZbqzEMFfnhOnAjq8yvwHRkH0zGskyWBnmak+ElGo7SqtMVTdk
   i/wMBMBAYcQgScrVjfyB+GPdsQLIqueDDoIji3kmuVO476tzDOgILAxUW
   J+7j6+dK4ybaa6061CDYqoWseUnjx7+iTF3kPGA0yJ/Tm7vG3AGwSU7yS
   g==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="195347583"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2022 20:24:29 +0800
IronPort-SDR: CI+wAiRHfTh3DxO+HmW66tPUc+ZcmGUeei2wVOjA72lcBVkdU2ZA59NuRz75THALCINWz1yUOw
 kMBNkOhAHW57GHOR6zjIWXo9LZWbJafWeIMhctYjIbAJYL5Xqy7tA9/nKqb4dn8rNUK+xIt7vz
 H2yd7NTfM50ncbP47cIulgKdFkaVEnvZi/eOAMGeu0yyZiFdzEBfhG1d73PTYHahKpDOUf3g5R
 op5xlLEVahk3la4Q/E+ISPvBlKHy3qcX9wXHik/vKvsfG8nqP20aeXbS4qrdvwPGb6eGlbYIgi
 lrTP1f0Gp8Ym3tMRdIciU4ba
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 03:56:53 -0800
IronPort-SDR: z43mDwRTVsOgtcPrjzGGz5m7GKcdgm83BW9xekgw+OsCb43Kl3kx0TL7AUuclh9V1h2XPsokbF
 8A2DV8aZzcASAswx84yhw6Jk/ak716iPJzX2N+R0fdJOwm6FLNc0pqAjuu4JwlcJJ5+Lwm79xF
 BUMgSUDfC6/dQr0b9veGgGcFGowofqBURnGEpA+rArsapKmt6E1VqhS3d8Q6kBE+N4S7rZoNA2
 afFlpmINdFf/GCGOtBOAxI3iAFw2+Mf78APP3FZqu1cWer1r0S9e6Frk47a3wng17MOhpETmnf
 Diw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 04:24:29 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K8VXr5y8Bz1SVp1
        for <linux-ide@vger.kernel.org>; Thu,  3 Mar 2022 04:24:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646310268; x=1648902269; bh=Yf5axKjROfKuKvfCFqp+M8GxRouDBYp/bx1
        mxWv8bj4=; b=DyRYjVupRe5v3/qUM+nsTSkXijrJG1D4+fUoFbX9TtFiopcGZUm
        9XGN1E3pE3uWCV76kb0JUOsLEX9sBWfqFp8Za6YiyLbbL6BJsB1wYJkzTTfRZM9R
        CtXf/Lvq0i5L4U8vIliVbbMOP08aY2ZdmRLFri07BLX0rajdBXjVkDBVELpaN4nD
        L3xpi1XAsN5L4qsYGjYzZ9BR7LjGLxl9XltXsglimIPKqWvKGai+sZU9vGx73khb
        FY3SFrcaSIzEskNBhPJonlPfhYJQZLpykb8t8sstZdEpwJ6xwE+k9DLcMElzp3HV
        8liR+WlInMIC6AyIpVfWg83hdt8pBrmYSrw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Tpl9zZWI-TcP for <linux-ide@vger.kernel.org>;
        Thu,  3 Mar 2022 04:24:28 -0800 (PST)
Received: from [10.225.33.67] (unknown [10.225.33.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K8VXm47f7z1Rvlx;
        Thu,  3 Mar 2022 04:24:24 -0800 (PST)
Message-ID: <23d62066-1460-2bfa-2922-44c856fa253d@opensource.wdc.com>
Date:   Thu, 3 Mar 2022 14:24:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2] ata: Drop commas after OF match table sentinels
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ide@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <52970494111d9287cc8355e0f2e3de474361c75f.1646296493.git.geert+renesas@glider.be>
 <164630760533.3471399.15267126463863979019@Monstersaurus>
 <CAMuHMdWWYaqxA8W-1CSdOj7HV1V0s_byx=iFe+awbgxwsAh7tA@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAMuHMdWWYaqxA8W-1CSdOj7HV1V0s_byx=iFe+awbgxwsAh7tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/03/03 14:20, Geert Uytterhoeven wrote:
> Hi Kieran,
> 
> On Thu, Mar 3, 2022 at 12:40 PM Kieran Bingham
> <kieran.bingham@ideasonboard.com> wrote:
>> Quoting Geert Uytterhoeven (2022-03-03 08:36:35)
>>> It does not make sense to have a comma after a sentinel, as any new
>>> elements must be added before the sentinel.
>>
>> Indeed.
>>
>>> Add comments to clarify the purpose of the empty elements.
>>> Rewrap entries to a single line to have a consistent style.
>>
>> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Thanks!
> 
>>
> git grep "{ }," | wc -l
>> 2638
>> git grep "{}," | wc -l
>> 2088
>>
>> Lots of false positives in that basic search, but this looks like a big
>> job. Is this something that could be added to checkstyle?
>>
>> Probably hard to match when it's a sentinal, rather than an initialiser
>> ... so perhaps a coccinelle task.
> 
> Yes, there are _lots_ of these.
> 
> I fixed the ca. 50 cases involving Renesas-specific compatible values,
> and picked up the ata subsystem for a first run.  But fixing all of them
> looks like a lot of work, so automation might help.

Thanks for the cleanup Geert. Will apply.

> 
> For soc_device_attribute tables, there are less cases, so I'll just
> send the handful patches to fix all of them...
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


-- 
Damien Le Moal
Western Digital Research
