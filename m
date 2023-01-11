Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC74C46467
	for <linux-ide@archiver.kernel.org>; Wed, 11 Jan 2023 06:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjAKGJ0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 11 Jan 2023 01:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjAKGJV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jan 2023 01:09:21 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2A4DF37
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 22:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673417360; x=1704953360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xCs/n9rDQqS+vdn0jPiYAiFA43IssZ/nNVsVQCyf6QU=;
  b=jyC4DMnQGkI8KZfOzPeZFA/T5UU3DvAWD5mdBddwyhPVbOMoTm/rsz9c
   h1ZwiP4BVpVJAF30fcD2xdCWyYPvJE1KF6PmvnbiOcbGmggeGFT/x2Z7A
   O/Pt3uXh0Naazg7cIieySZnf4r8En+tieSZ1hmIQNoTOPEWcvy0DRPdlG
   rdf2Nu6f+dQL8Z57re2uBR6PeAQ8Qfm04eSmTqU3thsM8n13kPQ3tHKtS
   y4uG7NunYKi+3BlOTQsuk+LcNBSOkKOziMwt9ZQtlWpmLNCsUaxW3BPgB
   1zvj0tdo8DWfhJhoRGY7SoaUQ4CDjC+EkISEs2/AgjkmwUSjsaHd3QP5C
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="225557117"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2023 14:09:18 +0800
IronPort-SDR: uCYCH4UIleRNUormAZwzclYikBkEyrkO2TcnBKAufZ4jAoLCOyJskw6uB342Rq2/Aost+vhO2h
 dylziC3Lm8ygMISLo84kkKZ4sxAvx+YKluLNLpvPq1kYRE+0JOMj3TQFzFzhWAuGUgW2qnT2AY
 //Atr3p4gwdNlwQYnzofy7O8NmazHLI95+vnv8HlXfSPkOWWDNpI0anVT8QnLnaxMcI6omQzHO
 /shMC/PdRdZD+RcPYqDqKmi1w6zFGwkU5MS4TRGecVpwipFVWdmIotg4GgxBYHaXzO9dVoJHYu
 jEY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 21:27:07 -0800
IronPort-SDR: cViXO7vYptgCDBh1bQTEyiPFkRHg1plHHrqKI0VNVpuz3lps8kf1r+SJirFSgWLXzxYfXSwPKO
 HKDnsTM8QaWqMhxoEqQlbsfHfQef4rSyEoORTl6xbGExWcDid9wUhz4XObhVJUnghVlHgPBXdJ
 fL2Aq33D6LIPL5Y9qKLacRzghFYcZIS5763VEaoh5jmaWsF8Iu5XJNiSsYmImnRnlSKbZnHX+K
 yGcM0UmGoWdnZAx1j6oO7nTkplNSHc2HGtR/uPV1umQk5fI21uGMaIyd75CCXHOnMvwuommlmj
 0Ds=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 22:09:19 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NsHM160rnz1Rwt8
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 22:09:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673417357; x=1676009358; bh=xCs/n9rDQqS+vdn0jPiYAiFA43IssZ/nNVs
        VQCyf6QU=; b=l3XqdNtRhpr8UYKaFaem4iumwXyKQguE86M6w3P2vtgmchXK6dd
        axwg3D5ffr/pjSPiAZKmWue5QDcG4k+JSHerWFS+EdkNEa5fOjWwDUjO2wskbLLC
        qbonCxASTJ/e0/dLbvIjnku30s4BubwYE1UHsWDWTdEHmk+lWeLmVmhFwUn2wlgy
        LkKvcTKfPnysB4AoQ9MgnH9JhRsHr3GcYd7ggmVwWDWFevnZVt4JWp5/F0WTH6nr
        29HhiKupCEjlKbondGP+cj91PP30FJ7tecgu9FOZvsjefDv5AnV7EcC5tAm3kfvn
        dsvQ4ydfy1FxyqeODeTJyc/4QlFgKE9l5vQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CN2gCrlK73ug for <linux-ide@vger.kernel.org>;
        Tue, 10 Jan 2023 22:09:17 -0800 (PST)
Received: from [10.225.163.17] (unknown [10.225.163.17])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NsHM03cCnz1RvLy;
        Tue, 10 Jan 2023 22:09:16 -0800 (PST)
Message-ID: <5d95dfcb-ce64-db64-046f-70376261345d@opensource.wdc.com>
Date:   Wed, 11 Jan 2023 15:09:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 1/6] block: add a sanity check for non-write flush/fua
 bios
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
References: <4a278c42-1f7b-f4c2-13c1-06d6fe52997f@opensource.wdc.com>
 <2544F354-58C0-4E90-8A1E-721AD455D6C8@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <2544F354-58C0-4E90-8A1E-721AD455D6C8@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/11/23 13:32, Jens Axboe wrote:
> On Jan 10, 2023, at 2:58 PM, Damien Le Moal <damien.lemoal@opensource.w=
dc.com> wrote:
>>
>> =EF=BB=BFOn 1/10/23 22:27, Damien Le Moal wrote:
>>> From: Christoph Hellwig <hch@infradead.org>
>>>
>>> Check that the PREFUSH and FUA flags are only set on write bios,
>>> given that the flush state machine expects that.
>>>
>>> [Damien] The check is also extended to REQ_OP_ZONE_APPEND operations =
as
>>> these are data write operations used by btrfs and zonefs and may also
>>> have the REQ_FUA bit set.
>>>
>>> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
>>
>> Christoph, Jens,
>>
>> Are you OK with this patch ?
>=20
> I already acked a previous version, you just didn=E2=80=99t pick it up.=
=20

I noticed your ack. But since I changed the patch, I wanted confirmation
again. Do you want me to pickup this version through the ATA tree ?
You can take it through the block tree as the block patch can go in
separately. There are no conflicts/dependencies for compile with the ATA
part. Whichever is fine with me.

>=20
> =E2=80=94=20
> Jens Axboe
>=20

--=20
Damien Le Moal
Western Digital Research

