Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A6C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 22 Feb 2022 00:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiBVAqe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:46:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiBVAqc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Feb 2022 19:46:32 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8095255BB
        for <linux-ide@vger.kernel.org>; Mon, 21 Feb 2022 16:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645490769; x=1677026769;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=KMYCoSfwTx/hwmNrvptio3xXkaM5VSayMl0n7BtjPe8=;
  b=Yo+fCR+UqLJ3a4JdAzCvyxeCoSH4DWBfyumfG+rFtLZbsgYQur3LTCaP
   7ZyutzpDxGihR1ZWZwhX2E8rMtmgQdlj6UlDKg5GXi2+hyXoOxBagjqTg
   UTFygKfev6wAQphYZIpbSClpiXt+8fISX2HOZC8PLHag0G9epnSQhCQL5
   TJum9h6OAuczc0gsHWf1Vq49QuERkpRW/24CqvfcV99OGpph5r5WP3QN8
   nJB4GALtTFSzOgXjK6BxW3thSfgPCUd63WS6dZxdNfHcGwZnzVP3D/Dlv
   QoxVBx4pgOLmFVd2Qgv2R3zCqOaH6VEN7IcMKXbgSxOmqY2iwcwY/+mch
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,386,1635177600"; 
   d="scan'208";a="194558654"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2022 08:46:09 +0800
IronPort-SDR: scY63NvDmtkQr9Ibm3Kc/FQ7n5RFhqW1E+D6/4sC7zIvgOYAfXs8GbelubwNOMxvZ1XfxJtNl6
 niJRbU3uHtjpj0cfbQwSHnDfua2Ze+JP0z6bOSI2s4D300Dazi6EJGnmtU9vdxDJ4S3c8F1SYu
 +RsV1wGGzXviBB2E+L2PiUc2ZdJ4oFhvE6DlSK8BZtcLCibRfiZ1TJfTCjiubaUUAqca9iJGeR
 7a3YjR4DpWUtWDVRTH2fGHggV0Fp5qHKEq1t/I6rtfmkmJ+BIPTNdOKNsISEttDIPzOJ4t6FUe
 rd3pttIzlZXge2xxs41Vx49u
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 16:18:47 -0800
IronPort-SDR: wapus4btivoHK9kLiPLqLGGu+HWncFKfGyCvs7c3gn4I6Dd4uJeGc7KV06dQEvuoMMmmGPq3Q0
 ZvQJpPwOnsGkwQw3+hu4hOK28E8vwZrhgLYttIhGA5R+c3Eok1qfaNXZBQAmFb5mbtEoo/AAzs
 WGVFs5kDTDORYnNNLYZ6hCsd3+ZupCu8MkOE+gnIRJGlMN3Tawlh6UKcAdzQo0dCxMc3S7WsYc
 MArG3mmPIBFL3Ld4oxeVTLczmBpndzhrVjLvtmmReSErU8tx97x3NOHRSSgqcoAgpvbYV74m3y
 fQU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 16:46:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K2gTC5RnCz1Rwrw
        for <linux-ide@vger.kernel.org>; Mon, 21 Feb 2022 16:46:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645490767; x=1648082768; bh=KMYCoSfwTx/hwmNrvptio3xXkaM5VSayMl0
        n7BtjPe8=; b=i7LHLCp6c0c3rinyljcCNBxGGf3aEzfcRX/NJZw0KxfkmT2YiyI
        77IWjgp1EbbvvVEN4FUeQKaR+L4enBDvveGbQowqOM2ITAmYjtBcYfnbXt5/BvBc
        zBtKkSOILT2E24I1kXAfbdpUdN6JJgTtNgoEgdZXttFZ8FjZcPyaxtPZNr5GBMAW
        Jjf+FbszfkvNU/nt+EpRyIaPDnCTfWNpneZV+3QaLCAc1FKttjnKCZfexNDqtnW1
        Ij05npVXk+4gZAsgT/tVKRGyHUG1hLg0pL0tTqd1yghkSbqRCPPFCscQaQyiCzGY
        WwFZ6T9Do29CezEkvYwNMrfCQ7AfaqckPTQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id toO9trZnfPrv for <linux-ide@vger.kernel.org>;
        Mon, 21 Feb 2022 16:46:07 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K2gTC0m6Fz1Rvlx;
        Mon, 21 Feb 2022 16:46:06 -0800 (PST)
Message-ID: <0168c09c-4c62-673a-01e3-96b82a56dfdd@opensource.wdc.com>
Date:   Tue, 22 Feb 2022 09:46:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: pata_hpt37x: fix PCI clock detection
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <02715925-4a0f-30dd-86b8-85786cf6484a@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <02715925-4a0f-30dd-86b8-85786cf6484a@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/20/22 05:04, Sergey Shtylyov wrote:
> The f_CNT register (at the PCI config. address 0x78) is 16-bit, not 8-bit!
> The bug was there from the very srart... :-(
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Cc: stable@vger.kernel.org

Applied to for-5.17-fixes with commit message typo fixed and Fixes tag
added. Thanks !

-- 
Damien Le Moal
Western Digital Research
