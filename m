Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD772C04A95
	for <linux-ide@archiver.kernel.org>; Sun, 23 Oct 2022 00:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJWA16 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 22 Oct 2022 20:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiJWA14 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 22 Oct 2022 20:27:56 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F9F6D9F8
        for <linux-ide@vger.kernel.org>; Sat, 22 Oct 2022 17:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666484875; x=1698020875;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cKuGSIaM/0/ouABisoYzo3KIVuGAu/ZMvFN0h1mH2ec=;
  b=LWcdnYgwF9ohb4wcBY6dFDPwebn6PpJ/f04//8b4A+9LBOcHLckLJhec
   A6JfclphUew+bxfLMIOvD9rU73qm2Dr1qeSdWq8HIvxDTEjN7rnZgpZFx
   uGpJ39GFrf4zaQUEjr3i8Yaqy7pal5EyY9uVnMtIqg3kI4/FON2jNIs8G
   oHZowCSZz+7XAIiHUo514Bwe7YdqKcPEWaHGOtcMIk2ur2Smbkg9elACg
   b96zNIXyxj/+yiJrj3+YfiXqYAB9j3w4my0u7y0DT3jyKwc/cSO/jgiyq
   O4q6z1eN63X1W7G0+KpaLpLV+swWFMveZGdl/j7DbnCGcEYkOSZuz1hie
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,206,1661788800"; 
   d="scan'208";a="318840293"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2022 08:27:55 +0800
IronPort-SDR: eSGL2WIRidPgGWvU5GPogv1iQ/CP4dH77LkLCHPeYLIJMAR2vWRR11Hnbwqmq5dZIVjpfh+ACM
 a1zBtIDT63ED9326LWkTc6I6MZFh7S29mioUeY4w/NqkvAU7YQKgx3wh+PEjOVUl+zTluII5tY
 xVwQZZ+Rqo6QYY90Hn12xc7BvKOnl7hjCIrSWO+WH3dnyexhO5JE1dB/2gkuMoeJqSitkR4vv5
 s9uWL+efGhf5gG5BO4esQs8WfAohNTcad42dR2HTCp7uDnSfdSsdyqYRd2Ot97KO9NUUTgavQj
 d0snej5sHD2QyzeeZaYovoMK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2022 16:41:41 -0700
IronPort-SDR: j9jaHFx6rPTnIRb3Kou0nYFultafwK5fwofxCKYDG9O9qo3oSgya8dFPcx5aJ3J8FIt3HeciVM
 hCZIFmLgn9VrWgoQ7Imr2FJKmP3NJbyb/I9hMElM6j12b4e1mzH92YpVmVsMQTHpOAHwilfa7q
 GhZDhL0XNbc7IF3DdebnaDQ4nXNkDvbNdE7pHjMCZzHbOXxIfHiRoicWf41ykB3XO6GQ8NyiF2
 0hzkQexLz6bMXRupPrYt5lSo6RbkrtZ1OS26tXFkeoBfft5DNMZ+JEptNWVbw7xS+wdRwzPTaF
 uz0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2022 17:27:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MvzZ30F2dz1RvTp
        for <linux-ide@vger.kernel.org>; Sat, 22 Oct 2022 17:27:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666484874; x=1669076875; bh=cKuGSIaM/0/ouABisoYzo3KIVuGAu/ZMvFN
        0h1mH2ec=; b=fHGpW0lGRp1Q4iLEGY4BcjH3C1oiRa3YyFp7BiE5F0+sa0rvwKA
        dwtG1tBRYD4j7zuFfcH1pGndEFBsSmFjKWB93EVUXT2Hw8SQvRqhWUPI4Mjg6sEU
        mW6ymfWX7AblZz5mioJwp4j1GP9UKPLCPuK1PtBQig99NJxNj7JnaSL5xYM1CMSS
        BpkKRHpCKI3Ou1O2QJXwnnK3isPEWFhYqgkWSMtD0MZzseK7GYT0ZJrsiNCzCJhi
        t/Jt+/CUXHHWBjc0aKxFxiTHsJ4xSwPI4K2lD2+lTC2JVgAeyE/stgJ2gJjHUONs
        7BgdSqm+Tiks66iNBpeUI96gDiqEkU4ZqnQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OY-4ssZuI9F1 for <linux-ide@vger.kernel.org>;
        Sat, 22 Oct 2022 17:27:54 -0700 (PDT)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MvzZ20sfWz1RvLy;
        Sat, 22 Oct 2022 17:27:53 -0700 (PDT)
Message-ID: <ce0e9649-873a-81f8-0702-e8d7d6ec84bc@opensource.wdc.com>
Date:   Sun, 23 Oct 2022 09:27:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 0/3] Improve libata support for FUA
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-ide@vger.kernel.org
References: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
 <165565d4-f391-b13c-b450-26f115bb4cf9@maciej.szmigiero.name>
 <d0315388-460b-37c9-298e-97f86b7965b7@opensource.wdc.com>
 <5b8ae976-413a-98bb-1912-2fe953eaa918@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <5b8ae976-413a-98bb-1912-2fe953eaa918@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/22/22 22:50, Hannes Reinecke wrote:
> On 10/22/22 00:45, Damien Le Moal wrote:
>> On 10/22/22 06:02, Maciej S. Szmigiero wrote:
>>> On 21.10.2022 07:38, Damien Le Moal wrote:
>>>> These patches cleanup and improve libata support for the FUA device
>>>> feature. Patch 3 enables FUA support by default for any drive that
>>>> reports supporting the feature.
>>>>
>>>> Damien Le Moal (2):
>>>>     ata: libata: cleanup fua handling
>>>>     ata: libata: Enable fua support by default
>>>>
>>>> Maciej S. Szmigiero (1):
>>>>     ata: libata: allow toggling fua parameter at runtime
>>>>
>>>
>>> Thanks Damien for the series!
>>>
>>> I've looked at the code changes and have basically two points:
>>> 1) There seems to be no way to revalidate the FUA setting for an existing
>>> disk, since it is now only taken into account in ata_dev_config_fua().
>>>
>>> As far as I can see, this function is only called on probe paths
>>> (and during exception handling), so if the "libata.fua" parameter is
>>> toggled the new setting would only affect newly (re-)attached disks.
>>
>> Yes. Indeed. Forcing an ATA revalidation needs some more trickery as the
>> regular sd_revalidate() does not lead to ata_dev_configure() being called
>> again.
>>
> But shouldn't we rather fix that?
> After Johns series of pre-allocating the SCSI devices we should be able 
> to call ata_dev_configure() from sd_revalidate() ...

Yes, that should work. Though I am not sure if we really want to call
ata_dev_configure() every time sd_revalidate() is called, given the
performance impact of going to EH to revalidate an ATA drive. On an
average distro, there are quite a lot of revalidate going on...

For this particular case though, changing libata fua module parameter
value at libata run-time should trigger a revalidate of *all* ata drives,
which is different from the regular per-device revalidate driven by events
or the user changing a drive config through sysfs.


-- 
Damien Le Moal
Western Digital Research

