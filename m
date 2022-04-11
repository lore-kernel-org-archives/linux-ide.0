Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D971FC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 11 Apr 2022 23:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiDKXFk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Apr 2022 19:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiDKXFj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Apr 2022 19:05:39 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290181ADB9
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 16:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649718204; x=1681254204;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=yHz3k3qAxKrgUpXulgsnmuMslxwfeiqdWxLjFzVwBqs=;
  b=DEIIWp/alUndL0ufyeU7JgPcYTr80nDubIjRADVEyPJuCqzzomiEva5A
   +pWA1vbh6ompQKbGlJHwHYXxEFOQAx0jL7L/zfVQU1lI65vR4INRXpwdF
   IXvuOnimxu6gC+3Vp98mxN029WwCOGwUMwoKwQmrZ3ILMDHmGRsVqiFMY
   uX5crtaEbt7SSeI7IwrVXTBtG+Nwc0ExlM2QvQzPsFCL4ZHT3M1VeQ4nM
   +4A8m4j1qnD6KNtsoKLEqHcYBYwV16vSE0VJDbwK5IhzZkCbWv7bUTOjs
   hZzNxBUgiMjyinpdYe87ZctlbA8Vru+jb6cwd9JZGd+cbf9YCkClHtf63
   w==;
X-IronPort-AV: E=Sophos;i="5.90,252,1643644800"; 
   d="scan'208";a="196538483"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2022 07:03:23 +0800
IronPort-SDR: F7DtiHqkR9I7fnelfzAGePUn4bxK8zCzB8cmHoUja167it/VTfUMBDpsWVU+5YkadrUAAnZav0
 cNSRCa8z/cL54uGCPdX+N+762eC1vvgN+BPxKopyR9QnOfZOkNpeZcKHKTEnNFWC9CqmvNhKgm
 /V822ZFmLknCLmz2IpvZ3Zk0Zh9WD+nHlqthZ/afuIBgaV9FsHgDESJ2OhsMQEuT26JB503geV
 1fv08aMZx5m+r/15clyJDfj8qUe2svxSGVw5/f7pSkatrY5PtukUC2pFNP7vdAOt/72V7NcFEE
 ttX/5N8soK8XLjWGvzU9Zv29
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 15:33:51 -0700
IronPort-SDR: efDOxbXO3CZcWHqVjglEwUehLYqq+is0FfC0/X2t/uaCPRhddk2RrL7iLU7XV3+RKIbNqGjNru
 nlpzLfIjB5vMG1eQFba/u+A9HqrZa6hmJd7AYjF3eaS4AXnGFDhhT3H2ILm5dyE+AB2LmQkRiV
 29HKJx+72nSO1MOwJgKZ7J+uUmD4/0C/lspnXCa3F+toQstzkdx5nWJAMGv04ZZKx64LABNoBB
 H/W/THct/ADYtIyzf+1hBzmemdZ51rknBib1wAeXQYxgOfTNUoqhkWhtqRzlgpXb3CE5zDolgw
 XTM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 16:03:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kckt312DHz1Rwrw
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 16:03:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649718202; x=1652310203; bh=yHz3k3qAxKrgUpXulgsnmuMslxwfeiqdWxL
        jFzVwBqs=; b=c1Dl7L2Q+CALNk6Rp9aKtmtDwHIpWnz0hu1LKLLZv00gWtVijFk
        6mB2G+LPuAxtSyj2SCCfANyphltCa91kuSF0CGlEease7Lg3GoppQu2NzoEITkKG
        JrdsSEOQ5CoDLiQqg+pfxrqYADMZ/ZJro4RDl0gcWZYYOSxpLi6/Ks03efk1Z3JG
        svTkVSaJtqtoxiQ5OVW5pHHnIYSYlM4aZQlwzPYSrCPYDGYSGjwgK7PYV0+lKI5n
        VFPad6KOspeR3jj4apztlEzsheCvdSNuzgGpvEVj682pd4zj60IW3/yvplvyGjY3
        hdHGWROOA8hyhpKMWJuYNzAaxwCUlOQi7BA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hTuB1DmYjcgR for <linux-ide@vger.kernel.org>;
        Mon, 11 Apr 2022 16:03:22 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kckt236y8z1Rvlx;
        Mon, 11 Apr 2022 16:03:22 -0700 (PDT)
Message-ID: <0abe1b22-3686-f04b-253c-9d53692e5ca2@opensource.wdc.com>
Date:   Tue, 12 Apr 2022 08:03:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ata: pata_via: fix sloppy typing in via_do_set_mode()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <009887e0-8c99-928e-06d0-e2e5882cf6ad@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <009887e0-8c99-928e-06d0-e2e5882cf6ad@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/12/22 05:34, Sergey Shtylyov wrote:
> The *unsigned long* variable 'T' is initialized with an *int* value
> (luckily always positive) -- to avoid that, declare the 'via_clock'
> variable as *unsigned int* and make the divisible constant *unsigned*
> too.  While at it, make the 'via_clock' and 'T' variables *const* as
> they are never re-assigned after initialization -- the object code
> remains the same as gcc previously used copy propagation anyway...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
> repo.
> 
>  drivers/ata/pata_via.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: libata/drivers/ata/pata_via.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_via.c
> +++ libata/drivers/ata/pata_via.c
> @@ -248,8 +248,8 @@ static void via_do_set_mode(struct ata_p
>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>  	struct ata_device *peer = ata_dev_pair(adev);
>  	struct ata_timing t, p;
> -	static int via_clock = 33333;	/* Bus clock in kHZ */
> -	unsigned long T =  1000000000 / via_clock;
> +	const unsigned int via_clock = 33333;	/* Bus clock in kHz */
> +	const unsigned long T = 1000000000U / via_clock;

This looks OK, but via_clock is never used apart from here. Why even
bother having a variable ? I suspect this was a mean of documenting the
value meaning. To really clean this, I would define T as a macro...

But looking at other pata drivers, they all do something similar, and many
of them have the same type issue. E.g. pata_amd:

	int T, UT;
	const int amd_clock = 33333;	/* KHz. */
	u8 t;

	T = 1000000000 / amd_clock;
	UT = T;

Also, ata_timing_compute() takes int as argument. So I do not think that
the type change is mandated, unless that function is changed too, but that
could lead to a very large set of changes. Unless these are causing
problems, I am tempted to leave everything as is (apart for the clearly
wrong "static" declaration of via_clock).


>  	unsigned long UT = T;
>  	int ut;
>  	int offset = 3 - (2*ap->port_no) - adev->devno;


-- 
Damien Le Moal
Western Digital Research
