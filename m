Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB91FC61DA4
	for <linux-ide@archiver.kernel.org>; Tue, 14 Feb 2023 03:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjBNDsA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Feb 2023 22:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBNDr7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Feb 2023 22:47:59 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565F7A5FA
        for <linux-ide@vger.kernel.org>; Mon, 13 Feb 2023 19:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676346476; x=1707882476;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l0mY84/+xzzrhA1jyDyWN/uuydQg2vBmxsgee2/4u6c=;
  b=kE7lsBnY7pgOidGTkSZcfi9vzVacniMAglea4IRYg0EMyEsaJ6Z3mG/J
   STyMts/M/S08jvFSUozlC/XO88ECP5eftqLM8yc9PS5qqd95Jh3eMtMdy
   HaR5LT6cxG0wFTnHBt/+UtAPlv0l4dlW+x0a25bsOqaLrmIcVBzbCTh4i
   UY/3sZWvvorzmEoojOHx8qCwXWWhPBqIxqqX2hKsB/tw3lS7fQgA4nVhY
   Nz/yzo0SJFL6wCe7XtNEEIygz9q+VDn+J5fqHbuRB+8bRInonXXF/uXRU
   p4Fg96U0vyiCspZwZPxmydt6wkYTzRBYnAQpoHdmSMtDiMLTC6ZD3z8FG
   A==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="228205522"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 11:47:55 +0800
IronPort-SDR: jAAHtYq2EhP/0+RN2FujheaAFX0j7zK4avZjTkK+X+QWWdEhSoClIHNOVJ8Puw7/DuHoOT/CAx
 rmjXSxmvIsNwdwPItMA7NfgPm1PeHr12FdxffHfu3OuM4962xxxSC5hZ/TbH0R+/koqxUGACro
 mM9K8oHp0VjiVi32yB0JAevb0XBWZEG1UFyA5aYpr9Rv0d2ah4QK4EVacDe2p6hWFVGHMn3qA1
 HWzXm5Sf6uZKoAZAARARNJ8gVl/5ixvv9jAevJ8n0KG5Wlh2Z5wkqqkdPWAOX0X+IS4GdJbnh5
 +Ls=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 18:59:18 -0800
IronPort-SDR: pAl1A6w8hStnKQske5x79G3vQGkVbKq3FITjRkZ7BTJhxdOGOEK517yV78983JmmYxwLAHnmdz
 qcy6r4HcLWfYh2frvEBGB3Glwzi78B7k0bh9SPbR53Otht6es5pPrizzxG7xlavVl86bF7IkQM
 3+9rLTwlQ2kfdWr4aqb3nm1LCTv84tV+ONjmy3l+52vIQrNCqJJPemgm56OGPkjfObhfR5kQb6
 Fr4bF9hTcmqyL5QFgiJyM5Hgh1rvX+ptiE9iEHPpjoSahSQb8yg19dnsmKEYNupyruvHfCGs+Z
 lFM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 19:47:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PG6cC0mLbz1RvTr
        for <linux-ide@vger.kernel.org>; Mon, 13 Feb 2023 19:47:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676346474; x=1678938475; bh=l0mY84/+xzzrhA1jyDyWN/uuydQg2vBmxsg
        ee2/4u6c=; b=rEp1EvjnGMsIhsFQZEvvlliHU0pQif86ZN40fcU9W6nugUqi/38
        NSgTO5vAYK/xWR9flh8+exFIPp00izvEQ54cEdkITZb9HDz/Sjj0xn1plFiL4CY5
        JBS+WATD4Mxk8thzQO8NYQJO/qejDWlKGV0Dmya2laNQArrTvWsG3xkXSu/yqe3+
        6cXI+hl1IWQIwgV49QGLmM6WISTcUnyx/JOs+0OqijHck8vcohpmf4fYM+XgGPfK
        fpHG5Qe/4gPt5i3oGDMXGNbr5MmfC4M16htlrUA2rYfZgCbH5lgQO6aabW/KBJRD
        CdXyKqeAfonWT/c4p0Yvsib3nkfmj5bsAeg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MOBrXzHPTUQx for <linux-ide@vger.kernel.org>;
        Mon, 13 Feb 2023 19:47:54 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PG6cB0LMDz1RvLy;
        Mon, 13 Feb 2023 19:47:53 -0800 (PST)
Message-ID: <48330abf-31ee-d0d1-7542-6d6a2de71dfc@opensource.wdc.com>
Date:   Tue, 14 Feb 2023 12:47:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ata: pata_hpt3x2n: prevent potential forever loop in
 hpt3xn_calibrate_dpll()
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <Y9pyzLUShZJeLDq7@kili>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y9pyzLUShZJeLDq7@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/1/23 23:10, Dan Carpenter wrote:
> This code accidentally reuses "tries" as the iterator for both the inside
> and outside loops.  It means that the potentially the "tries" could be
> reset to 0x1000 and never reach 0x5000.
> 
> Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers.")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/ata/pata_hpt3x2n.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
> index 617c95522f43..447dc287a2d4 100644
> --- a/drivers/ata/pata_hpt3x2n.c
> +++ b/drivers/ata/pata_hpt3x2n.c
> @@ -380,14 +380,14 @@ static int hpt3xn_calibrate_dpll(struct pci_dev *dev)
>  {
>  	u8 reg5b;
>  	u32 reg5c;
> -	int tries;
> +	int tries, tries2;
>  
>  	for (tries = 0; tries < 0x5000; tries++) {
>  		udelay(50);
>  		pci_read_config_byte(dev, 0x5b, &reg5b);
>  		if (reg5b & 0x80) {
>  			/* See if it stays set */
> -			for (tries = 0; tries < 0x1000; tries++) {
> +			for (tries2 = 0; tries2 < 0x1000; tries2++) {
>  				pci_read_config_byte(dev, 0x5b, &reg5b);
>  				/* Failed ? */
>  				if ((reg5b & 0x80) == 0)

I am assuming this one is the same as for pata_hpt37x: a false positive ?

-- 
Damien Le Moal
Western Digital Research

