Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1EEC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 21 Apr 2022 23:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442613AbiDUXng (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 Apr 2022 19:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442612AbiDUXnf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 21 Apr 2022 19:43:35 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE72465CF
        for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2022 16:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650584444; x=1682120444;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DTD+QUfq+qyQqjpjS3+49IUYM4AhsnTjMugrXbtLUzg=;
  b=S2v8LIpbR0hmTF/hyNvl9Xxo7Fx0Q1h9iR9lZK3aTcdQMlqnrVErjXd+
   F0tZzDN1spsOMdFzpognCdXATyqogg5stm9vG65lXYl/ca+uMCLT2zMDz
   c7cXx9i5Aybb50fA0MiQCtMIeEXhCG8S7SAK2jeLLO23ljrVKvJWnjG70
   oKREjUuc7nNCAX/tlyVPu9kgdP52KNfhyGwwCYCvjzFvchc1yAokMcpEY
   YpKtERQIISXiK+Qv54Kn+0HjL5/Gj0myqd6J+SmYDv0pwntB9J1NBYHPa
   RHzOQVg5lEdSgiABH2kxei3dVcAkVor8MT2qfsUdprRH4QhGPU4EgB+Y4
   w==;
X-IronPort-AV: E=Sophos;i="5.90,280,1643644800"; 
   d="scan'208";a="310479414"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2022 07:40:44 +0800
IronPort-SDR: 2AKy6u+bQnPwDL6FmsR2gJt0SemopHa0cWIKQvHCWiSDCsGjgHmpzWbMtPGGI1pL80YQO3NvSc
 pgJqAC6J0LAmsCnONLVQYmzyaAJpwmZnTpOT4xLz/r5wEZR8QxjV2hNzBawlUjenjPew/HJaKR
 FDYfV7wRXmWgA8eSBULrs9YaJ7IAwwMJEu6HmOlEp3zjV0zBsoax/hilLhZ9bn26oe5gZtgEpn
 sI6Urb0Dq4dYTqPIDj/o8qo8U1gW4uwQgqCICiBNFugB3jOlalp5P71Lu8YJJazccjZIS1mw15
 oNdK9qICeBHOGpbSp3XeDzpS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 16:11:01 -0700
IronPort-SDR: VCDkvxmcNjFv2dISfrveN2N33loiFs1jQNLZISadWHzdEcy5VnFE6hj22MGCxFBYGypa0H0B+7
 yTTumvH7AA3tIM6CzOtqEXpws1LMbwkZJdVA+XZCfiwVjriAdnUxO0u6axEHgZb5Dg5SPxbOCj
 wDqUQ6aMSlPmTBJRMV2+T9CztqxUx7WyNQ/2a47HrJNKMBZS+MNL72TKGOkNQF1dtz9vi0ZtoP
 vZ5p9QVy35rXgUUfyIUiec3V16UfOxP/pxIecvl2XVEHxIVfMoIBRy2tilXPt0irMeMt4foCqz
 R6c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 16:40:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KkvDW5fppz1SVp0
        for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2022 16:40:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650584443; x=1653176444; bh=DTD+QUfq+qyQqjpjS3+49IUYM4AhsnTjMug
        rXbtLUzg=; b=NNIvtNP+5Qq/VG9YN2OnL/VFWEMVnWb52HiOHjLsA1x5FPOcUFq
        UQ6XC9lYTQZP8N6FJrfSl9jFRt/7DU9A3CEAYtdRQrAGPkPi+VJKNoArWjqCr4HM
        aOV0sjS+fUpqom4HHbwTfuqmP85A0yqlgPVfxcI6kU3/F4EtAywC/CgQlHFMBYFe
        v4wluF8FzaEewlYJg4oHE7xVcuhjBeO2p9wqBlNcG4N0IKRuhJc7mA0pmZQ9JIly
        0/ho27N8WXmlxz+VKKRj9MSa1XACdmWMSPBdMK+sP2NT6FsWL8peUC4G3e3Ky3Zj
        P/6JlH7VvMbD6xsoGcKpwVxDUASjNcHVzZg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZIrtjB-hi7K7 for <linux-ide@vger.kernel.org>;
        Thu, 21 Apr 2022 16:40:43 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KkvDV2pRFz1Rvlx;
        Thu, 21 Apr 2022 16:40:42 -0700 (PDT)
Message-ID: <1adc3cfc-f7e4-7bec-5308-2fc45a0b3361@opensource.wdc.com>
Date:   Fri, 22 Apr 2022 08:40:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ahci: Add a generic 'controller2' RAID id
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-ide@vger.kernel.org
References: <165051164674.3740862.4706111262486927842.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <165051164674.3740862.4706111262486927842.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/21/22 12:27, Dan Williams wrote:
> Intel server platforms that support 'RAID', i.e. have platform firmware
> support for software-RAID metadata + features that the kernel also
> understands, maintain the same device-ids for RAID from generation to
> generation. This is in contrast to client platforms that have tended to
> roll new device-ids every platform generation. However, even though
> server platform keep the ids there are still unique device-ids per
> controller instance. To date there have only been 2 controllers on these
> platforms, but platforms code named Emmitsburg add a third controller.
> 
> Add the device-id for this third controller and collect it with the
> other generic server RAID ids.
> 
> As mentioned here [1], the pain of continuing add new and different
> device-ids for RAID mode to this file [2] has been heard. Ideally this
> device-id would not matter and the class code would remain
> PCI_CLASS_STORAGE_SATA_AHCI regardless of the RAID mode, but other
> operating systems depend on the class code *not* being AHCI when the
> device is in RAID mode. That said, going forward there is little reason
> for new server RAID ids to be added as they can simply reuse one of the
> existing ids even for a new controller. Server software RAID features
> continue to be supported on Linux. Client software RAID features
> continue to be not supported and the recommendation there remains to set
> the device to AHCI mode in platform firmware.
> 
> Link: https://lore.kernel.org/all/8e61fb0104422e8d70701e2ddc7b1ca53f009797.camel@intel.com [1]
> Link: https://lore.kernel.org/all/20201119165022.GA3582@infradead.org/ [2]
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Applied to for-5.19. Thanks !


-- 
Damien Le Moal
Western Digital Research
