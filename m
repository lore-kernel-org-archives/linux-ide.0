Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5E3C4332F
	for <linux-ide@archiver.kernel.org>; Fri,  9 Dec 2022 02:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiLICBq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Dec 2022 21:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLICBn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Dec 2022 21:01:43 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5FB23151
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 18:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670551302; x=1702087302;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/WLJDtdsfpshOBYc9Ij4gcgC701OUKbxKUbK7Sculwk=;
  b=U2tVYzZ0gKJiJ9DMepjYsKwtiD29cYSiQ4YOPWJNOk/itGO3i3J585NP
   GNASgB1sd6l6pQFre1QvV+ldWDs5HvXsZxdWYEML//XGdY6RdjScN+FdN
   FuxZpUdpGJXh39wcNwksJX9L+sDdB7Wj1fUd6o6Qz2z5f9Hizc7tS7vD6
   ssyNSKVh9YYRcUec1+6JJFVpAdo4QdK14l/M6Xh8Ij9Xkd1y1IiFkNrge
   pXe4vtI8UeZ9vh2mJGjDzOtmdF979uVsgWUdUM2Xynp+Slwb/oW2GYSxO
   i1YJcyuQL1A13OesUq5WVVp/b8nzP82XYrB3e8m6cPaoTjcRD1UKpku2I
   A==;
X-IronPort-AV: E=Sophos;i="5.96,228,1665417600"; 
   d="scan'208";a="218504910"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2022 10:01:41 +0800
IronPort-SDR: X3wTMUnDs9cpXHZcAIKepu4CssstHi8cyOvw6VHNZZY4qjjHdqEqE4w1Q8bIIiUPDAQlzdX4HD
 AWq5rR86OFIY7cNymbSpA2IcZ6GOvoAZkFNocxpLDwoI5CRW2nLuPUU9of4j2bxM0zMZsPNFDY
 22G8KqJWfM8pIqyzEO3sIjy5Y6Sms9eucAMnnob5l4ief77Y1ThRUmokAY2S3iuD36ehp9GXu+
 S1f2mQbKFOfhGvJEpVjtKGZl0UYG86uCaMq5xTBITaSBa0BV5lSEAmAeE/cWUCHAOW/ULQmXqR
 3+A=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 17:20:10 -0800
IronPort-SDR: llom9CzgeNszvpNjbMN+TmBfNyFLJO4+so828TAZUe3qvqlY/R7a90o2POoadWhbpC8hhdBfYl
 s3uTRGtaIhFaVOao5ArYuu3ErCO8ftq955MfauvBkcazjdJ7v5Xw8xDsflepzCJijijxFfcBWJ
 CS41slydkpcOBi2LkgZeg3sStRtqYi8jaWP/MEwMurkCOuBYfDGg9Vmkze3SDh4c3gYqtw9XUs
 /rC0Olm2wC9LuzED5WE19t42EFd0rrfUibXwgDjj9pywHIHeTDwni0+5Pc2kVqqaSjgIRevune
 YL4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 18:01:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NSvQY1Qt5z1RvTr
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 18:01:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670551300; x=1673143301; bh=/WLJDtdsfpshOBYc9Ij4gcgC701OUKbxKUb
        K7Sculwk=; b=FbnuJq0Mv5I3k003RsON7j6zUbJ7H6VQB5B2E8ujE33yROkCsha
        XUKkPX9oGOAkuBUje9aMs58y0ep3fV8TNRkHQ9YzptjMez7tesWHvLfuY4Pzx6Eo
        MAMQErJ5uunDK1BMFiSp8YDrivBCHDDGWG04p22XDB0ZQKoaAJ0edRgz45WPhn9x
        /arcNWF68lYDRa1bWVlpfmTIvV/CTh6D9tFeBDLET794afdxVrHrJCwEjzlIEwql
        Kk6L5Bol+DigkANyDwyON2WRI0VWdIlh9mKjHiLv97IQR6IZ/IK7PsTbZO4foors
        4uol3MtBBGjbd4QYQy6GLAUSfOm1bm0zKTQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lr9yjLuRSxYp for <linux-ide@vger.kernel.org>;
        Thu,  8 Dec 2022 18:01:40 -0800 (PST)
