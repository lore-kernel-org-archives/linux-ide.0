Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918A3C38A2D
	for <linux-ide@archiver.kernel.org>; Fri, 21 Oct 2022 21:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJUVCX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJUVCW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2022 17:02:22 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7CE152C50
        for <linux-ide@vger.kernel.org>; Fri, 21 Oct 2022 14:02:19 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1olz9h-0004G2-LU; Fri, 21 Oct 2022 23:02:13 +0200
Message-ID: <165565d4-f391-b13c-b450-26f115bb4cf9@maciej.szmigiero.name>
Date:   Fri, 21 Oct 2022 23:02:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US, pl-PL
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
References: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 0/3] Improve libata support for FUA
In-Reply-To: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 21.10.2022 07:38, Damien Le Moal wrote:
> These patches cleanup and improve libata support for the FUA device
> feature. Patch 3 enables FUA support by default for any drive that
> reports supporting the feature.
> 
> Damien Le Moal (2):
>    ata: libata: cleanup fua handling
>    ata: libata: Enable fua support by default
> 
> Maciej S. Szmigiero (1):
>    ata: libata: allow toggling fua parameter at runtime
> 

Thanks Damien for the series!

I've looked at the code changes and have basically two points:
1) There seems to be no way to revalidate the FUA setting for an existing
disk, since it is now only taken into account in ata_dev_config_fua().

As far as I can see, this function is only called on probe paths
(and during exception handling), so if the "libata.fua" parameter is
toggled the new setting would only affect newly (re-)attached disks.

Previously, this parameter was read directly in ata_scsiop_mode_sense()
(specifically in ata_dev_supports_fua() called from there), which could
be called to re-compute the FUA setting for an existing disk by
re-writing the "cache_type" sysfs attribute (as described in my commit
message).

If that's indeed the case this severely limits the usefulness of having
this parameter runtime-writable, and I agree with your discussion with
Hannes that it isn't probably needed now (after all, probably nobody
has an explicit "libata.fua=0" in their kernel command line, since this
was the default setting anyway).

2) It would be good to collect known-broken disks from the similar FUA
enabling attempt in 2012 [1] and add them to the blacklist upfront, so
these users won't have to report them again.

The problematic disks reported in that thread were:
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ATA-7: WDC WD2500JS-41MVB1, 10.02E01, max UDMA/133
> ata1.00: 488397168 sectors, multi 16: LBA48 
> ata1.00: configured for UDMA/133
> scsi 0:0:0:0: Direct-Access     ATA      WDC WD2500JS-41M 10.0 PQ: 0 ANSI: 5

> [    2.845750] ata1.00: ATA-9: OCZ-VERTEX3 MI, 2.06, max UDMA/133
> [    2.845754] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
> [    2.865726] ata1.00: configured for UDMA/133
> [    2.865955] scsi 0:0:0:0: Direct-Access     ATA      OCZ-VERTEX3 MI   2.06 PQ: 0 ANSI: 5
> [    2.866722] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/111 GiB)

> [    3.934157] ata1.00: ATA-9: INTEL SSDSC2CT120A3, 300i, max UDMA/133
> [    3.934266] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 0/32)
> [    3.954145] ata1.00: configured for UDMA/133
> [    3.954441] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2CT12 
> 300i PQ: 0 ANSI: 5
> [    3.955233] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 
> GB/111 GiB)

Thanks,
Maciej

[1]: https://lore.kernel.org/lkml/CA+6av4=uxu_q5U_46HtpUt=FSgbh3pZuAEY54J5_xK=MKWq-YQ@mail.gmail.com/

