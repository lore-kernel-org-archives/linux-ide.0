Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB5DC4332F
	for <linux-ide@archiver.kernel.org>; Mon, 17 Oct 2022 02:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiJQCmr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiJQCmj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 16 Oct 2022 22:42:39 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2711B46861
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 19:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665974558; x=1697510558;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QY0u7ICpt8MfqNelOMrbRKsalTZxawr4laQpXP17/b0=;
  b=kLZ7eiEilovutm2sEBPuhDe4mnZNOBKJb1CRUeGfu1aRlrEViQlLzTkT
   Y5q2gogW9CH96Ql5hckyG0B6/zfGuspPbkr7WztXN/5ZtBVs/LQ82CD9s
   wWJxThHDSSb9p1ahxe6h5Xcgaexqk1qmjNDcDEq0AFdePIGhZzRpA6/DV
   dgpWx/2P35Kg0JUb9+fipkg/zym03wjCBSG1FIJOcF1yKteoF9vN+MCK0
   5+XynC2OZyToNGLDaYABcuTYXeH/gG9yfUWgHdDXvMDMhqMSuFx9KKmY/
   PJG/LyD7XaNRfiyNkU1Az2NttsKvEtXoJRnZ/pSj/RmiRsnqzTzkfvleT
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="219132011"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 10:42:37 +0800
IronPort-SDR: L0BDHFMAfgEE7RtMrUTqF3f3oJVrC5nosNxISWueHirO0+nOm3bHV8o/CbsDYE89gHqS7r02+x
 2QXF7t2j5p5oJl9iwsQEJv8ZlAGkmarcTXlbDdCZMKJ7hjHOPvmOGUHP0v8Ydpha/BE0d+kakC
 aZTIDNRN7QX81C33xK2c7fmgXqqQ+Uy9sqQs1JoddyQNYPS5ml+l8AZKFAdamgaPK17k8uo/cD
 BM38R0L35vx7Nn6CBwAc4dysl+zkWRt39Mtn7YeYZcYKaX1kDS1ULjLuZLMXwIYEWPO1yTnow2
 C1ezHPMfWnIrvIS0UDcwaAzn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 18:56:31 -0700
IronPort-SDR: tI7VFa9daJAb2Cms2eyxO4tp/N1Jsd11zniC/e0ZBCj0VsuVJjAdxZHp8Gn22Tp6+Z4epC8MXw
 W0ix9tT1KpQa5DPNF73AcAq4cNY842rcwJTFoOZau/N9zJGThsVX8xuhHYPyK6k4IkxcU4P3j8
 0o7r3Hj/MKfD2X/WQe8KuCPgowaX1AP4gIZaizhtms8+qP9VkpDLc30kkw+m7Z3/Zcezq2x/aY
 cu+qK3dEIKcA4bp8sIpC6kixG6yjAawRmbn2PRW0Ns6pRswGhpKRsgXiqqmdDrV+Up5/9SMksl
 Qsg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 19:42:37 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrLrF06Kgz1RvTr
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 19:42:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665974556; x=1668566557; bh=QY0u7ICpt8MfqNelOMrbRKsalTZxawr4laQ
        pXP17/b0=; b=FBsI1Lt97Bl8DZZ3zFPS1ruC+D5oGNwyBZ4BbiKyFUj3MhWUZRA
        PIGtTCo6EcTQkVgUX1rW630mJknUTh0D/oSacYj8QUn3KhXirv/nrRz7RJz/GwJV
        D8HA1O4V+x6eWPlz3OhTNwbwtMtzdvJywlfC2FLqAPBeoZwuChBkEWDJ5+WjqEFQ
        X4MTh4PH3rh5IkrwsqWwGW6YRJehd8MnxkhJd7DhwGiSnoIACljofNI+BpkqHICT
        f4xjAtesFtPCB4z8ovIr2Y0yD1Mjpl8xn7AoWJiSLa0+/U3R+ApRdZNcJkUSLE6O
        W8XiPir7BxKTTLHyxtZtWFaeFrt1A7pTGpw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Af8csF-W2fVg for <linux-ide@vger.kernel.org>;
        Sun, 16 Oct 2022 19:42:36 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrLrD1k4gz1RvLy;
        Sun, 16 Oct 2022 19:42:36 -0700 (PDT)
