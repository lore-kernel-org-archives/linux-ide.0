Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF4EC433EF
	for <linux-ide@archiver.kernel.org>; Tue, 14 Dec 2021 13:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhLNNlg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Dec 2021 08:41:36 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36644 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhLNNlf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Dec 2021 08:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639489297; x=1671025297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7RIc8kBGLS94DUip1gbTCJynyFkM5gL9bH9ry4sgvcE=;
  b=KZ71xnU+Y+kIOobdxBOLVLQ+5lpGAVAE7ETOm+8PO9VuE4mWavI8Cgx8
   unPrcquO2OzhQ9hS8Qyeds+q/7kwBNgaj84TD178dFO6aLj0NpL+vqJFk
   8379yt/RRSv/axU76J2gR2pzL9Hor4EnnKZ8A/clwAnNQoL3i75o9Aj8p
   UvEFi4NFXFlgJqmAVQ41dOWhsyC4O0k6LMRxAFjOMHrrJyWNAxq8xtQ10
   m3lQCpyJYK+wBmfNOpkVP/zJQeW1BIosJudidyicRrFRAdHnWec/R+1q6
   woWARlg5cpO5sh7hN3Hd7/PrYhMTn0oki0IbAAUU0ylOpXNfPB0ge1b6r
   A==;
X-IronPort-AV: E=Sophos;i="5.88,205,1635177600"; 
   d="scan'208";a="189230854"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2021 21:41:35 +0800
IronPort-SDR: 4O1w1ltk5rIFwbvwD8NOZrHRtTHJYmm6gw9S8csfnkB1W7yDnj3KLWfVnzsZk9/M3ZdCqr6kfT
 J+BCoUHExOL6/uUjairOJiBPwpc50e7Fuc07Xrb0oNHAAQRYqbOFOMLSnjhndUpvs8h8vj4o3z
 FmXvW8t61mH2ro0vn9neZCNLiMbrmu1ZhsmQ0tyhDDvu5PgFQ2JJ9Vh7bbAbqmMzEzKytfrbDI
 KfA9I5DYF7McRi+UuHg64VD9m6Gm3ag+C0eWAA3liLnt0BlXcIrb/A0/0FRPQ5UAbdKFt/bpQ1
 iAlJKyzmNZy/uob1o3wd0SQE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 05:14:31 -0800
IronPort-SDR: AoCQmKTNfquZoRxVKHkOK7pr0fwMK+pDmn94i02AnxJk8kit9R2gBvhpt5kfRaZ5JGTYTohWL5
 muoOn4Rh7tk4sCZYaqq2PVXfxVWapV6UUi8p2jNiiTp5qvCIi+6YuS2HByPUw4kFekSwMOzNwm
 BjcTIDxJABjpSnw0gJvfsRPrRAtoXyVk9wWlMNY8/ViOQTCJCXdpe2VRA9Th9d9Xpn63vA38oL
 R/74QyrjkHgspRycHJYGDAqr6tT/fbaujFxbFiy+uhgYklzfH9i94qJW6iugneyTa5yCzyk9NE
 NdA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 05:41:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JD00G1Fvsz1RvTh
        for <linux-ide@vger.kernel.org>; Tue, 14 Dec 2021 05:41:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639489293; x=1642081294; bh=7RIc8kBGLS94DUip1gbTCJynyFkM5gL9bH9
        ry4sgvcE=; b=Rjv6U6kO5n0p6LLiSlGe5lb3RF/ORfqOySXezMQWKVsbslH9aiT
        0hysUybmLxR5XXZ07Ey/TO99S9M05+kc5Ipp49YQ2Pdqak2mtMOtdWrR9u1aRbNR
        S2fwHPlrc2cQ8momxVVpEkoesMKSe1nURVbAh8qhbaif8HgselpC+so0MNWFnmbq
        IlTCvZ5VWIbC/GC3KtpYhHS2IqgkkLAIwY2qfcv9+WPRERknJ/uOqNvm6xc2Abln
        i1iYZS6BCQ4v0O0AqzccMZgTKKf2awjg0CCUngpB2fOoanqqAntrQjyihygkiAs+
        +o4snp8SAOxi/i7wm/qBzZKYXU8H+uiUI8g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5rEOPrXdrcDJ for <linux-ide@vger.kernel.org>;
        Tue, 14 Dec 2021 05:41:33 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JD00D6rzyz1RtVG;
        Tue, 14 Dec 2021 05:41:32 -0800 (PST)
Message-ID: <1e512500-bcd2-2dff-0704-ccb52aad907b@opensource.wdc.com>
Date:   Tue, 14 Dec 2021 22:41:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH RESEND 3] libata: if T_LENGTH is zero, dma direction
 should be DMA_NONE
Content-Language: en-US
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <a8cd9195-ab57-4067-d814-c9926eb36412@oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <a8cd9195-ab57-4067-d814-c9926eb36412@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/14 22:25, George Kennedy wrote:
> Avoid data corruption by rejecting pass-through commands where
> T_LENGTH is zero (No data is transferred) and the dma direction
> is not DMA_NONE.
>=20
> Cc:<stable@vger.kernel.org>
> Reported-by: syzkaller<syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy<george.kennedy@oracle.com>
> ---
>  =C2=A0drivers/ata/libata-scsi.c | 6 ++++++
>  =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 1b84d55..d428392 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2859,6 +2859,12 @@ static unsigned int ata_scsi_pass_thru(struct=20
> ata_queued_cmd *qc)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto invalid_fld;
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> +=C2=A0=C2=A0=C2=A0 /* if T_LENGTH is zero (No data is transferred), th=
en dir should be=20
> DMA_NONE */
> +=C2=A0=C2=A0=C2=A0 if ((cdb[2 + cdb_offset] & 3) =3D=3D 0 && scmd->sc_=
data_direction !=3D=20
> DMA_NONE) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fp =3D 2 + cdb_offset;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto invalid_fld;
> +=C2=A0=C2=A0=C2=A0 }
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0 if (ata_is_ncq(tf->protocol) && (cdb[2 + cdb_=
offset] & 0x3) =3D=3D 0)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tf->protocol =3D ATA_=
PROT_NCQ_NODATA;

Why didn't you change the code as I suggested ?

Since (cdb[2 + cdb_offset] & 3) =3D=3D 0 is also used on the condition be=
low, you
can clean this up like this:

	if (!(cdb[2 + cdb_offset] & 0x3)) {
		/*
		 * When T_LENGTH is zero (No data is transferred), dir should
		 * be DMA_NONE.
		 */
		if (scmd->sc_data_direction !=3D DMA_NONE) {
			fp =3D 2 + cdb_offset;
			goto invalid_fld;
		}

		if (ata_is_ncq(tf->protocol))
			tf->protocol =3D ATA_PROT_NCQ_NODATA;
	}


--=20
Damien Le Moal
Western Digital Research
