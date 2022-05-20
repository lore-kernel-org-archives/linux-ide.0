Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4896FC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 20 May 2022 03:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiETDbn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 19 May 2022 23:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345001AbiETDbm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 May 2022 23:31:42 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B6D5B88D
        for <linux-ide@vger.kernel.org>; Thu, 19 May 2022 20:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653017499; x=1684553499;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=CAbCOvt1EWGC27gUGcCeTk0+kssvgvkuEqwWvzEUpDQ=;
  b=BWheW8JDVg7hnqnc/3qqtqGRBcVX7h3P0vx6q+nLXmTYjRYInxF4rRBt
   +TX9OiorFyXHJoDgHN6wjuD2bh3p1v0ZTa77YH8zCRDtiNZQN57uPQiO0
   qf/duRVW2fKLipwQzU2uCTuupYQYvHwtXtI0NV0fqptPEo8efeUZoZSw8
   cFjSEaGcHikMMBpXkD+fhWpy1QWasrDkpjz41mOXQHtaZdow2nrAeFLd7
   4FhBNaeFq9+iTO1FZsSsYS9Sx2tZkKPj4+OU5rCFhkBSL6dNH2Ld9K1vL
   GBOH+TuAIW+HRzEhzs5CF7liGfEXyRWGT89apEhoq7YmOjNeqmQ/VLBz8
   A==;
X-IronPort-AV: E=Sophos;i="5.91,238,1647273600"; 
   d="scan'208";a="200878591"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2022 11:31:38 +0800
IronPort-SDR: Ph8iOQH5CF87y6+1YwmmeC4fTbHn1i6BsfCpOdfZElpP3w4i5G0K9In/ToNP7p/Ywl5Pg69OeW
 D4vDXrwU+1FydUzwT0OJSt2lunnEuMLxadvVxJoGEgk1zbRvTBGrPnI+ZN+l7xDyN6hd0YfcOi
 F+5Z6J2gb4WkPq6qTYar/xU0lcIZxmS58kyw7m99Prh+GNO/xJ6t4Ig1KZvXhyY8UucUSE8yUN
 K3r/3lf3h6OE2wmvkeQ7VUfHE22Mr6ssCcgVKCoLAQ/q9/CIwrOtDXzJxOlU9DCJeaLBkMPE9Z
 LT+01f6ju0Zu0WQFW2JIeQMe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2022 19:54:30 -0700
IronPort-SDR: Ey5XfYWPyn49l7MSoVyRlJogSWRmfImBKloeIZdou8yFVFCzLbBpJ0wNBEtMRh2ODci3hskfNA
 8C/FbE90nIncff3TClKnsnO6KL4tzqB+CK4cKgqQ3mwRr2zhQhZD3TXrQWGq14rUM9BX/qsYPO
 zzZkcSUvJklKYA3pAPtcp1EtL6900CFy64AOGn4McdK0ZWEnGK6WGnlnQeEy1/cFKiVMKnbLE9
 9DTjql9OiA45ht8L9xsl+scjW9AUFKDih+rF85t+EAv6JtWe5PWU/qSZeBVDSZpeBZvjvsy8Uj
 uw4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2022 20:31:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4C236z4Rz1Rvlx
        for <linux-ide@vger.kernel.org>; Thu, 19 May 2022 20:31:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653017499; x=1655609500; bh=CAbCOvt1EWGC27gUGcCeTk0+kssvgvkuEqw
        WvzEUpDQ=; b=nFrhh+QYXBuBwUIn3tsGMzUreYYJSyVQz26YB7Hc4quND+0s6dE
        YbtjOwgax2XUCKcQ/MXypBqO0YzkIj3z+DLJMFpzCXkOuqQbtU16K9jmftvsKYtK
        eI42zKQnYyCVTbgXN4N+xnaHNAUFomcKPeidMKjsLovHCIXzHed028g0EdQ8jNIS
        Q2eGaELfcvG7TvOhauYUjJK2T4Y3Gd3ryhRrEXEY9RudiO85warYProrb2lSGS/P
        Idf9W+aueAr6BrE2INMRWopS+wpHLESnPe7V3ztTYZGPp0+I1oeP0vZ8s0BtI1MX
        T1lkm3dPfyaXEXoqC4f+t1q7XBvNe394UWQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 86iaj75LB68T for <linux-ide@vger.kernel.org>;
        Thu, 19 May 2022 20:31:39 -0700 (PDT)
Received: from [10.225.163.45] (unknown [10.225.163.45])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4C232F9vz1Rvlc;
        Thu, 19 May 2022 20:31:39 -0700 (PDT)
Message-ID: <09e49f39-53fd-ae03-da98-921fa159db55@opensource.wdc.com>
Date:   Fri, 20 May 2022 12:31:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] ata: make ata_device::{pio|mwdma|udma}_mask *unsigned
 int*
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220508204139.4961-1-s.shtylyov@omp.ru>
 <20220508204139.4961-3-s.shtylyov@omp.ru>
 <90824959-6963-0836-3dca-0331e43e161b@opensource.wdc.com>
 <b2cf4a4f-0a7b-7e46-c938-9fa82b09f436@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b2cf4a4f-0a7b-7e46-c938-9fa82b09f436@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/20/22 05:58, Sergey Shtylyov wrote:
> On 5/16/22 2:19 PM, Damien Le Moal wrote:
> 
>>> The {pio|mwdma|udma}_mask fields of the *struct* ata_device are declared
>>> as *unsigned long* (which is a 64-bit type on 64-bit architectures) while
>>> the actual masks should easily fit into just 8 bits. The alike fields in
>>> the *struct* ata_port are already declared as *unsigned int*, so follow
>>> the suit, converting ata_[un]pack_xfermask() as necessary...
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> [...]
>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>> index 1429b7012ae8..f6fc482d767a 100644
>>> --- a/include/linux/libata.h
>>> +++ b/include/linux/libata.h
>>> @@ -677,9 +677,9 @@ struct ata_device {
>>>  	unsigned int		cdb_len;
>>>  
>>>  	/* per-dev xfer mask */
>>> -	unsigned long		pio_mask;
>>> -	unsigned long		mwdma_mask;
>>> -	unsigned long		udma_mask;
>>> +	unsigned int		pio_mask;
>>> +	unsigned int		mwdma_mask;
>>> +	unsigned int		udma_mask;
>>
>> Ah. OK. So you did this here...
>> Hmmm. I would squash these 3 patches into a single one. Otherwise, we have
>> sort-of a mess without all patches applied (making revert a pain if needed).
> 
>    Hm... please explain what kind of a mess... BTW do you really expect a revert?

The mess would be a partial conversion of the type in case of a revert
being needed. And no, I do not expect a revert would be ever needed, but
hey, never know :)

> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
