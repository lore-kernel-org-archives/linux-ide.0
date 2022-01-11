Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B9DC433EF
	for <linux-ide@archiver.kernel.org>; Tue, 11 Jan 2022 23:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbiAKX4L (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 11 Jan 2022 18:56:11 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:46671 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiAKX4L (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jan 2022 18:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641945371; x=1673481371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3DP9QLOIWeVOPJfOvZLe6gP5C5ksMfyJ+44/+lXtQHo=;
  b=NO/GQJH7S8dvEQpj7GyBGaYJ02czhYjc4BmZULX+PFW2f727gl87bVNZ
   kAKf9Wyo0NA8jCsI5ffl8fQuogdDbKQ3C040PqPdEkNU+htjCOoiucIQL
   bwY9DBDKDGbfjQ7n4GGINTDZBTMojM7k9LOp0+UsgcwOsJtVB1M0tDcTs
   Avk/JLh7qxaORZdnCvkiIaySYt0kEEkDW55LSxYHBs8bYi/U7NdcElky0
   X7U3JoJo+08Wyxtz7cttYhDaOqAQBVirUmYCHeC4cM1fVMqCH2rBgiypP
   s2QSWyBprj069fg6JC0h6S8pWpClHj6pMS+nhSyhQHnkZeKdHOobVPj3V
   A==;
X-IronPort-AV: E=Sophos;i="5.88,281,1635177600"; 
   d="scan'208";a="191240802"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2022 07:56:11 +0800
IronPort-SDR: SzviPcuuMoUx/n1+3WeJ7hLnXx/isYoso0xJSaM6XB7N1OKr3dtiKwEK0F2qPRYRhXZH9puTsQ
 NNAr5cYiu1zNSKV9yqzdnFZV8keB+wCIFVTYMEbzbSHe3V/XeOM6HFH6hebdGyvLLXkKgPuiyV
 4DIiA4IQffWL225un2qgi9b/E9zsZnalAYUSjYWJlWqPpApiGKgfDR02ckatQXfnPMkFhg8oeR
 fFWd/BcX4ILGg1l/hGuYXWHR80rXtFxR06NLeiPapu6Gg3pemKTd6oK2PiSL247xn9FjWbRZRx
 z2ju1gbyZ5vOjCXIiauk6xPR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 15:29:52 -0800
IronPort-SDR: h+AWadqYFHzCi48CmiqPHAu/kYEYkLplFRCOuev9T4GuZZ/W1r2TilsRlfqJwN0HEOr/gH+O8a
 INwT6L+NVEyeC9vDeaZE3u0tAyYBfjCe2LF084+2e7Vu30lsVwn2jSNExCRAbPJPf64ee6jDW+
 pv7fReLrrCPM5fc30Gp1t9PuMjGAX4fx/pdnP3WqwTVflAB1UDLrVFTWtAB2SXwsEdSgulEfHM
 ysHBX3y8+cKrq2kHVT/RtJL5byGolmB6t7tEH7fqPRC7oVyqozNHBS8jROjM5VlXs/lWPHzPp2
 Pik=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 15:56:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JYSJV662Pz1VSkX
        for <linux-ide@vger.kernel.org>; Tue, 11 Jan 2022 15:56:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641945370; x=1644537371; bh=3DP9QLOIWeVOPJfOvZLe6gP5C5ksMfyJ+44
        /+lXtQHo=; b=czaUhEVRdNFja3Hxa+cd6pAo5FEdzBzCJmG14Y9mHXHpPVpdDZ0
        BgONEg/GfeU+yIk9RvGL/vGtQKdjipW9FtAQ4+wdRRcrF1/2CytHwmBizi1glJde
        dkWxf3WoqsMRWqYx+bUpii5+qBg4skejiQh7oWWKhuzUdgYCA8GXP8vjO5wVHKZC
        9YbCG6vsGM9EnVsAbJ3DsBiKwyc7GnUgvrUiDg0binV9+CMoKDgwGQpJXnIjWFKm
        8WTjXULy/pU7U0w0B/0483vgR5rRzbnJ/94e7paKha7D8vgJ7/1bylBH7Ang1CoS
        oLc4mkOP8kXtWvf0YDWqbQkPccsp/LPJ08w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gRQvYkxH4F07 for <linux-ide@vger.kernel.org>;
        Tue, 11 Jan 2022 15:56:10 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JYSJT5l1Gz1VSkV;
        Tue, 11 Jan 2022 15:56:09 -0800 (PST)
Message-ID: <5898c3dd-aacb-adcf-8248-b079c7c2cfa6@opensource.wdc.com>
Date:   Wed, 12 Jan 2022 08:56:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: sata_link_debounce: Delays boot by 100 ms, hard coded as minimal
 debounce duration
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org
References: <2bc4b609-2111-34b1-8c0c-b69eca600c3e@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <2bc4b609-2111-34b1-8c0c-b69eca600c3e@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/11/22 17:09, Paul Menzel wrote:
>=20
> Dear Linux folks,
>=20
>=20
> Trying to decrease Linux=E2=80=99 overall boot time, tracing=20
> `sata_link_resume()` with ftrace, it calls  `sata_link_debounce()` also=
=20
> in `drivers/ata/libata-sata.c`
>=20
>      if ((rc =3D sata_link_debounce(link, params, deadline)))
>      		return rc;
>=20
> which runs a while loop, and takes the parameters defined in arrays at=20
> the top of the file.
>=20
>      /* debounce timing parameters in msecs { interval, duration,=20
> timeout } */
>      const unsigned long sata_deb_timing_normal[]            =3D {   5,=
=20
> 100, 2000 };
>      EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
>      const unsigned long sata_deb_timing_hotplug[]           =3D {  25,=
=20
> 500, 2000 };
>      EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
>      const unsigned long sata_deb_timing_long[]              =3D { 100,=
=20
> 2000, 5000 };
>      EXPORT_SYMBOL_GPL(sata_deb_timing_long);
>=20
> const unsigned long sata_deb_timing_normal[]            =3D {   5,  100=
,=20
> 2000 };
>=20
> So the duration is set to 100 ms, which is quite a long time on current=
=20
> systems. At least on the Asus F2A85-M PRO that does not seem to be=20
> necessary. The motivation for adding these delays seems to be again=20
> broken controllers:
>=20
>> Make sure SStatus of @link reaches stable state, determined by
>> holding the same value where DET is not 1 for @duration polled every
>> @interval, before @timeout.  Timeout constraints the beginning of the
>> stable state.  Because DET gets stuck at 1 on some controllers after
>> hot unplugging, this functions waits until timeout then returns 0 if
>> DET is stable at 1.
>=20
> As I neither know the SATA standard nor the Linux code well, do you hav=
e=20
> a suggestion how to improve that on controllers not needing such a long=
=20
> delay? Make the duration value configurable on Linux=E2=80=99 command l=
ine?

AHCI and SATA-IO specs do define some requirements on register access
timing/wait-before-access time. Some of the timings are even indicated
in registers. Implementation for such requirements can be seen,
commented, in some places. E.g. sata_link_hardreset() has:

	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
	 * 10.4.2 says at least 1 ms.
	 */
	ata_msleep(link->ap, 1);

Which I can confirm looking at AHCI 1.3.1 specs. Section 8.5.4 (exiting
from devsleep) also has mentions of timings using register values.

There are other wait/timing requirements for features such as staggered
spinup. Overall, there are a lot of things to consider here.

I am going through the specs (AHCI and SATA-IO) to gather all
requirements to check against the code. This will take some time given
the size of the specs and the different versions that need to be checked.

>=20
>=20
> Kind regards,
>=20
> Paul


--=20
Damien Le Moal
Western Digital Research
