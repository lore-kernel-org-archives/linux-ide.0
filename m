Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE6AC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  1 Jun 2022 06:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347868AbiFAGpS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347079AbiFAGpR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jun 2022 02:45:17 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079C895A3A
        for <linux-ide@vger.kernel.org>; Tue, 31 May 2022 23:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654065915; x=1685601915;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=l8gMF+XXTBa+VGU6n/xxml+M4BbI3EYO9tquBMbz4Cs=;
  b=HSJ3lltX2n8hAUTAE6kwy519SAZMUU5xrzrD7KDRrH7MgIdIMEe+Bj2K
   3Uevy4yB9TzigbsMKAF2wPFhn2+38RFuyikv4SXVWIGjHq8hHYwW1m696
   5zF6z7USL2G/dANHQYCDY9SELRhouuNrd/qdEPmddf8GFIRvEcMJN/BJ0
   iSRRqaoGWiOLFUf9zk821IOgyuOd0GiSsn7AqBrXQO+y0p1hXDlxNOBuR
   7AJjEWQeuyXgnicKGNnCz1WFQhQs7C5MPCxn5KXglrc/y6Js9r0y+IwHb
   2VPwNdX4LowR04rxjhjfGKoHcaDMoi4BEQp3BSxd13cD68O5+tdNkNU6q
   g==;
X-IronPort-AV: E=Sophos;i="5.91,266,1647273600"; 
   d="scan'208";a="313985699"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2022 14:45:15 +0800
IronPort-SDR: U/JVXoMgsZAYh5eIS28/qPfoqS04slJRKhxuicZ8LIPeKdex3feedw/EPmOd96i1jLuZ8sWDE2
 UEQ3H1NQkndBR7blQLnXhaqoLdIH+DyCurfQkJ5Dh0I+A/Hg1QVXvbRAtQtB3FWJ0ZOeWVtRyf
 3chLWQLxkHCVTxlfIXpUY6OuZjC6QcFF9kuVUBk86NTFcRjZrWfCD8j5aRXhoOPLMXNYDDRt/z
 wJ92JV6wbT4mLmhuSCGX5AgFcTCJdvnQ9ImzvVHv9dBxWzZ/T0VJ6APR1JjX6Uz5Pitk3Hvj74
 7ED5QrkSJiw5rgewd2yFAxmC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2022 23:04:28 -0700
IronPort-SDR: /59ejgziVasO/35XolhD+cQc8YJ6GFLUnn+rVJyHp0mN+IxpnC/NU2jW8/quj9Ixqdl4cjx6ca
 yt1Re7qcjfuCRRVFAUj63Ee9sSuEDHk0oreyZ5tBMJIc60oglc1oqLp7+MqqFQ0dZ3+oQ5nVH/
 bS0Hdg0SEVTt5dVJyA9oMYBnCv0zHVc+7M0EYTQ0sh7LO1ZaeY2bUcYOzDH1+5ENAZH+LH1Fo+
 5OnQ3S5BtAyrvjMlrTTArqYyCaF4hTCUXOR/QCBRDEf+19RVYGIwQ/gHEOAVkDgYOO4XMqcRhO
 +Bc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2022 23:45:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LCflt6Y8nz1Rvlx
        for <linux-ide@vger.kernel.org>; Tue, 31 May 2022 23:45:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654065914; x=1656657915; bh=l8gMF+XXTBa+VGU6n/xxml+M4BbI3EYO9tq
        uBMbz4Cs=; b=IBenkjvMjJsUFAG1sS0aI2g++JPUMypumw7sSx9irPbrYf4z3Iu
        +alDr14h0/TWH72YoXc0hgpK8XdMm7IVkzeBrD/EhunLK17orKlH22PFwZcK7u9z
        21ijIr1VyhhuBwCa6R8Cd3MZVgDNkCZ3vBSykTJuHZxME9YT1zTcCXi4VsYQO33o
        /MMggk4nnXPZaLSlALAW8RjjQkxAqfVmycgQKAiT0KJslBcju75sXkLiptbQJ9cA
        tQqTztQZY4+RY6gr/k5LK/2IxkUAroEaQoT8TXP4AUgmGtXdwk+kwUbCGNcP1h2e
        q2t4byJd4pC/DyY3nOWtL6MCmdT91rrIikA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ByzKhfxiKLYX for <linux-ide@vger.kernel.org>;
        Tue, 31 May 2022 23:45:14 -0700 (PDT)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LCflt1v9zz1Rvlc;
        Tue, 31 May 2022 23:45:14 -0700 (PDT)
Message-ID: <c66b5956-769d-4c02-6c0a-e5b9db7cc296@opensource.wdc.com>
Date:   Wed, 1 Jun 2022 15:45:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] ata: libata-core: fix NULL pointer deref in
 ata_host_alloc_pinfo()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <a642481f-401c-8098-c6dd-64b15d41091e@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a642481f-401c-8098-c6dd-64b15d41091e@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/22/22 05:34, Sergey Shtylyov wrote:
> In an unlikely (and probably wrong?) case that the 'ppi' parameter of
> ata_host_alloc_pinfo() points to an array starting with a NULL pointer,
> there's going to be a kernel oops as the 'pi' local variable won't get
> reassigned from the initial value of NULL. Initialize 'pi' instead to
> '&ata_dummy_port_info' to fix the possible kernel oops for good...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
> 
> Changes in version 2:
> - switched from the 'pi' variable assignment in the *for* statement to the
>   initializer, updating the patch description accordingly.
> 
>  drivers/ata/libata-core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: libata/drivers/ata/libata-core.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-core.c
> +++ libata/drivers/ata/libata-core.c
> @@ -5462,7 +5462,7 @@ struct ata_host *ata_host_alloc_pinfo(st
>  				      const struct ata_port_info * const * ppi,
>  				      int n_ports)
>  {
> -	const struct ata_port_info *pi;
> +	const struct ata_port_info *pi = &ata_dummy_port_info;
>  	struct ata_host *host;
>  	int i, j;
>  
> @@ -5470,7 +5470,7 @@ struct ata_host *ata_host_alloc_pinfo(st
>  	if (!host)
>  		return NULL;
>  
> -	for (i = 0, j = 0, pi = NULL; i < host->n_ports; i++) {
> +	for (i = 0, j = 0; i < host->n_ports; i++) {
>  		struct ata_port *ap = host->ports[i];
>  
>  		if (ppi[j])

Applied to for-5.19-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
