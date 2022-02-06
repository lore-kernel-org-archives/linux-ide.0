Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8059DC433F5
	for <linux-ide@archiver.kernel.org>; Sun,  6 Feb 2022 02:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381510AbiBFCCZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Feb 2022 21:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbiBFCCZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Feb 2022 21:02:25 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Feb 2022 18:02:24 PST
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CBEC043186
        for <linux-ide@vger.kernel.org>; Sat,  5 Feb 2022 18:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644112943; x=1675648943;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=jg7K02+BvA0oDRwMFhzy1/LV8QWjpxmHAFxQobEoB5Q=;
  b=T5g/NQzS0pYKh+dgwYxl1z23ZBldukgg23w+TykWnxeUHql1wb56pCE5
   XdoW22uMdxP4lIqEwXFf8hURULPnwPFxCon9hLfmClNzkh84F83ibzmOa
   x9Im2xmH3mPPQVFXi58QEHvZUvshy6se/goNSYKYi5myE0tgnkZLMk4uB
   sRG/vHytOclRjntnjlUTP//TLXfbkjI3djN3wEL0gaLraYsxc64cturGT
   Go18KBjjCcjoUEH+EEmouFRxYvkkx5Ll56OaJxikMZrm9Um/aqd+gU5y7
   hxSMuthO4w/2CcVssRkY/6hhw3gdZrInvpeDhkbuL8Yv4ILORMW6HvPEh
   A==;
X-IronPort-AV: E=Sophos;i="5.88,346,1635177600"; 
   d="scan'208";a="197060502"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2022 10:01:20 +0800
IronPort-SDR: zhnpaFb63S8Tyxrrt62fVEgL8mH1DoXithR0MprPA2Es57QdyoJ/u4WXhhm6kGdlO4opKmDy4h
 ry0oij84Cctx5su2xAo6kt6lo7UU7NYXvRhtRJf4yYMyhpsOHwgmVYUNRmpryxCwBUbe2PjfP9
 JO1m4tygF+2+qd40EGw18A6Hrk9I4QJA7HtcBAP+L+OQYc3NN7m5tfCNsaCwvI8J+WbYL47Wnp
 naXQHQL1uAed/4AeU3MRDgqHeHwcwLJVYa32k57h+PMeucB/FquozAhJ/9Fdb4/gKH9VGVuurw
 PyKP9fMhYIEfWSxAvAei+5kL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 17:33:14 -0800
IronPort-SDR: sWub+/gR0fUd5r7z6rR4nbMLzC4wCqf6EWDWAu5+gY73FZua5O0GE3DuCbP7NxN0rm7NKIApOJ
 6nJXpuhTGR7gW5g0dyvyP7hyupyqJSv/GlfZGT9AOHxOC/H5NYX6Rj9WFZxTxWT4Q4PfRMokRq
 ZOf5mobxeOOIXhgLZ///CKD2S1JZLodN+xD6i46w94qcYlnSEfQr0akfx7SPvkQhtE69I/5rqF
 6L0X/kKdh1x03ydpes3Qwl6iew9ebV3U/G4oMN6b/I05Jl2xYE4cFnzJtGRwJmZAXFptvKYEgP
 m9g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 18:01:22 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JrsvQ0bzmz1SHwl
        for <linux-ide@vger.kernel.org>; Sat,  5 Feb 2022 18:01:22 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644112881; x=1646704882; bh=jg7K02+BvA0oDRwMFhzy1/LV8QWjpxmHAFx
        QobEoB5Q=; b=AnnD2gXUvGnXf5hmTinBKCcPrc9HYRu6LBsSzLVxxnBCto4wlbT
        sF3dHye3OXV2TukKORv6tzKtEm3ta4iOioyLtOTgeYGi+PfGqNUG6Z/vPYP1AmzG
        Yn56bXTOZR4AMYn9MU9DD9MjAms+XQE547i/Z+vZ+r7CdwHodbihcCaIkUysAei5
        OESd1WA8a4JdlMAThpHPbdOKLgU5MwWFB+7nmAHDb0Ygyr85XhabF3tFY0GG5cbM
        Q2D46rDDONtske62Sdjz0RizWyaBPZ0jl6qM7/m2/xmjY3VHfkRSWgiheQOnXkG+
        Z71xwvOlARp1zjJCTMfGnjgF+aSYLiJDz9Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YjjDCSywqHxW for <linux-ide@vger.kernel.org>;
        Sat,  5 Feb 2022 18:01:21 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JrsvP2z3cz1Rwrw;
        Sat,  5 Feb 2022 18:01:21 -0800 (PST)
Message-ID: <987579a5-6a16-34b5-cb8e-d037f442402a@opensource.wdc.com>
Date:   Sun, 6 Feb 2022 11:01:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 0/3] Use *switch*es instead of *if*s in the Artop PATA
 driver
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220205203434.15339-1-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220205203434.15339-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/6/22 05:34, Sergey Shtylyov wrote:
> Here are 3 patches against the 'for-next' branch of Damien Le Moal's
> 'libata.git' repo. The driver abuses the strings of the *if* statements
> where a *switch* statements would fit better...
> 
> Sergey Shtylyov (3):
>   pata_artop: eliminate local variable in artop_init_one()
>   pata_artop: use *switch* in artop_init_one()
>   pata_artop: use *switch* in atp8xx_fixup()

Please change the patch title prefix to "ata: <drv>: xxx".
So "ata: pata_artop: xxx" in this case.

> 
>  drivers/ata/pata_artop.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 


-- 
Damien Le Moal
Western Digital Research
