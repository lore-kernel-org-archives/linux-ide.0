Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8F2C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 01:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1111D600EF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 01:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhJLBIG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 21:08:06 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33208 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhJLBIF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 21:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634000765; x=1665536765;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ujozDCylpTjnhRW0fHwwhsw5ux57HbuU8ib0WoqmCRY=;
  b=ktMNwXSe3NbR/fuv6mk3LOHryN1JI2AgUbBygtMN5kCV03Ncff/C1hjR
   ZkFFaB+Wd6HymFyRN4357sOpEbaTC9JfXtOhy5pvWww0EKBVQyUVot/dT
   SkPaw3SD5mPIVWwRumlGC0d+DqmsrKAvu6XkxewXclZLlPudJxBTRCVrC
   gvN5psZUXQsrJ8zzLY6s0xVxhyBSCxtwgH9lQVZdhfFhqBsgE0EfzFLK/
   CCB2i9Yw0Io0IG0HJpqnPzWAMIvWfQj7RBRfYv8xQtBuluH2KcFst3fvs
   JJ48ZEmjQoLdZZcHjP6r5vGUt0CKliGB8VU8dwFyBqfVVpoO6q6r0Wn8j
   A==;
X-IronPort-AV: E=Sophos;i="5.85,366,1624291200"; 
   d="scan'208";a="294274416"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 09:06:05 +0800
IronPort-SDR: 6NADKG0Jy2jy+t0DiLn0YQd4W0hE3ZNjX71h56j4q9T0KIpswJZfLFmdPsbBzgKaGFW8HZkZ9u
 xmS9ehwK0nHd/kKsDZGaLX6H0Ez4YC+J1zq1WDdgkyMI739hB/Y229L014wifQJUlIUKydI/pl
 b8zPY2j2Q1w2pbDHMLGuJMaW3hA4tP198nXfQlwUTctXFaNxeYHXz7hs1vum2NLH5W4x2lP7hf
 FU2ScGVOAzrZXYQF+On1sWYU/Csdewy5pex208A5Y61iZaih4r9lFZw+cuUUaO9y45uDTfQTDm
 ++TXUKuCwNwnd8kmvdTZcTPC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 17:41:53 -0700
IronPort-SDR: 1d7ngqazu+umWYYjdBrG1EgulYPgHnQCCjCT+Z74kMqh/0/HxBu0DRt7vRX+B4wH5V9s5rEBGv
 D1TIqK7+9poury1V4/fnWmqt44RC5GD/8oEmp/OZW+N3lZkgO4u+d+Tmfc6WmdEDyjoYnxKifB
 hoSSuQlAKP+Y2ArjE8Vbs/v6xy4S7kQFKnbLCRMNE8Wl9n19F58Tg2MwDhO4QyjR7KEgREA+PG
 vHI2NKMdFG/I6IvUUhquEuqhHV++3HJ/WCOme0hT4cjVMsdIstFZpQITAGlSvb2uzem2ROdEWs
 p6M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 18:06:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HSyCc4Brdz1RvlJ
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 18:06:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1634000764; x=1636592765; bh=ujozDCylpTjnhRW0fHwwhsw5ux57HbuU8ib
        0WoqmCRY=; b=BBbHg5Jt1pbWCF+os2YrMrzE9BL+p9R1yqdd3n9RmBpwpf7eicE
        UufwA7Jt+lypIJLjPgNPxxGZpz3LIT4dhEp6f72yekmXxKwGg2dIM39k3q+sXg6P
        fACNgISUIPwT6K1YaB/8/r+eiLpd2HBJQZxJPvtgfvz7sZbzMenwDaKKeqKimJL0
        /EZxSKAcYd9b5lCsZbxBl9tJ6oSLNguMjoigaLMog4SI1so9iago1CFHtSmoqQmi
        gHK44wRL/DVwVEuHKk5zmMXDd1LOl9fB7R/KRt47R6j8qJE5eing3wOYhXm4au2E
        8El596k6kX/Pz33xOBmDkvNRo/EyGGc6/XQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qWGpPAmRlGn0 for <linux-ide@vger.kernel.org>;
        Mon, 11 Oct 2021 18:06:04 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HSyCb4FCpz1RvTg;
        Mon, 11 Oct 2021 18:06:03 -0700 (PDT)
Message-ID: <974dfba6-915e-c3d6-53f6-473be18faf80@opensource.wdc.com>
Date:   Tue, 12 Oct 2021 10:06:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] ata: atp867x: Cleanup pointer value print
Content-Language: en-US
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20210930030533.1216577-1-qtxuning1999@sjtu.edu.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20210930030533.1216577-1-qtxuning1999@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/30/21 12:05, Guo Zhi wrote:
> Pointers should be printed with %p or %px rather than cast to
> 'unsigned long' and printed with %lx
> Change %lx to %p to print the secured pointer.
> 
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  drivers/ata/pata_atp867x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
> index 2bc5fc81efe3..c32b95f48e50 100644
> --- a/drivers/ata/pata_atp867x.c
> +++ b/drivers/ata/pata_atp867x.c
> @@ -447,11 +447,11 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
>  #ifdef	ATP867X_DEBUG
>  		atp867x_check_ports(ap, i);
>  #endif
> -		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
> -			(unsigned long)ioaddr->cmd_addr,
> -			(unsigned long)ioaddr->ctl_addr);
> -		ata_port_desc(ap, "bmdma 0x%lx",
> -			(unsigned long)ioaddr->bmdma_addr);
> +		ata_port_desc(ap, "cmd 0x%p ctl 0x%p",
> +			ioaddr->cmd_addr,
> +			ioaddr->ctl_addr);
> +		ata_port_desc(ap, "bmdma 0x%p",
> +			ioaddr->bmdma_addr);
>  
>  		mask |= 1 << i;
>  	}
> 

I lost track of this one. Any v3 to be expected to address Sergey comment ?

-- 
Damien Le Moal
Western Digital Research
