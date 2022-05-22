Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E88C433F5
	for <linux-ide@archiver.kernel.org>; Sun, 22 May 2022 08:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiEVIqq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 22 May 2022 04:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiEVIqp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 22 May 2022 04:46:45 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8C0B46
        for <linux-ide@vger.kernel.org>; Sun, 22 May 2022 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653209203; x=1684745203;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=OxPmtkHxyhjfDFblUo+FZjxeHCX2jb0gtibYxRUFnF4=;
  b=aXaUfyibq+XVL397oYmbSQeoGJ9uyJOnjOe6YXpMJ8Z3l/wo+FDOSBac
   Q144oE3B2ZGWIjET/Pkif5tiduMK+1MJyOYKbF2pRTqQeRGVRJxDVEHym
   RKIeE5UPTE4dNEIH1Uuo0BQpEaUvfKEfPhqmOPpcq5TVBJ8ZIbxSI80qg
   VBSSGfaH1HNuF5OdyPlLnf4OB1XMuO8g/oYkDfwct//Q8XcYmt6vkQuqo
   7iAPzqnByylpBPcJN2gC9jog14Jo+07VAwAnOLp1UbdytF6O5rkj9T487
   qVyNMxgGXvJHxnLddo6jfpU59xX07j30cpNaRSkJVgpAF3UOXysi+8DF6
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,243,1647273600"; 
   d="scan'208";a="305276718"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2022 16:46:42 +0800
IronPort-SDR: ooMxO2FrNplz2fBUbfHSheKwHisjk/ES8g2waAZi2/hMEeJX6QSQ92aM30DjUxGN+czQoUl3dE
 NKtV2tg6gbvwBXjO58ytOyDgKMNERkw/KFopET6cWoblu8r9o+l0zD7nnup6oIUoGz5sB9/Znm
 mE5JqqVGb2w9sButj0dcVBWGy4pxiDE/l5i9Qq7PMu/V9pxwR0W5g4JXtXe34SR3c9hBL/oQt7
 LywZwzaS2nNymIaWrH10udf7BFlafzpt4EZuhBgx9xo9u7GnFGDfxHEKE1+7elFxa3fI1X/QR5
 MXCT28E5y3Gt6vhXCD2uuQ8V
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 01:06:17 -0700
IronPort-SDR: 2QGblR91FpXdwdOtfY26fzhWNN/UuaDl7MUa6YosEYLj6F2x0MEiddLlqmLhJF9XVCuE3Ny/Pz
 O7dvVCcGzz+YPqtHFE7rZu93lXZCNalAcpvIx1y1jZJLlC8fgpgYMjOqEgcs4pt+/63vZEMBNr
 ktKKslircShSISOYFcvbTyV5ZxgwOxlRX0KaMfNEVAhsduHlT9irS5MOCpmEHpAZLyZnhzCGEd
 6AAsbv/ag/W9LHDn2YAeKumKOjA77KeS0/kMAgTZK8aUn1TlDGhjp0kRUP6bdE7QkYFKJ+ZRUc
 QHc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 01:46:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L5Ywf3Y9Kz1Rwrw
        for <linux-ide@vger.kernel.org>; Sun, 22 May 2022 01:46:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653209201; x=1655801202; bh=OxPmtkHxyhjfDFblUo+FZjxeHCX2jb0gtib
        YxRUFnF4=; b=qlkPMuIxPGLnjeP5kuFSRt3JPkGcG9RSWrdzER6PXJWxsw5eYY+
        XTRVE+2LxMQPgh2bfku8bErts+KzNbBTNDTOGXZJKP+FmzM05nwi5IVflqvXrIeR
        NvTM8DbNdeqdHrjKUZraOK17PWIY1fRnECoK3ihquawqbTmRjaa+VZE79HxUalQE
        TTOcGtCNNb+JGEEWjt/IGjuFnbGWZzgKm9ToU/lj7bdzWy4YTEBp77V17EkRCPRm
        rF/iy086VQeRUwTY4uMj5CRZxyn4ZDrSQFHfePKuBKNiA4Quq7Y0E+f9oKXxR3ef
        GDkp4nWJC1u5qnVRa7kewm66xbqwbx3up5Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ckV4HDcS18kH for <linux-ide@vger.kernel.org>;
        Sun, 22 May 2022 01:46:41 -0700 (PDT)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L5Ywd0qV8z1Rvlc;
        Sun, 22 May 2022 01:46:40 -0700 (PDT)
Message-ID: <dfedd541-bf22-2d62-427d-7f9e408cec59@opensource.wdc.com>
Date:   Sun, 22 May 2022 17:46:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] ata: libata-core: fix NULL pointer deref in
 ata_host_alloc_pinfo()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <3727e0b4-3958-283f-c0cf-6b8b898ab018@omp.ru>
 <d2d4a222-b3d3-b3a6-41a4-db2fc4c11038@opensource.wdc.com>
 <ad4ace86-1c79-371a-077b-250461837542@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ad4ace86-1c79-371a-077b-250461837542@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/22/22 05:00, Sergey Shtylyov wrote:
> Hello!
> 
> On 5/21/22 2:45 AM, Damien Le Moal wrote:
> 
>>> In an unlikely (and probably wrong?) case that the 'ppi' parameter of
>>> ata_host_alloc_pinfo() points to an array starting with a NULL pointer,
>>> there's going to be a kernel oops as the 'pi' local variable won't get
>>> reassigned from the initial value of NULL.  Assign &ata_dummy_port_info
>>> to 'pi' at the start of the *for* loop instead to fix this kernel oops
>>> for good...
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>>> analysis tool.
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>
>>> ---
>>> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
>>>
>>>  drivers/ata/libata-core.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Index: libata/drivers/ata/libata-core.c
>>> ===================================================================
>>> --- libata.orig/drivers/ata/libata-core.c
>>> +++ libata/drivers/ata/libata-core.c
>>> @@ -5470,7 +5470,7 @@ struct ata_host *ata_host_alloc_pinfo(st
>>>  	if (!host)
>>>  		return NULL;
>>>  
>>> -	for (i = 0, j = 0, pi = NULL; i < host->n_ports; i++) {
>>> +	for (i = 0, j = 0, pi = &ata_dummy_port_info; i < host->n_ports; i++) {
>>>  		struct ata_port *ap = host->ports[i];
>>>  
>>>  		if (ppi[j])
>>
>> I had a fight with this one a while back as the build bot was complaining
>> about this a while back.
> 
>    Hm, what exact tool was complaining?

It was the kernel 0-day build bot for non-x86 arch, can't remember which one.

> 
>> pi cannot be null in this case, but silencing
>> warnings is good. So OK.
> 
>    At least it shouldn't be NULL with a tested driver... I found one driver (pata_cs5520)
> that sets the port info array entries to &ata_dummy_port_info on disabled ports, hence
> was my idea to also use it...
> 
>> Just one nit: please move the initialization of pi to its declaration to
>> avoid the overly long for line.
> 
>    It's not _overly_ long but OK. :-)
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
