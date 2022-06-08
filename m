Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F005CCA47B
	for <linux-ide@archiver.kernel.org>; Wed,  8 Jun 2022 06:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiFHGAI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Jun 2022 02:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiFHFsN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2022 01:48:13 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46E23D5601
        for <linux-ide@vger.kernel.org>; Tue,  7 Jun 2022 20:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654658430; x=1686194430;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5aTc0zGIBR98gSkiP6r5YNvDp2b/8RM0NgQI3dhvwvE=;
  b=qfORwkITembeO0rXr2euy2+WCs6X3yryUuGe0mpLSbETKs0uwmU16cz7
   I5G7IMZweGmgsdUJMlxHE1E9uY6eLr00PAbnpYi6ohAayB+8zktpFzAKZ
   rVcuVqhX6cJvuOg7LMJRP6Wc0Ixbp0cXoc3EOAAZ82H4FS7dr/MrS4Dwv
   M6Oi1xxXJt+wAYJ/7byLYw6/iuAFXLA3zFfOHSO67xRoinHLxlTMNAdDQ
   9MVnx8OorRHccnwXs9jl3op8NHDWKoL/WqxOVRdx8aM/+WvbEzjdvHfl9
   YL8L/4n4Wvk9h16gPjllfxiv5UZmSZbV6mEKFAtj9W9zB9tvk7mBTkafi
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647273600"; 
   d="scan'208";a="207407095"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 11:20:17 +0800
IronPort-SDR: WG3q+/X8rF9Jw7h6KHMyXAx+WPhgez71cyODzf+lalJUgsGIBCYgGArtu8INCiMYZr3TdkLN9Y
 3J6ZdGDPw3o4IymFQ+3BsRzNdShFk9N2e0WUeh0bCHbODlBnouo7/7lyYnDXm7Nm8DxLGYj8GL
 Mq5qeCqexqOSuNo33onv2gVL2ug17SBvfbJ4enBPpsJxf9KCtvOKqc8Qt0RAxlDa1qfAIRpn14
 vzgzEH8Hh2vfMAjuLimD0YzFc/YicYAlEaV3L5sVrAB1sYdV2n0rDOT7LOU2F+/Xt9OuKCBh1c
 cWPzFTlj6c7VP25EO5ZmDQkX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 19:39:07 -0700
IronPort-SDR: YjomxpvVsehCLCMI4n1lVsLANjQPLXDAMCEN4VlA1AKOS2dKtXzOe5TmUysyEPuZC+l7QlcxgQ
 IHq3MXj4fzVwODfgpGBp20w7kzEYtiTH/0V5HTdVx218/rDSinNK5BMv7boJiqu5NbfPpeOvsI
 uTviCnoPe5/XPdcxZdy/SJevhS1G0lzQbT+jbQXJQY6/Vb5HoVyvSTrdqHVxRjasxxIfo/tuyx
 taRU19uAnNxVYMkOgSJiwGPuHys+/tH/ZL3LN4dNmuob+6YewHRvDoDpGol/KWuTNVxfptyXgK
 OrI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 20:20:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LHst93ZPQz1Rwrw
        for <linux-ide@vger.kernel.org>; Tue,  7 Jun 2022 20:20:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654658417; x=1657250418; bh=5aTc0zGIBR98gSkiP6r5YNvDp2b/8RM0NgQ
        I3dhvwvE=; b=sMak6/lgEQZQwRCXtBHwbUPN/xB8///9DZfFe95CBPc709AGUlx
        Vhx/+GCa/qz6ZwF9DK5kBP4atYObTZ/qgH5LjncWb1bpW2ehAlj+xc/PGs4NYcy9
        Phgk7SFQ0WTSPlN1HLc+oQQ1zRYTADzWZheMOzJ1CtDzPuT3P5TSoyp4M72Fb9I+
        odCJv3Z1C7v+80PWRpSNiTSPP0z+QiPVj36/WQP0gJcJ5CWF5+LJEwnqT9R6K/Qa
        cjvr6UVqg27MuDtAX4Q6G/KpV0+lqxzbpmxD7pL/2enJQomwloHR1V/bsmGVlx0p
        AeVZHXJp8tRMTym52OIQPDeAVcBxUR+sYnA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id um2E0KLVi2bd for <linux-ide@vger.kernel.org>;
        Tue,  7 Jun 2022 20:20:17 -0700 (PDT)
Received: from [10.225.163.72] (unknown [10.225.163.72])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LHst80tNSz1Rvlc;
        Tue,  7 Jun 2022 20:20:15 -0700 (PDT)
Message-ID: <d20bc449-874d-a133-6f16-ef6c02732d6f@opensource.wdc.com>
Date:   Wed, 8 Jun 2022 12:20:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/3] ata,sd: Fix reading concurrent positioning ranges
Content-Language: en-US
To:     Tyler Erickson <tyler.erickson@seagate.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        muhammad.ahmad@seagate.com
References: <20220602225113.10218-1-tyler.erickson@seagate.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220602225113.10218-1-tyler.erickson@seagate.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/3/22 07:51, Tyler Erickson wrote:
> This patch series fixes reading the concurrent positioning ranges.
> 
> The first patch fixes reading this in libata, where it was reading
> more data than a drive necessarily supports, resulting in a 
> command abort. 
> 
> The second patch fixes the SCSI translated data to put the VPD page
> length in the correct starting byte.
> 
> The third patch in sd, the fix is adding 4 instead of 3 for the header
> length. Using 3 will always result in an error and was likely used
> incorrectly as T10 specifications list all tables starting at byte 0,
> and byte 3 is the page length, which would mean there are 4 total
> bytes before the remaining data that contains the ranges and other
> information.
> 
> Tyler Erickson (3):
>   libata: fix reading concurrent positioning ranges log
>   libata: fix translation of concurrent positioning ranges
>   scsi: sd: Fix interpretation of VPD B9h length

Applied 1-2 to for-5.19-fixes. Thanks !

> 
>  drivers/ata/libata-core.c | 21 +++++++++++++--------
>  drivers/ata/libata-scsi.c |  2 +-
>  drivers/scsi/sd.c         |  2 +-
>  3 files changed, 15 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 700170bf6b4d773e328fa54ebb70ba444007c702


-- 
Damien Le Moal
Western Digital Research
