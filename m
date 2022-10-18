Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65350C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 18 Oct 2022 05:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJRFAV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 18 Oct 2022 01:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJRE7m (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 Oct 2022 00:59:42 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0700F2AC0
        for <linux-ide@vger.kernel.org>; Mon, 17 Oct 2022 21:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666069165; x=1697605165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wEzcwplt8kJCyupDcXus/05M19KXPbEFbO9P8ZHcDEM=;
  b=mzw8XjJwATnv6X1mTsTe66NkYOJ+q5v3YkwZjSYGUgkF5FGG6v0+BPwR
   43yt9e6tYEPAxSucpf5ZLsRlbpvKydkesRvhNt87CC3d7ZG/VrT1Tntv4
   5ZEwqrgH8NaUwYwV6qdLHyOhOF71O9Al+gGX2gMsy6mv+7cAsNPzURUNk
   /2VXrYGtmdYZKukvS92fRSx+li1lHu5zvSi+9r9d/DPrT/19NAPb8VHXB
   aJnezV8yt+JPkPi577rIb15D7vqxHRIlZfy+CsYbwmenw8SqfJMxW4Dnn
   Ger7fGh0HMZiSEtuy+1OOPEV5RU/ag0otsd2j4xZbL+fDk1auU6LCBWpH
   w==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="212411234"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 12:59:24 +0800
IronPort-SDR: 7OAmR1BPpAT7BxlanGGA+8ooqzcXcCZ7KkpEst30Hy+maAeagxuBSgDtHbICUbIfIp+rqvN30z
 qONw4juPSCElfS8JqxQREs8MJCY93jUjDqJs6FKvelXZE2UMNt+XgpHbbKZwOxPkOTBXnFIkOb
 Onh3GcVM3ILNyaY5gOwrqW+ms8jKQ8tEDb8/332lqqQWXQBiKZ5tn0SkkQAhtdWrusgQa+kw00
 vw803vlYerYfC9ZhFF+JIRmxGYSpIW9HSP5ytP85UqNYcsMxFKKr5NjfgqHnWbIGpBZcZzCq+3
 UQpNxIPzTv7C8XDgwj8mSOB+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 21:18:57 -0700
IronPort-SDR: d4VdHHPe7yfnPtnqSrWMUOCMntgXdd3l8t17q8hW6W+iX65x35jIVT7Km4Zy5H9klZcCADuJlh
 jsUG78NPG1nw69xFCkoNute0EETXjZ062N4CsSHYYhiG9djRts1hBNiitj4apeUoCdRIDzG7xi
 LdCHcdKzoANNzBWT15EJkGWTeYNgvejjdjRJl6JQgKgztfnok29VH+3Jo3Mi2qo4WSZlHeplze
 cB1tAvd5QMQrlR3scipt4fVzb+RnOwYSFkphT3kpoChxNNB9vhsHBx9mrL2sHTCNnz5itp73md
 GGI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 21:59:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ms1qc54rBz1RvTr
        for <linux-ide@vger.kernel.org>; Mon, 17 Oct 2022 21:59:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666069164; x=1668661165; bh=wEzcwplt8kJCyupDcXus/05M19KXPbEFbO9
        P8ZHcDEM=; b=Mwvfem1AuR3HwawQDMQTp1SuAm+DOQotK6oyKhYbqFD2znV1D3A
        AG2lh5xyJvsBpEwEVGyLUKixyqX+wMEo6mhzrLk++5WG4/cRqgwQKyCweGuwB9BL
        keoclkPIqsTcLorlKxAmt8tShaFkspge+C/TDQS32U/jK+2wfgRkrbz9hW6+ddWN
        pm/iEmrh9PESJU7y+vYAYjOE+rrHx0OMY+3uWPgbR5h2mMttO4WvLljLxnZTLqFx
        TzJOII2VQFAlxr4KghlzfFsrqORYSfzQXYc0AyekxCZ8rbt5kG+hebHlf4wGPjW7
        TvfBGNPu05rzXpcgZyFP/m8kWf9q4ibwatQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7Lr_Hm_Y7R7u for <linux-ide@vger.kernel.org>;
        Mon, 17 Oct 2022 21:59:24 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ms1qb0cj8z1RvLy;
        Mon, 17 Oct 2022 21:59:22 -0700 (PDT)
Message-ID: <3c638814-4a9f-6506-b556-8ad64d920daf@opensource.wdc.com>
Date:   Tue, 18 Oct 2022 13:59:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 0/4] libata: misc frozen port cleanups
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     john.garry@huawei.com, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221007132342.1590367-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/7/22 22:23, Niklas Cassel wrote:
> Hello there,
> 
> This series adds a new ata_port_is_frozen() helper function,
> and makes use of it in ata and libsas.
> 
> Additionally, improve ata_read_log_page() to avoid a futile
> retry while the port is frozen.
> 
> Kind regards,
> Niklas
> 
> 
> Niklas Cassel (4):
>   ata: add ata_port_is_frozen() helper
>   ata: make use of ata_port_is_frozen() helper
>   scsi: libsas: make use of ata_port_is_frozen() helper
>   ata: libata-core: do not retry reading the log on timeout
> 
>  drivers/ata/libahci.c         |  6 +++---
>  drivers/ata/libata-acpi.c     |  4 ++--
>  drivers/ata/libata-core.c     |  7 ++++---
>  drivers/ata/libata-eh.c       | 21 ++++++++++-----------
>  drivers/ata/libata-sata.c     |  2 +-
>  drivers/ata/libata-scsi.c     |  2 +-
>  drivers/ata/sata_nv.c         |  2 +-
>  drivers/ata/sata_promise.c    |  2 +-
>  drivers/ata/sata_sx4.c        |  2 +-
>  drivers/scsi/libsas/sas_ata.c |  2 +-
>  include/linux/libata.h        |  5 +++++
>  11 files changed, 30 insertions(+), 25 deletions(-)
> 

Applied to for-6.2. Thanks !

-- 
Damien Le Moal
Western Digital Research

