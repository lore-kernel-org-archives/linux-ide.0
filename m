Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBDEC433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 01:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiKGBIe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Nov 2022 20:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiKGBIc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Nov 2022 20:08:32 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667F1D79
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 17:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667783311; x=1699319311;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f2Poyf+DRbjJbxM3eA9BGDaLBWfUrwxatFK29YJWYYo=;
  b=ClZuPJdHzzbB1p6fjNjzx0SS6OOclqa1B3tGwtodhYzIU+8mvlzfMb3+
   Fs+zHIBPgawGMQbfEKBhlUwViC4ZcASaKj0h2oFteYdlNxH0CZhMKTKz/
   PtFeC/VW22m5gI2yfmtn2sxqEZqPp2EKOV0ylWOWxrxGN/VpOYS3TGiyT
   uLpDg6prF2TLK8gl4Ze81wEyC9CmfWZ/ijdXAul5uHJYC9RbJlAKHmkYQ
   gbAMhim8nFZZNUVr6PYuo3lG0MyJtHQRSZ5/p0XbVMfwIrur9BPYZaL1J
   GxqA3vCmRpnR/ZXfYpVNR8Ka+2Ep8/1kuJnT8XQGnpEBGVmQZ9WYPkKqM
   w==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665417600"; 
   d="scan'208";a="319957338"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 09:08:30 +0800
IronPort-SDR: JAWuu+1fgA+sJ3QG6XZEMZLFPZqCe1m1k9bFCd1P2bW+Nkedx8ltftssywksFzf7uAVJrKpp7Y
 +nBxmuA6tBfE3f2VsY6/djKHBdPhenDUa5sxAB9KwOG9PIFjw0PLWB4USErnaF3X8nNr6w5Lni
 RyrSCmsVT1aOXFa9lTtPZw9PZR8dkThnpehYKHhJpOnybkll8rDNa7mXSpe7nk0mD8XdaG6zZ4
 qHTxgOoA4mTf9/sbiFtU0QyQ9Y5JVbiM7MyAn5zbAt5s9KJ1hYiz598G2ixdvCR+Ee7LalaD3L
 kZs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 16:27:38 -0800
IronPort-SDR: RTWATMiWll+xAEKNe6GTSuiKLnkyTixrB0xVyQu2pr2Bs6DfFNT0udXW2WXgT+WUVom3HlCluY
 SRT/24rRIXvsUAcYBRwP1GiCQnlQFVpZLV4hdy95bufLqJNwTSU8o4M+HRgwsYWuiqse5k673w
 n8l/jzWuMpjznUIIOLVstOTowxScIZKiYnQlN5ZK8RrmSkgflIkCcUETeHFSxY5AzDexzUvGqR
 hlW7/ENb7wr2hGHzVeQ7kowqlB3YmVkavWsyyyzEy5X4ustc22frCjyl/uzFeRa6Mk2CUa7HpY
 3LE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 17:08:31 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5Clx6pbbz1RwqL
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 17:08:29 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667783309; x=1670375310; bh=f2Poyf+DRbjJbxM3eA9BGDaLBWfUrwxatFK
        29YJWYYo=; b=EvVw4UM5oeokZ7LTD/PrTDIW0eKthcO0+K29WFeECL95mfSl0s4
        DiV0xrWwfI0mA/xhzVjzZDxMBoPFpyQCCB60ZK3YBDf7VBS12+tVEN8tCVIoh2m4
        vNn3c2ANYj7/K5lR5zT1+GECsMdEcucZGIAU+gf/WU4eqS0gCtWKsT4RKvZYn3Ek
        68rSMu6NXJ8lP2t/uOojwMGBwHO/daGoBkkIwC5jZxCouY9clrr+w+SNA7hMWxfu
        VLJA73e5FGY42wJNBVBc9iI1hkJIciHHlv6Drqw0wiDRbzOiOw9QNTk+y1pWqmPI
        mXH5fQpn4q0g5lw7H9cpqzGeBbzE3pRLpCg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6JDiqB0x40ru for <linux-ide@vger.kernel.org>;
        Sun,  6 Nov 2022 17:08:29 -0800 (PST)
Received: from [10.225.163.31] (unknown [10.225.163.31])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5Clw6pHjz1RvLy;
        Sun,  6 Nov 2022 17:08:28 -0800 (PST)
Message-ID: <501804d9-8dd8-29be-2ace-e3ff6220c8da@opensource.wdc.com>
Date:   Mon, 7 Nov 2022 10:08:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] ata: libata-scsi: fix SYNCHRONIZE CACHE (16) command
 failure
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-ide@vger.kernel.org
Cc:     Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
References: <20221107004745.1540270-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221107004745.1540270-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/7/22 09:47, Shin'ichiro Kawasaki wrote:
> SAT SCSI/ATA Translation specification requires SCSI SYNCHRONIZE CACHE
> (10) and (16) commands both shall be translated to ATA flush command.
> However, libata translates only SYNCHRONIZE CACHE (10). This results in
> SYNCHRONIZE CACHE (16) command failures. To avoid the failure, add
> support for SYNCHRONIZE CACHE (16).

Also mention that SYNCHRONIZE CACHE 16 is mandatory for ZBC drives (see
below).

> 
> This patch conflicts with kernels version 5.4 and older. Conflict
> resolution will be required to back port to them.

The above is not needed.

> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: stable@vger.kernel.org # v5.10+

Remove the version number.

> ---
>  drivers/ata/libata-scsi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index e2ebb0b065e2..61cd4e90e4e7 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3264,6 +3264,7 @@ static unsigned int ata_scsiop_maint_in(struct ata_scsi_args *args, u8 *rbuf)
>  	case REPORT_LUNS:
>  	case REQUEST_SENSE:
>  	case SYNCHRONIZE_CACHE:
> +	case SYNCHRONIZE_CACHE_16:
>  	case REZERO_UNIT:
>  	case SEEK_6:
>  	case SEEK_10:
> @@ -3922,6 +3923,7 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
>  		return ata_scsi_write_same_xlat;
>  
>  	case SYNCHRONIZE_CACHE:
> +	case SYNCHRONIZE_CACHE_16:
>  		if (ata_try_flush_cache(dev))
>  			return ata_scsi_flush_xlat;
>  		break;
> @@ -4145,6 +4147,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
>  	 * turning this into a no-op.
>  	 */
>  	case SYNCHRONIZE_CACHE:
> +	case SYNCHRONIZE_CACHE_16:
>  		fallthrough;
>  
>  	/* no-op's, complete with success */

This also needs a patch for sd.c to always use SYNCHRONIZE CACHE 16 for
ZBC drives.


-- 
Damien Le Moal
Western Digital Research

