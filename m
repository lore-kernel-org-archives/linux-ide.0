Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F19C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 00:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD68560F14
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 00:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhJLA45 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 20:56:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54567 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbhJLA45 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 20:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634000096; x=1665536096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gUcuTyEJd+Bb2QEDVw2RN4NfIlIwMMfrVK4oNLacRtY=;
  b=r3nGMdbr6KaW+AQGNR8ESn26mhkY3s7Cx29EFKF+m7jP0zZZAMsBmjVK
   JF9z220IYePumw65sD8xdwEtW8/3e7DunCcYD4P3/gtOrmkeqyx1+NW3g
   NeLcJoT3/edMZd3cLHetQXMzRtcVetDK+11uxsbObU7Fy0g5BVHJbTHQF
   QXmMqxw4ang4z5xfi8AXv/LLD/J9ZLDte/ntLf/Dl4a0pil/Wx9Ih3VX6
   fChhaDChhq33tF3yL3rfXxwKel9SQr8tXdjSjrNpjr+pGNE9yPsh7yj0d
   cPktZu3r58r1M3WeapgU8+65TWpYazdkOjAm9Gi5Qqwh+zgIaoXyTgdlY
   w==;
X-IronPort-AV: E=Sophos;i="5.85,366,1624291200"; 
   d="scan'208";a="182551772"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 08:54:52 +0800
IronPort-SDR: 23931y08tBirp0Rqw1cjjruJHNdE4tuXAvgWbk5/3gAy3fblZxhMJyGKyr3xQHAvZ0y5i/6wVV
 CbJym4Ezd+Ay7ii+8Km11h7mMIjZnarF0srfYxtYE+XYYdyqf65EWjWa+wTNB1Ym0QSyH4bTq2
 RmD8ibQ7+56sRQcIUfg4dSB7BoipWhHdBjtbJR0Bhu9OiPVMMW4EQGBn/kFdRL8DfJdpaePH4v
 zt2jDaya3LlN3/3Ud6Dsx5v34e19wVMVrfQijjiIe+koaaVRWdWP7SrW6cejvWGFDPM8iqCppR
 lxOnfF5EsaYuPMQFqMGKObz2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 17:30:41 -0700
IronPort-SDR: FnxocxpJMxkFZOiLcna8nWhK5atHGGmDNh3AkcpHMI8IxR0LZhpA9Q7OUUTYIpCxNDLb0EDVen
 BzyU8WxPpx1UeyTqu8unkkX779AE8kXmYXFHQSyD1wp7D0Wex1a2NEfMAdTfcJTpCrdgD2z9CZ
 tjPywa5OUxEc8Assob4vgS2v9u95EcBUYum1GyQZ5k5TL7o9hibcFR4xj/PwricEfQhioHCjNP
 LIWMtlbFeH83bfVv5KX08z44ZVADBODq2bl/H0keN0u/izZgQbApgTtmqNj9hQ3i1kAEDUUKwT
 qcU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 17:54:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HSxyh5FfJz1RvlJ
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 17:54:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1634000092; x=1636592093; bh=gUcuTyEJd+Bb2QEDVw2RN4NfIlIwMMfrVK4
        oNLacRtY=; b=h2YfItqFZaDfj6bES59203t4l/ennzUKJo6mxKR5Wtq7oRFt+cH
        ak3UVwZoIcUmlz1NcXN8a7KZ/JMqsgHWnoaWGbM5/iLpnzyo5JrUfKCFy+ippNS5
        ONYYv0Tkz7UomPokaWFjzJmfQeWvJd2jqlsPaOFwnxKnLyiLE1sd60rlQr3hNfgT
        BKUlon18UBC01l9O76nsCJ1nvbXfVdKI8uDOa/oTxhFSNnPZcodv0abPVutJDFW+
        wEKT6TDPfnQXzdQQeF+9dttqw852be1CVfMgWjGzwK3C0x7PEZqHppvFYVJhxP7S
        F3+K7EuGLyIf1q4vccdcsBkLRsrVbe0uSVA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eT_0-hXhMgpD for <linux-ide@vger.kernel.org>;
        Mon, 11 Oct 2021 17:54:52 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HSxyg1n5Bz1RvTg;
        Mon, 11 Oct 2021 17:54:51 -0700 (PDT)
Message-ID: <9dc07497-050d-1562-70bc-68daa460da67@opensource.wdc.com>
Date:   Tue, 12 Oct 2021 09:54:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] pata_legacy: fix a couple uninitialized variable bugs
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20211006073419.GC8404@kili>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211006073419.GC8404@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/6/21 16:34, Dan Carpenter wrote:
> The last byte of "pad" is used without being initialized.
> 
> Fixes: 55dba3120fbc ("libata: update ->data_xfer hook for ATAPI")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/ata/pata_legacy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
> index c3e6592712c4..b53f0e09783d 100644
> --- a/drivers/ata/pata_legacy.c
> +++ b/drivers/ata/pata_legacy.c
> @@ -352,7 +352,7 @@ static unsigned int pdc_data_xfer_vlb(struct ata_queued_cmd *qc,
>  			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
>  
>  		if (unlikely(slop)) {
> -			__le32 pad;
> +			__le32 pad = 0;
>  			if (rw == READ) {
>  				pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
>  				memcpy(buf + buflen - slop, &pad, slop);
> @@ -742,7 +742,7 @@ static unsigned int vlb32_data_xfer(struct ata_queued_cmd *qc,
>  			ioread32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
>  
>  		if (unlikely(slop)) {
> -			__le32 pad;
> +			__le32 pad = 0;
>  			if (rw == WRITE) {
>  				memcpy(&pad, buf + buflen - slop, slop);
>  				iowrite32(le32_to_cpu(pad), ap->ioaddr.data_addr);
> 

Applied to for-5.15-fixes. Thanks !
(Note: I added a blank line after the pad declaration to follow kernel
style).

-- 
Damien Le Moal
Western Digital Research
