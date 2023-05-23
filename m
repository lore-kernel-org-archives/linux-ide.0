Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A76C7EE26
	for <linux-ide@archiver.kernel.org>; Tue, 23 May 2023 08:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbjEWIna (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 May 2023 04:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbjEWIn3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2023 04:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C3AC5
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 01:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21D8960C50
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 08:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A56C433D2;
        Tue, 23 May 2023 08:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684831407;
        bh=DduRvrIyhu+COXWSOD3CZj0HXh8S1HYCCjqksNoz84w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bol3LMnBBfxptvOyXNrZ62kUIeOcaQXqUn0c4z+kYecwH0rmNXgBOKWnOFWxbiC5E
         m9BjYtS5fewjrCjk0ABkWE0jkFwDinCKKq5vOOnLiP27W/4H6oQ2M7daPuly65vbxJ
         BEBsRSsqZfBo2Lm52eZLQsX0f0EvgxQ/3drhI8dHYtXxOze51HRh0eCstdwud9B/2A
         k4fcnpgsuo83Rdzg/8bpHscbv7wpc4XZXz+GY06gEiLJRxgcZ4WEybNSHth5oEOeJJ
         XVwlb3TA5naDk0xByp06AsYOpScD0CBQ12HFh3qpDatjHRMYr7zLdNe7SaZ35rtVfH
         Tj9gdcUwv7TVw==
Message-ID: <09265e29-6d89-2876-dbbf-09344536ef8b@kernel.org>
Date:   Tue, 23 May 2023 17:43:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] ata: libata-scsi: Use correct device no in
 ata_find_dev()
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, linux-ide@vger.kernel.org
Cc:     Jason Yan <yanaijie@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>
References: <20230523080443.398912-1-dlemoal@kernel.org>
 <1da247a6-57d3-a2dc-7375-e5a1fb02f9c1@oracle.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1da247a6-57d3-a2dc-7375-e5a1fb02f9c1@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/23/23 17:29, John Garry wrote:

[...]

>> +	 * or 2 (IDE master + slave). However, the former case includes
>> +	 * libsas hosted devices which are numbered per host, leading
>> +	 * to devno potentially being larger than 0 but with each ata device
>> +	 * having its own ata port and ata link. To accommodate these, ignore
>> +	 * devno and always use device number 0.
>> +	 */
>> +	if (likely(!sata_pmp_attached(ap))) {
> 
> Is this function ever used in fastpath? I doubt it, but I suppose having 
> likely() can't do any damage.

Yes, we could drop that.


-- 
Damien Le Moal
Western Digital Research