Received: from [10.225.163.85] (unknown [10.225.163.85])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NSvQX3C3tz1RvLy;
        Thu,  8 Dec 2022 18:01:40 -0800 (PST)
Message-ID: <2911ead1-c458-30f7-47a8-5cce343ddff6@opensource.wdc.com>
Date:   Fri, 9 Dec 2022 11:01:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] libata/ahci: Fix PCS quirk application for suspend
Content-Language: en-US
To:     Adam Tukaj <grozzly@protonmail.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <OM8HSmyIGyT2XF-f70AR7JA5kLpuIYEu5mYEIpyUT-4CC-u7ezc6po32ZIGOSN_7PlsF0RhOvUs8HpVJiAHGrh2ytgiBEltBpz0MuKiy-vg=@protonmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <OM8HSmyIGyT2XF-f70AR7JA5kLpuIYEu5mYEIpyUT-4CC-u7ezc6po32ZIGOSN_7PlsF0RhOvUs8HpVJiAHGrh2ytgiBEltBpz0MuKiy-vg=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/9/22 00:25, Adam Tukaj wrote:
> Since kernel 5.3.4 my laptop (ICH8M controller) does not see Kingston
> SV300S37A60G SSD disk connected into a SATA connector on wake from suspend.
> The problem was introduced in c312ef176399 "libata/ahci: Drop PCS quirk for
> Denverton and beyond": the quirk is not applied on wake from suspend as it
> originally was.
> 
> It is worth to mention the commit contained another bug: the quirk is not
> applied at all to controllers which require it. The fix 09d6ac8dc51a
> "libata/ahci: Fix PCS quirk application" landed in 5.3.8. So testing my
> patch anywhere between c312ef176399 and 09d6ac8dc51a is pointless.
> 
> Not all disks trigger the problem. For example nothing bad happens with
> Western Digital WD5000LPCX HDD.
> 
> Test hardware:
> - Acer 5920G with ICH8M SATA controller
> - sda: some SATA HDD connnected into the DVD drive IDE port with a SATA-IDE
> caddy. It is a boot disk
> - sdb: Kingston SV300S37A60G SSD connected into the only SATA port
> 
> Sample "dmesg --notime | grep -E '^(sd |ata)'" output on wake:
> 
> sd 0:0:0:0: [sda] Starting disk
> sd 2:0:0:0: [sdb] Starting disk
> ata4: SATA link down (SStatus 4 SControl 300)
> ata3: SATA link down (SStatus 4 SControl 300)
> ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 (SET FEATURES) filtered out
> ata1.00: ACPI cmd ef/03:42:00:00:00:a0 (SET FEATURES) filtered out
> ata1: FORCE: cable set to 80c
> ata5: SATA link down (SStatus 0 SControl 300)
> ata3: SATA link down (SStatus 4 SControl 300)
> ata3: SATA link down (SStatus 4 SControl 300)
> ata3.00: disabled
> sd 2:0:0:0: rejecting I/O to offline device
> ata3.00: detaching (SCSI 2:0:0:0)
> sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=DID_NO_CONNECT
> 	driverbyte=DRIVER_OK
> sd 2:0:0:0: [sdb] Synchronizing SCSI cache
> sd 2:0:0:0: [sdb] Synchronize Cache(10) failed: Result:
> 	hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> sd 2:0:0:0: [sdb] Stopping disk
> sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=DID_BAD_TARGET
> 	driverbyte=DRIVER_OK
> 
> c312ef176399 dropped ahci_pci_reset_controller() which internally calls
> ahci_reset_controller() and applies the PCS quirk if needed after that. It
> was called each time a reset was required instead of just
> ahci_reset_controller(). This patch puts the function back in place.
> 
> Fixes: c312ef176399 ("libata/ahci: Drop PCS quirk for Denverton and beyond")
> Signed-off-by: Adam Vodopjan <grozzly@protonmail.com>

Looks good now. I will queue this up for 6.2 and add cc: stable.
Thanks.

-- 
Damien Le Moal
Western Digital Research

