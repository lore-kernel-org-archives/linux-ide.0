Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4220C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  1 Mar 2022 13:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiCANBj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Mar 2022 08:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbiCANBi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2022 08:01:38 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D4C9ADAC
        for <linux-ide@vger.kernel.org>; Tue,  1 Mar 2022 05:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646139653; x=1677675653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V4P91HQ+NMNBQJcCgDrZ9GmciyI6Yq/BmNIWieqqDiY=;
  b=cyOM+k5TB8SOmCnPck7bvE5CMBTAayCT6nctn4EuFq4Ewzs9KwQd8A8S
   jXjCCr6xyv4qzc0yHYzOSUbIKYj7aZcv2UorNodEujrjV8xM4YdLqmCDE
   zHHtgrPISg4jngQQKUPMnTU/gL6PsikikxQqQ/SR2XYBw7wWP0GwDnsdY
   0N0vBSr16qJuVnXSCnOdTkCXSPh0mp90RACF8lKwGFvC3S1gC+nLwuwyq
   Jr/AOTlQtecOF4wgo/wTMq3tmuI276kZ8J4QLDsyeJiy5z4nOPmysX1cs
   QG8Lr95flPvs+oAMN+dQnuq7/CpDkaa9KHDeXfyS+gXsRz2g2/iq7w+HH
   w==;
X-IronPort-AV: E=Sophos;i="5.90,146,1643644800"; 
   d="scan'208";a="195166645"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2022 21:00:52 +0800
IronPort-SDR: O+nlHlYA5c0tUZYbtzRkcivZ5gnlvI5Ul8P0D1ujagPxCSjkpgnLUpanXtNAmjHoFPCzBF4opx
 /dpEkByV2VSWCliMPvChW+2hZ0C8KbwiD4ZDVNHCubHPYU42mNR4anfVfuvDVoZRqwxTakcPPD
 GwZcwsAcR/CadbFY12fWkEkzqX9BHU/CRv73UzUMQrA8h+TCMH4dfr72xYU69mH1HIRAsvHOAT
 F/y4oFW31LOlb96TusGUjivQPYSdGllKEDLrr96FWRnMXS1mF9VM+tcxoRFgxo14E20PIJzbqN
 zspLq5lbvhzP6P6g4S+HAwYE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 04:32:15 -0800
IronPort-SDR: NtkrdFY4q7bv+NrA5/7mwy3nVbusocKuG0TGeR7+OtV42ebNWxhvf248GvN8fwqrMsTx2xnvSg
 icLVih8dVSBFkAtsTHPLwH/OJvyiJryAAWTKr10vphTTvMqRDp779ZgPwU/n63xxDj7JSnRzqE
 OOBnYjQiaSbgVu/2QZSUI/XyXb1HF4fKKSMTWQ6Ec/IoGAGWC8M0WR5Z2j6EBi4L13tzZx6uBM
 RjAD0zrD8/PV3aSCnnJDlGThXnYTyCZMhShLAddmrMV2kgWzPREyyEOz4vEU++gMLy6Dt0WEVL
 b78=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 05:00:52 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K7HRk5szfz1Rwrw
        for <linux-ide@vger.kernel.org>; Tue,  1 Mar 2022 05:00:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646139650; x=1648731651; bh=V4P91HQ+NMNBQJcCgDrZ9GmciyI6Yq/BmNI
        WieqqDiY=; b=QcgaleYhIO2zpIm/4ewqqWcsK7F53iE8ZTKrWVWeBBsNWQjYlTJ
        39xRpQFuiqcj3mSvORI6Rk+c5PERje/bkC1xaxMNF2IjedLzXYLOiyxb5fVerSgN
        lZe+8srN/iUwDkWet/zcPQanib8a5bjIIBzQECEF3y5OLpQZ/tSB5j3Map52Hkhb
        Lv+M0wlUG+TcPcGMAWNERiydOZITuLP0yEFpwj6O4k+jvcUYsXnVr+eATRqlr4dt
        wIHxKiO0nf428Rrcszp2x8+OY72Bu6sHXVhTrI4EIWw1vBhMgX22NqrZvmvEYA65
        P0iYjUS28wmC88MozwByTibRKycrkGvMMPw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J6fi7yjbynhY for <linux-ide@vger.kernel.org>;
        Tue,  1 Mar 2022 05:00:50 -0800 (PST)
Received: from [10.112.1.94] (c02drav6md6t.wdc.com [10.112.1.94])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K7HRj0cSLz1Rvlx;
        Tue,  1 Mar 2022 05:00:48 -0800 (PST)
Message-ID: <10546882-389c-2f73-eb60-1f8fb9c761b6@opensource.wdc.com>
Date:   Tue, 1 Mar 2022 15:00:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/3] ata: ahci: Rename board_ahci_mobile
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
References: <20220225172319.846891-1-mario.limonciello@amd.com>
 <76957c33-cb62-5bf8-bb5d-adf9d6c6ce95@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <76957c33-cb62-5bf8-bb5d-adf9d6c6ce95@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/03/01 14:21, Paul Menzel wrote:
> Dear Damien,
>=20
>=20
> I have a patch on top of this series. It=E2=80=99d help me, if you coul=
d add=20
> them to the libata for-next branch. Thank you in advance.
>=20
>=20
> Kind regards,
>=20
> Paul

Yep. Sorry for being slow. Traveling this week so not easy to test.
Will try to put some time on this.

--=20
Damien Le Moal
Western Digital Research