Message-ID: <ed1a8723-c3ff-3ddf-b300-b9c5ea59432e@opensource.wdc.com>
Date:   Mon, 17 Oct 2022 11:42:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ata: libahci: read correct status and error field for NCQ
 commands
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20221003194652.1166130-1-niklas.cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221003194652.1166130-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/4/22 04:46, Niklas Cassel wrote:
> Currently, for PIO commands, ahci_qc_fill_rtf() reads the status and
> error fields from the PIO Setup FIS area of the Received FIS Structure.
> 
> For any non-PIO command, ahci_qc_fill_rtf() currently reads the status
> and error fields from the D2H Register FIS area of the Received FIS
> Structure. This is simply not correct.
> 
> According to the SATA 3.5a specification:
> 11.10 DMA DATA-IN command protocol and 11.11 DMA DATA-OUT command
> protocol: READ DMA and WRITE DMA (non-NCQ commands) will end with
> the Send_status state, which transmits a Register D2H FIS.
> 
> Likewise, in:
> 11.15 FPDMA QUEUED command protocol: READ FPDMA QUEUED and WRITE FPDMA
> QUEUED (NCQ commands) will end with the SendStatus state, which
> transmits a Set Device Bits FIS.
> 
> So, for NCQ commands, there is never a D2H Register FIS sent.
> Reading the status and error fields from the D2H Register FIS area
> for a NCQ command, will result in us returning the status and error
> values for the last non-NCQ command, which is incorrect.
> 
> Update ahci_qc_fill_rtf() to read the status and error fields from
> the correct area in the Received FIS Structure for NCQ commands.
> 
> Once reason why this has not been detected before, could be because,
> in case of an NCQ error, ata_eh_analyze_ncq_error() will overwrite
> the (incorrect) status and error values set by ahci_qc_fill_rtf().
> 
> However, even successful NCQ commands can have bits set in the status
> field (e.g. the sense data available bit), so it is mandatory to read
> the status from the correct area also for NCQ commands.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Given that this does not seem to create issues currently, I applied this
one to for-6.2 on top of your autosense series. This will get more testing
in linux-next this way.

Thanks !

> ---
>  drivers/ata/libahci.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index cf8c7fd59ada..d30c1a4c11fe 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2034,6 +2034,20 @@ static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
>  	    !(qc->flags & ATA_QCFLAG_FAILED)) {
>  		ata_tf_from_fis(rx_fis + RX_FIS_PIO_SETUP, &qc->result_tf);
>  		qc->result_tf.status = (rx_fis + RX_FIS_PIO_SETUP)[15];
> +
> +	/*
> +	 * For NCQ commands, we never get a D2H FIS, so reading the D2H Register
> +	 * FIS area of the Received FIS Structure (which contains a copy of the
> +	 * last D2H FIS received) will contain an outdated status code.
> +	 * For NCQ commands, we instead get a SDB FIS, so read the SDB FIS area
> +	 * instead. However, the SDB FIS does not contain the LBA, so we can't
> +	 * use the ata_tf_from_fis() helper.
> +	 */
> +	} else if (ata_is_ncq(qc->tf.protocol)) {
> +		const u8 *fis = rx_fis + RX_FIS_SDB;
> +
> +		qc->result_tf.status = fis[2];
> +		qc->result_tf.error = fis[3];
>  	} else
>  		ata_tf_from_fis(rx_fis + RX_FIS_D2H_REG, &qc->result_tf);
>  

-- 
Damien Le Moal
Western Digital Research

