Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ECFC433F5
	for <linux-ide@archiver.kernel.org>; Tue, 19 Oct 2021 22:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59489610A1
	for <linux-ide@archiver.kernel.org>; Tue, 19 Oct 2021 22:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhJSWqu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:46:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21126 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhJSWqu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 19 Oct 2021 18:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634683475; x=1666219475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uFfvRas/FyHHUdMnZTq/4JJLQ/pVEIPdN6hlYXTVOhs=;
  b=aS6yZJ9Xxqp2UjjrXPJH24/dPDcIjezw7zxz7J/14G+vI0y+cNZu/sP2
   iAbN1+6Ff9dbb0pPYDTB/9jn3MHBu/DRb4W2ODfoizH/7VmgeJozqUdC7
   DTRXOAPFNObGlu//nfXAyEceZw7frZmzcxQqC1DTv66CxIZLeVlElxXa/
   G7I+zsmwRLqfkgERA6MXA9aCZaOX1WvrTjov6Xmcv2wYO1/y++C6sEcOg
   sjjKfQt2aVEG4A9TTUHKrnPx6MnnRhPZRoPmm8n7dQq52osxWAYzY7mrE
   aBYNjfEpB6CpK9gxbYoM7bYCGHV1sbXASykJr2+y8mrjFQsWOlVOxtwxz
   w==;
X-IronPort-AV: E=Sophos;i="5.87,164,1631548800"; 
   d="scan'208";a="183350330"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2021 06:44:35 +0800
IronPort-SDR: 6iFLJZ37G4Qd3CZMZXuKnRZOKQZFOH6F5QtaeNfmvLyVxJ3luKnM0dPHvQ1GzSNyfEcie5kfhj
 mfCmmP7SX2bepnsaLhcZR5WKjZNiCLJgKK0U4js+Qp+aDUXQBgVZODvrQ6Qf3pzbeC1ozp/7zZ
 CmXc/+J5AY8zTp6jauqfmkIuGhftQFbQ2VM1a4B6mnQvaITaE8PYhLeGyxLz5VdpG3LsFraP3h
 VilBtlZRv3rtTbj+O3N03PknieQ0gOSnpuL2ZlwwdwWL/YqiFy5jyIS3V5uXyVjagNoe3JWjA1
 jIW9iLWZrOEO1wnLg33plPPt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 15:20:14 -0700
IronPort-SDR: TQKUu4wYc7OmZ3amzCVuMmDFwgzYKbJt/Y7r8pk+ORG03g6R7MJVpyvdhZn7L5MvJd7lnCFeVb
 zB8t8wTjGo3UmTucfRhia6E5rgw2d8Sq7cloU41Xes4elOqehccFRTGKGJtjD7ZOv/JN4Q99zE
 kp9F2GF12VRGwhA6xQUOsUWj9PalPEv8IYcP6FIbyelm53DHVbdyPTLSxT4Op0YsG+46gCtszF
 q8ZMX7crJbcVK7DqB1rBK9v8xfwJnEUX2T5sv2jyB32HOMW1I3Du3V7nHQAec2dEKXQbGTOeFQ
 4wY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 15:44:37 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HYphh3zS0z1Rvm0
        for <linux-ide@vger.kernel.org>; Tue, 19 Oct 2021 15:44:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1634683475; x=1637275476; bh=uFfvRas/FyHHUdMnZTq/4JJLQ/pVEIPdN6h
        lYXTVOhs=; b=p9LleWJinhzIDEzufBRHlcYRfnuVf3bFKs717oIlyfLWvFgz6GE
        euyhD13XCodgGcSOt4DeyUk42B+C5VC5ZvAn+GMHYxwUMWUT2pXyn2BowxKF86we
        FEdsnYy8SPKEBTyCRh0GIxlMr6vjB3AFJ8lAtl9nIkscd9+tDjgC8b3OCKRTvAu4
        hfo4Uveg/k9TJx2/wp86QRBd/bQ74f1oSHsBxQnjN2A98iqkAPXnisZzyuoiLupQ
        a/cbGpqmRa2Ma87NeQFCQM/nKMJeOGGbbaUfNQt2ZrqG64FgbDzQRlM+POjNWN1P
        RdzGdp/S4VSX70FQutW/Bu3EA03ti1yejKw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hm68UqgUofLk for <linux-ide@vger.kernel.org>;
        Tue, 19 Oct 2021 15:44:35 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HYphg20CNz1RvlZ;
        Tue, 19 Oct 2021 15:44:35 -0700 (PDT)
Message-ID: <af043ccc-6287-47d4-d5b5-7bbef4e3380e@opensource.wdc.com>
Date:   Wed, 20 Oct 2021 07:44:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH] scsi: ata: make ahci_sdev_attrs static
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-ide@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <1634639082-1007-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <1634639082-1007-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

+Bart

On 2021/10/19 19:24, Jiapeng Chong wrote:
> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>

The patch title should be:

ata: libahci: make ahci_sdev_attrs static

> 
> This symbol is not used outside of libahci.c, so marks it static.
> 
> Fix the following sparse warning:
> 
> drivers/ata/libahci.c:134:18: warning: symbol 'ahci_sdev_attrs' was not
> declared. Should it be static?
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: c3f69c7f629f ("scsi: ata: Switch to attribute groups")
> Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/ata/libahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 28430c093a7f..8a6835bfd18a 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -131,7 +131,7 @@ const struct attribute_group *ahci_shost_groups[] = {
>  };
>  EXPORT_SYMBOL_GPL(ahci_shost_groups);
>  
> -struct attribute *ahci_sdev_attrs[] = {
> +static struct attribute *ahci_sdev_attrs[] = {
>  	&dev_attr_sw_activity.attr,
>  	&dev_attr_unload_heads.attr,
>  	&dev_attr_ncq_prio_supported.attr,
> 

Looks OK to me.

Bart ?

-- 
Damien Le Moal
Western Digital Research
