Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33DAC433EF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Apr 2022 00:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbiDLAs6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Apr 2022 20:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242984AbiDLAsS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Apr 2022 20:48:18 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C582F002
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 17:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649724351; x=1681260351;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ozTeDndf0ZSe5Vo8AswFuyzUsKWLPCnUlfExALfYKrY=;
  b=gJrLlPJQTXsJrTZ0cVUn3PGp/dacB/kYNDCLfCeqZCOyZmr1roZOsX39
   +jJoiV52jih2YrFQCvt6qIHb3eBY8T4de88fwyrhDah712CjalRfP05E2
   9dzjd1B3Ajyeh5UIcy+cpu+RQ9ARdB2RtJdFj1zBncvK8kDFFAQVS9CNX
   gRxXsnMhHPneWRr6dpdJdZ1PbsP0tN7bPSq+8paBQ2TpCCBQx9Ffl+k3I
   Nf7rQ/8QCz7Ijzsq11J5li9XvT4rwszlFeSw2w5FWyTe03eE6ct2b9xfy
   RbDD+QCgQ4zmbs9UpD2SeMYhtvMsRD5/O6JqozgTPqY6bEy0smgPQKYc7
   w==;
X-IronPort-AV: E=Sophos;i="5.90,252,1643644800"; 
   d="scan'208";a="197679170"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2022 08:45:50 +0800
IronPort-SDR: Jhc23GzzGPeyNVqMcvDNERYzEkUVGpBq2IuHnxsbUhu8hiLjPoRuYCdKA5579ZtCiWSrACjdRS
 aDwWQMGi0nxLcQnthIS+z6a9GRMjm1KZzhURk2LVvnFOrZY7j2dkUpW3UXyxQ/e6zLhKbRJAOJ
 Ooe6in16dxybW1HKdJzSYnlb0Cn2nURiCRpeBLPkZS7zCPdt3sDio2ujyoGWWP6nYT5DgPD+u1
 JQmORpIC6ekrbzSESJ6Vcqj9JQexcIWmPWcy5attIbvPx7g8J4lv+vmuhbkT8ifbKifkziyX2c
 pfJD95Xui/1PW4GSGfManHxZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 17:16:21 -0700
IronPort-SDR: DUQ0uBbIEz30A2cqY95C0QCT5UlvG2guFvXjTuX0fB8LnAFAocnlpTx9o9R5Xu8FKtFJiuYPWZ
 Xa0+GqZWYuxh1kGEqYFioImm27S1pZRs+yynPeukRzYwINXBc4lgRsRRz1BfiNJcZtFwO+K1zp
 NzWNgB8EBInxzcgNqYAT4kegcdtIoTAWBIPb3x0YfNPUSY5AlW+AODnJ/M2jYoyqYKIc+yWSW5
 I2u4cGa4c0MKbGwGJOopf4ukCo6YY89F1wa/0r4dcqYksU0fL+xXBrw6foTvOQ5xePBw14ntCg
 UvU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 17:45:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kcn8J3B9Fz1Rwrw
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 17:45:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649724352; x=1652316353; bh=ozTeDndf0ZSe5Vo8AswFuyzUsKWLPCnUlfE
        xALfYKrY=; b=YIvwm74VAxB2kiJtKWc/8gGVlZvpdUuQvjrRYAtBe4NQgDKKgyC
        4pahab2vGg8vq6+T3s9LQjgSFXkd4dZE+vx5QMqAQbFwtzpcqQl1GElBGnRCPFRV
        UxtN2KDraaozoPJuZeXO2HLlHWX8zQ0MCKxDwrckD1RVM1rhhqeY6gD2CDdmIrxu
        +IxFZmYK302u5PcltCoVqhE6reRD5sUP7kgHbRbeHv9nTwMvc87rCI4tJ7xo4gvm
        LB3W4QNsBE59J976Mp17VtAjzIC4Nre5h8RwJ4TqR86ThWnBAYLZn9RGuYgTINKp
        WH2pVAcm6SnEPPMb8ozXfOlJ7JeOHaDNSvQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fTg4fPpTW0EG for <linux-ide@vger.kernel.org>;
        Mon, 11 Apr 2022 17:45:52 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kcn8H4Bc2z1Rvlx;
        Mon, 11 Apr 2022 17:45:51 -0700 (PDT)
Message-ID: <8156604b-2d6d-dd3b-612b-ef8a14f96943@opensource.wdc.com>
Date:   Tue, 12 Apr 2022 09:45:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/5] libata.force improvements
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/7/22 21:37, Damien Le Moal wrote:
> This patch series improves the usefulness of the libata.force kernel
> boot parameters to facilitate field debugging of ata drives and adapter
> issues by extending the range of horkage flags and link flags that can
> be controlled.
> 
> The first patch is a simple cleanup of the drive blacklist array.
> Patch 2 refactors the declaration of the force_tbl array defining the
> possible values that libata.force can take. Patch 3 and 4 extend this
> array adding most horkage flags and one link flag. Finally, patch 5
> updates the kernel documentation reflecting these changes.
> 
> Damien Le Moal (5):
>   ata: libata-core: cleanup ata_device_blacklist
>   ata: libata-core: Refactor force_tbl definition
>   ata: libata-core: Improve link flags forced settings
>   ata: libata-core: Allow forcing most horkage flags
>   doc: admin-guide: Update libata kernel parameters
> 
>  .../admin-guide/kernel-parameters.txt         |  71 +++--
>  drivers/ata/libata-core.c                     | 271 +++++++++++-------
>  2 files changed, 217 insertions(+), 125 deletions(-)
> 

Sergey,

Could you review this and/or give it a try ?

-- 
Damien Le Moal
Western Digital Research
