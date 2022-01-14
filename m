Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A16EC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 14 Jan 2022 23:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiANX1Q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 Jan 2022 18:27:16 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:36291 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiANX1Q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2022 18:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642202835; x=1673738835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oC+N/ozRE1XowFqsw9S3bU3zsJg0XlpsJZHrF5sQzqU=;
  b=aU5BUzXHEK1pRsGp0JebQr/BW6hlNOT72+jdbeLbR2QoHLs+r5y85uTc
   KW2SPuotRnNR5dMcU186/pYKhrE0mE/xeZhbrnpFX2m6cU0z/EQkJSRLI
   tHMDeAFwaPuQ+PlWHvYGNHUYeof1Wtrjyzzv1DCKsjYE8Twn/PkB9216D
   TsJdcLev/dFooRPeu6G81H885IID+0M/VwcC9kaw1SG6VngVFTkMlfqb7
   HTj8kJxYdjXJvFXUi95uuPVn1Yo94ilp5WaYi1lq5eh8EbBpHn9MaHh27
   YLtnDtRtyyrfCZ+JMKsDrb/fRbMIiflQoN/7qbsEGm1lziiQL2yfzrSwd
   A==;
X-IronPort-AV: E=Sophos;i="5.88,290,1635177600"; 
   d="scan'208";a="190505454"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2022 07:27:14 +0800
IronPort-SDR: Jv9zIp3jCNmbhECEQtzbQfLZ8E29pUGUoZpZoJMguP6NJgE2Domefrs3ukEVM3/DbNCSNZ4NGL
 2o19U2oiJ6mArN7kzX/pZOSIiWVWnCeapoyuVagKLpl5yPKHeg6mF+KvezCIs0VUvEgxESqlrU
 Z8/D/3sYIB7Mr334RrxtJDUr009kAV7471b9o4K1DCAIn/4iMOJIa2yu0yt2fjWuvw3Cq/chr9
 9nl7+J7zeiH5v9Uhjxn3YU81qDKid6JMe+aU4hranx3ITF64pyZQb2da+IdumilgQOYWReWvUv
 3RailV/U71V6IuQC6hQTLv5J
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 15:00:53 -0800
IronPort-SDR: EeMWAYYzxQNjI/kuein2seSIYoUtOHQ/edWV3h565dpjLbhxXebOkhfM8ppb5IYDQJ3z5NS8bG
 3ZRtjN0B7Lhu3HejPMxbBYvcUVBdYFlL/Ff/HA5bD4Vl1ptvqAsU39ruEmHLOyovRfJMVZ2wK6
 sorOTgNl8grohbEz+pO95+2rkb71+Rgh0UG9fqrQV5lR9NYlP+F8wzQ+Kbmkv8qx/3fL9vjnB9
 gCYSotHgrLxZhLciIufZkh0SgcxWOCQWWkelVTIsIpH1Y/41f/bNdmesB2JjDXO/tp3QMQu0sf
 1jI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 15:27:16 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JbHWl4sV6z1SVnx
        for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2022 15:27:15 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642202834; x=1644794835; bh=oC+N/ozRE1XowFqsw9S3bU3zsJg0XlpsJZH
        rF5sQzqU=; b=FEM48wI2OZgt9pEwBeOFTPAdyPbakajsWUnGUNREDlcNQfOpIgw
        NAb0vwBnGJbTsUg4BOgkQH1JESItx/XtBHuk0wVhB0XTKgewrlNopqS43d0iNSAu
        TKQJM4XrzUy7DE68UtrCUSfBOSY1OhXQuPL5e+huFS2j7ap+Awte+Els1Zfj/c/9
        fpxmAzepV7YM5mLgIujb42KIDd1+pWUm7c5sYG9Ff5hp6Ydyc4vPTiBv928nX1+O
        ABN9F28LK1NqR08OBshEZ7hybC6AiFDOHOg5LcIQVYYriFUlb8QGYpveSyu4kQZa
        hsDW2jd/bmP1eWd+1xhE3gmGZYyL/FrUqQQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2roogM0gJa2h for <linux-ide@vger.kernel.org>;
        Fri, 14 Jan 2022 15:27:14 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JbHWk3GsNz1Rwrw;
        Fri, 14 Jan 2022 15:27:14 -0800 (PST)
Message-ID: <c365e182-d531-9854-1ff7-9c97d5af9544@opensource.wdc.com>
Date:   Sat, 15 Jan 2022 08:27:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [GIT PULL] ata changes for 5.17-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-ide@vger.kernel.org
References: <20220114065906.622181-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wggW9TzY90pB-1Rfpqm0erxbKO++BR7AOMh_E7_o7cdwA@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAHk-=wggW9TzY90pB-1Rfpqm0erxbKO++BR7AOMh_E7_o7cdwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/14/22 22:54, Linus Torvalds wrote:
> On Fri, Jan 14, 2022 at 7:59 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> ATA changes for 5.17-rc1
> 
> A number of these commits are not in linux-next. Why?

That is strange. I have kept my for-next branch in sync with for-5.17
all the time and got several built-bot warnings that I addressed.

> It looks like you have rebased things very recently (and looks like
> you did it a week ago too). Or maybe some patch-queue system, or
> whatever. Why? If it hasn't been in linux-next, you should explain
> what's up.

The last intentional rebase on 5.16-rc8 of the for-5.17 branch was to
check that there were no conflicts nor any problems with the fixes in
5.16. I did that because Hannes series touched a lot of drivers (if not
most of them).

I am not sure why the patches do not show up in linux-next. As mentioned
above, since I got several build-bot warnings, I am confident that this
went through build tests and passes. Or am I missing something in the
workflow ?

Stephen,

I am almost certain that you are pulling patches from libata for-next
branch since I got build bot reports and you also pinged me directly
about these. Is there something I am missing about linux-next ? Is there
some other request I need to send to someone to get patches pulled there
too ? I was under the assumption that your pulls end up creating
linux-next...

> As it is, I'm traveling, and I'm just throwing this away because I
> don't want things that haven't seen the build testing that linux-next
> does, since on my laptop I cannot do as much build testing as I
> normally do.

Understood. I will get this sorted.

> 
>                     Linus


-- 
Damien Le Moal
Western Digital Research
