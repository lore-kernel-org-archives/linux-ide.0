Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82EAC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  2 Mar 2022 12:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbiCBMQs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiCBMQr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2022 07:16:47 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1602377CD
        for <linux-ide@vger.kernel.org>; Wed,  2 Mar 2022 04:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646223365; x=1677759365;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YkNuTe+8PZ/6/8YrEKTutkyx4YCQhxVnaPNLFEod86I=;
  b=EpBFWGAc2fVDU4WZibl0cdibCpBr0tT5Bhuj0jq7m94F434G3/vR1Qxo
   LzFyJlGAxP2giV2CBfY3GMf1hQZ7AjnGK+PuXj1nBuu6osuVZ+Rfy+x/M
   KDqz8NtkoqXxqf8LUZX+IyML6Yreio8Qxv1Gcd6oW22I001bYf1veUmH3
   0R68IV3MLI8mD0dqQwCEVu2VKaMRG+PaW/XMPQBoEhWUYo5Q4sKPOQrwF
   Ea+dZIeBPzcTaI6s6Ooc7MWyao2ZTjoGZIAbUsESKvwRAdLHSSXrMJyEy
   ObrO1D40KV3YDS7whjOgJ5Ls/ZVcbZ1no1ldFInZoNQTgSVv1FdJ7WYqp
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,148,1643644800"; 
   d="scan'208";a="195256303"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2022 20:16:04 +0800
IronPort-SDR: Qy/2DtgrVv/D4d2bXGIJN1SD69gghgzjcwy15i52tAXIRXFlQaylc0acleeZlEg2jVTLlagwTM
 0F+t8yYwp6jLDzpnkgFxRrcCsTTfbzf3tByhUQS+SMMrArTrfhoNbGqCt2aF0Lf6IK7DUTOs+3
 IroOf4xkPL/43BH1saD9QlCVAc6s+GTI8BXD0UPGSjftDlTPC37X1TT7oW7HimTlbX9TAZmHd4
 G+JFQPSKbdGksVjPr20wcCJ4F6BXVdbi6AnCNj1fQjRSHBwRIehZWwAsDG8cg6GNZh0DNzoMVB
 chrjGDAhZLH4dY1JbcHO1MQU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 03:48:30 -0800
IronPort-SDR: 32fCHMxYD2hVAvxpp8qEhzQS+cgi0OIma6o1lAqypwVJGLh9tDhVaMAXCutipUR9TMmew9gUj/
 CcmfzIHDDjZwvCW8a8a3j94UrJi/Tolhs9vY0R3M66We2xUWKBcTmXz750Jf1dSjaRKgg3aEJu
 Psikgdfp6pB27GKWU71pB0Ocs3o1H4pTF7Ezyx/zCvPos8IaZIxmA6t9K0FrKB6w1ycOeNre0S
 DDr7iPpWu+8gcU6/B+HCQlIWVs4+NQh53U893pG5OKNriqYYD+T7mmXmfQshMcvaEqH23np4Nt
 UaY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 04:16:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K7tPb4c9lz1Rwrw
        for <linux-ide@vger.kernel.org>; Wed,  2 Mar 2022 04:16:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646223363; x=1648815364; bh=YkNuTe+8PZ/6/8YrEKTutkyx4YCQhxVnaPN
        LFEod86I=; b=A18M91TQuun88n3UaDl0mW9s5nh6V0SL6uu7gzt3IdjplJN838q
        R0LU1kpNHQ3FROzdd+CRR+x9sPvO+sIj55+dCa+OkKf8TO1XNStsZNxjd4uXHEac
        9uxSk/4M0nIQ8hcRn9tgNgdgzSGrW0I2EE43JZDewjz6Vq/q3xgptLAtCm0C5wFP
        Lw1VWF2rTN6CDXPnlDf3lRhpglBsH6Tz2fjIwsQhQ1ZLv55EPljR5Za01Uuv1hJE
        zBJYQV576ryNv42wI51sYcMel7/VQSIT0xqRYg9whnhgq+eZCqi05RDXZAKFqezZ
        iD8Tp8ndEOSP0gost/O/IADICJi3RJcNehQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SCZPPV7ckZYW for <linux-ide@vger.kernel.org>;
        Wed,  2 Mar 2022 04:16:03 -0800 (PST)
Received: from [10.112.1.94] (c02drav6md6t.wdc.com [10.112.1.94])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K7tPY4NgLz1Rvlx;
        Wed,  2 Mar 2022 04:16:01 -0800 (PST)
Message-ID: <860a2e7b-22a5-787d-fe9b-c1e75d2728ff@opensource.wdc.com>
Date:   Wed, 2 Mar 2022 14:15:58 +0200
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

Done



--=20
Damien Le Moal
Western Digital Research
