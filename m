Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25959ECAAD5
	for <linux-ide@archiver.kernel.org>; Sun, 28 Aug 2022 23:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiH1XUh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 28 Aug 2022 19:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH1XUf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 28 Aug 2022 19:20:35 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92952B49B
        for <linux-ide@vger.kernel.org>; Sun, 28 Aug 2022 16:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661728833; x=1693264833;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=AnnJDbyNfTDSXk/1wOIcahB7Dzp3k3DauOQ+yjI0AgE=;
  b=H9HEnCM3I5IAV8b/hq3X/s24RPVZUUlXTqpzuzy6MUZmWkJkm5iYt2OD
   xCRMF3R4YQl5MBWeqHuPOKn53BheyP0kZPqf1RD2+ZwF+mcI5XGYS7/83
   ZizAypIn2JX2OXRKvHApZbQEBFeW3wvfKMOVTbq5fuVl1oZQpBPLoDbFJ
   V4RnbuD+QbT4Xe5fPlzOqque9fECRtq43LqZpxmhifvNnXRe3KFacIBOg
   D46HdV+mx4pzIO2a6u7vkbsZNHiF5Gfkuk1al5ijiok0hJNU4fGIFqCA7
   I894/R/U9RQ+ZMnicAupkZxJpMcGCwnoNF5hNJcDhj5/bTvcmXTGLI4lm
   w==;
X-IronPort-AV: E=Sophos;i="5.93,271,1654531200"; 
   d="scan'208";a="209868249"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Aug 2022 07:20:32 +0800
IronPort-SDR: csDXsddQedfBTWT1fTIoQ6+5NXj1F+PAwCUhAXrCpXtvz5zbxCy1rHjMWMtlRSauV8ymlgrwAr
 u6vj9QQaesAfIBFkp8x1/doAwK16t8pmK29RLnbbHIafGVeihFhQHNQ8ra+l1lN14dkmmkmNm6
 Pmez1btxxwXzaOBIGt0wd8QOA6HkpIqpRngG+DNiB/XHYIMZsb8eseFF4bEOMd0CV0MBrXGoXi
 fdYBn199x4u9swGiTg4HuWyzop0F7LdjC4xGDOGFdUQ30cEhuZYLo8XFnd71fc5raR4YP8H4U5
 0t6Ozp3k8ljTeHb2FWSGmcLJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2022 15:41:06 -0700
IronPort-SDR: jYk2x4LPcNRuTlbZYyh6/UxUD35XjvFKamoG5UeA1CRb5KMGdKGbUzxbMfw39HXARkPJL+p0QB
 A82CTb5WhNg9K9PCEqi3bE36XgtYlqW38IfVX1r67ifFsZ2LyRs0dKNy7jo2LNBKkp2Pdw/rEa
 +fXBIQ93uZlTPY2X8lDruF4AuVB1VlRvzc4oKcNcAFxgdN6WfsOJEAojHxli7P7Bs8vYWuRHv5
 F+s6086YU/6LBo1GA7MWS3vTl/1Cp+wH6UlYlNW0YKXqj6ptiQjwUmPg+/NwBvCMs+YT7fIo8d
 x7k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2022 16:20:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MG8gj2m0hz1Rw4L
        for <linux-ide@vger.kernel.org>; Sun, 28 Aug 2022 16:20:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661728832; x=1664320833; bh=AnnJDbyNfTDSXk/1wOIcahB7Dzp3k3DauOQ
        +yjI0AgE=; b=Ow66hxnYN1eW4zXoaHEd2Ib4XYjtzAjEoXSvFk8oKJrKWM++YDi
        KjJXuHla22K/YsOCrFbMEFNC41ClwbOBIKlQH4TRbbxNRCyNg+OPo/Wft+M7AIEx
        hFmylMNS3euZGZ1l5DaH59H/or56N0wCQyjUK5b2K/frAJhTQ2RSsBroWV0GjF0B
        nMHnX7NcoEnjVCBC/Bb+jOHosd4Er4PR1c/nAqt+KkJA6aJ+yxYohxzl1HCP+hEo
        0bebsPfrRLKCG75ucbtLPH/9zP0iigNlYNuOOj2E3IQzaUBlH2bf//8f2qL/CcTM
        aI3M9xtjKjpVFLCV5K5DwhpUNvqtov3f9dw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TwSYwB2neLBc for <linux-ide@vger.kernel.org>;
        Sun, 28 Aug 2022 16:20:32 -0700 (PDT)
Received: from [10.89.84.105] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MG8gh2ny1z1RtVk;
        Sun, 28 Aug 2022 16:20:32 -0700 (PDT)
Message-ID: <48bb6122-626d-aae1-fb96-2c40455f0303@opensource.wdc.com>
Date:   Mon, 29 Aug 2022 08:20:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: libata-scsi: ata_to_sense_error handling status 0x40
Content-Language: en-US
To:     =?UTF-8?Q?Peter_Fr=c3=b6hlich?= <peter.hans.froehlich@gmail.com>,
        linux-ide@vger.kernel.org
References: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/26 21:00, Peter Fr=C3=B6hlich wrote:
> Apologies if this is the wrong place.
>=20
> In commit 8ae720449fca4b1d0294c0a0204c0c45556a3e61 "libata: whitespace
> fixes in ata_to_sense_error()" we find, among many actual whitespace
> changes, another change that adds an entry for 0x40 to the stat_table.
>=20
> I thought that 0x40 is bit 6 of the ATA status which means (I think)
> "drive ready" and not, as we translate here, "unaligned write
> command". I may be very much confused about this, but if so, please
> tell me how.

See the code below that table definition. You can see this hunk:

	if (drv_err) {
                /* Look for drv_err */
                for (i =3D 0; sense_table[i][0] !=3D 0xFF; i++) {
                        /* Look for best matches first */
                        if ((sense_table[i][0] & drv_err) =3D=3D
                            sense_table[i][0]) {
                                *sk =3D sense_table[i][1];
                                *asc =3D sense_table[i][2];
                                *ascq =3D sense_table[i][3];
                                goto translate_done;
                        }
                }
        }

So the first field of the table defines the *error* bits, not the status.=
 You
can check the ACS specs (Section 10.3 of ACS6-r1) to see that bit 6 of th=
e error
field for an error output is "UNCORRECTABLE ERROR bit" for the commands R=
EAD DMA
Ext, Read Log Ext, Read PIO, Read Stream, SMART Read log, Read PIO Extend=
ed and
NCQ Read.

So this code is per specs.

> (I've been tracking another, presumably unrelated, error and have the
> impression that this "unaligned write" message has been leading me in
> the wrong direction.)

Are you using an SMR drive ? Getting an aligned write should not happen f=
or a
regular disk as the kernel ensure alignments of IO to LBAs. But for SMR, =
it is
possible to send a write command that is not aligned to a zone write poin=
ter
position, resulting in an unaligned write error.


--=20
Damien Le Moal
Western Digital Research
