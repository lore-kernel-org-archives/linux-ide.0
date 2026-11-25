Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795614549;
	b=Gj6ZRwOG2AZmPy7f3lXnY7JkqRTRZAh7HsavD5DLghrKFIU9BqycMzKGtwvwLQzpcQVw
	 6IyzjixiHQpu8THHUFHUiI73SJtXQwgGw6Dr2tql0G9jWJI76CjjW/2ykh/QWdGZ45r9C
	 lK/693cNNLcltj5tLs5zQA56G+hynLlYd2IGWnnhf1vA2xO/uvMjh32Bh03yrZSfEGiQJ
	 Ua0rVdOJf6qQ+5C+j00es4LJFJ17eV8SGa0RaSnhE0ldPl5yc1WAkPwkL6+8Z6z1mhWcx
	 QVcxyrzQpWp329eryD4/XRI0ug+ZTLrXiHbRtJSHUJF8fa0fi5ya3Osls4hWhhPNMJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tJvDq5tmnbN1V0lnC7fyUre118RuearxhzthUfCzjqI=;
	b=v2eyOkFmG5H/ZOrtRmXn/NhQIpGdRFd2/Eh/Y1WWA9kMcwUV1eQqxddOpdsKeIh7U/Tw
	 QOE1RyrN4uEQUujxf7+vekI++XhDfWg2uD2KlMzTP71BtbN5sHncuXE3d4vVu/sryJ6VZ
	 8nNBww6b/fVocEX6A6kKfx/i0xai/3CTCqAq/UoOaszq4BWL2pDpQnr2l6c9mhcfcLFAZ
	 ri9S6bdFmjIL25ztpMcBnBm6RDNgbTuU4isuH0D7ebsUbzz9Mge8KUa72YkfnrDA/4V+G
	 HMm2izvgEMYCZow7BJ3R6x+Tk/ssa6LsIXtuUGNH4lMtz7OQLwyByzG5s3mzSYScD1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0A/ibBXr";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD947606A335
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 13:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD947606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0A/ibBXr
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38692f62b22so6616374eec.0
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 05:49:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795614548; cv=none;
        d=google.com; s=arc-20260327;
        b=kLSwKugfgQcJK31KcyOEJFFrDCji8opanz+Hv6KR4QYZBhqKJayUTXOb/LjFaTpvcl
         FbfjzTClUke1y0ImEsMo2dXyCDXHyy5DaflSwqtDZSF03k5EltwAA2VDgkAloAr95Nno
         v8fYSkBNN243LH1HI3VID3OOixjzolUnmkZMaVWMdB9Q0CQSlInw9aND3+qrdUoSEfhP
         MpLB3pbL7MZQEJZ2jU3kHJ0TA17SXkRGaT+mC+mrZbCOCDVxKwdZaEx/WV0OO+XnnZNm
         Op2Qe3l9fWcJPnuiNbhJsCKviTj2X9eJUgiyybkhTbM2LvTFSBZZN1+p1Pf8F5nlQxn7
         Zi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tJvDq5tmnbN1V0lnC7fyUre118RuearxhzthUfCzjqI=;
        fh=s4IVKPU116TlXEK393oGEldcpY8D2NcdEIAjiCxe/W0=;
        b=gXiYgY5d8OpXqPUQD4pWu3hq/+t4M/ID5oHNDlMujlpJOtMFUup2/rUALylZTQ20wT
         iv1vRoGikoGEwOUhYsSZ6aBEq2THhnx4KH4oOZJEAk3lCAmx+MsaRRbtHgoZf2oUB7qd
         E2cXWr/oTa9BN2xK/zgMqCFEyKka6Xbi773sytq8BI25hxo8r24hAWj5YEH5v7Mu6+KF
         +7JLQGcWCXbLRZJqZziARlR1xBhNS+1+WE7iXObbD5lr9zrEmj9RaleuO+B5ng5QPzs9
         avrAJ97J+Q5J0XCO7xCJbYqpSjXrSeAqXsWFtMSDdR9PTUDiJ7w8WvTiNBVIK93pF9BL
         Mnrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795614548; x=1796219348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tJvDq5tmnbN1V0lnC7fyUre118RuearxhzthUfCzjqI=;
        b=0A/ibBXrAlsPzB3kEsMyVxw5cl8Y5wLKG9c91aC5Kq4dVaPqUgMZuaPiRoRv+7kxFY
         2mnPSTOCASoYZCe899EwNL8pFbLr4Rm4n5Lo92JWhTtn4nsfXJZpGGSm+kL9ZQNTn/B9
         749v+bmIEaQvXi2lHc903J8KdaCb1Jj1G3y1pu751mXAalSoRddID4RmmhFHj8P1Ws6B
         ap15ZKFbwP/U5WYSseYwtfM4CGBfUf8nrHtI7c3VJL50s584JV1SwYur8OJokysDtQT2
         LBDNC8pXDX/w3IclFURKD2NtnzkXJ7pNiXjPU1XTO5q5FLPBE2/0PZrs90BMVI5/yl6T
         I2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795614548; x=1796219348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJvDq5tmnbN1V0lnC7fyUre118RuearxhzthUfCzjqI=;
        b=AbyoxNG0d8NyQEb1Gqqe/aWUdjETy+PV4FHa93UWwwug0qrdXI23BOEmqTKw4rGU/h
         S0XztIiFncRrsS7xedBpli2ZTeHtHCsJN+YxeYKUSNufvXHvhurDnSUfuq3Dn+6LVraa
         ZSTNhHPOm92sBCG0zoc9QpqvcvehIuB/PYYX2rN/Si+hwYHC1kob1OBWgzZg9ceW4YF3
         y89AMF5ocOgB6hshDsEKR0O1UongQ1bhmfwbJp2zSVjppIFdNJewOCGa6PMygo2l/JN8
         aYq1bLXDP2IaaQ8pnRWbq6gz0LcM3gpjeK0csZgN7TJRDKkqbz7WGOtM/MvzCSNxzelw
         eKvw==
X-Forwarded-Encrypted: i=1; AL+hErEwoPLJOtKoAUPdbpdQ/7u8BynMrsTvDpIoOXw8bdd+oLPcpRe9vwfdi5DPhEJQ6ErpiIunrMbNcTk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2GqlT/SwJ1FiTp11qZUyF5DP83FE6kxWEBpuBGpsfipVpns70
	aKuBL1sE6PxVtL16hTBQUvfZTs2P2UlfVi+KdPpvm140rof0H7Ood4sz9wfCY9NaeWcdyqQPcL7
	Z+SQnFu3x/TTLxOA4Y1SHUOgQ9HbeBaA=
X-Gm-Gg: AZFdTZcDj68f7STkYX8ddq44TTdCAWpRvXP8cOWpbIIMtcTQhMT1+WcgYTe9CxOafnF
	7M/GwDemwOy7NSDGikWqINdkjbXT+UnoRhASdEwRG9ebh3/vklrOfGiNTBc6mDfIzdfc+zY/eFG
	IQLatkqD//ZZ3YgtA9KDOVr8rDRiqmIg+VzzkjMQ/vLUKFIGmj/LORabEV7GqxylqgphoqRgblz
	xzDPIV59lVeji1buKZj5n+YeRxw/ZbRn2fr8Kiw2qh/Wj9vfnkJyg8Pqta/88NCDpUBztwavxZk
	aWgkRFhoErFyGChH2U4gnDnLbvjmPxaYWxySCto+3bOSMh6rt67nfIGBnZr05SW5FoOslO38um+
	BVDBSlX8m3BvPsAPK9tXueNbByDoBUyT+dBpwKKGzuL2nL5AG3O65+r1HVg==
X-Received: by 2002:a05:7300:c8cc:b0:386:6116:c389 with SMTP id
 5a478bee46e88-3866116c625mr14937713eec.15.1795614547537; Wed, 25 Nov 2026
 05:49:07 -0800 (PST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAGvcwsDdKSZe0reeuT0eQabaSbM6+KAfwFimxiqhvKrjD2nQeg@mail.gmail.com>
 <awX_cNOqtTjAP33a@ryzen> <CAGvcwsDwi9vNcCLxdBz-Arx=5i-fFvqxP+QbRKrx7hK4yqmvRg@mail.gmail.com>
 <awa_ys0XSt9UwAZE@ryzen>
In-Reply-To: <awa_ys0XSt9UwAZE@ryzen>
From: Pe3k <pe3cek@gmail.com>
Date: Wed, 25 Nov 2026 14:48:53 +0100
X-Gm-Features: Aa3M54qXC8BBPvMGYvAl-y0oqEiJ2UAcVDa3IEBXuTekQnzPUbClOSDC6vixiKg
Message-ID: <CAGvcwsCvuedSN4Fs1TaFRTVc2QbcQK94P6+xqH3qmEvNqq3d9g@mail.gmail.com>
Subject: Re: iommu/vt-d: data corruption, AHCI gets IOVAs inside its RMRR (HP Gen8)
To: Niklas Cassel <cassel@kernel.org>
Cc: iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

Yes, 5.10 works.

I picked 5.10 because it is the last release before VT-d moved its DMA
API to dma-iommu (in 5.11). Until then the VT-d driver reserved the RMRRs
in each domain's IOVA space itself. Since then the IOVA allocator, which
is the part that hands AHCI addresses inside its RMRR, has been generic
code. So 5.10 was the obvious first candidate for a good kernel.

I tested the mainline 5.10 and 5.11 builds on the spare Gen8 with
intel_iommu=3Don, translated default domain, and the same load:

  5.10.0: clean. 0 of 6 copies bad, no DMAR errors, and an
          intel_iommu:map_sg trace filtered to the RMRR caught nothing.
  5.11.0: broken, same as 6.12. 23 x "DMA PTE for vPFN 0xf1f80..0xf1f94
          already set" (with the WARN in __domain_mapping), 2 of 6 copies
          bad with zeros and RMRR firmware data, and iommu:map shows
          iova=3D0xf1f80000 from iommu_dma_map_sg <=3D ata_qc_issue.

So it is a regression between 5.10 and 5.11. The likely commit is
c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu ops").
After it, the domain's reserved IOVAs seem to come only from the device
that sets up the domain (00:1f.0 here, which has no RMRR), so 00:1f.2's
RMRR is never reserved. I have not bisected inside 5.10..5.11, but I can
if it helps.

Thanks,
Peter

On Wed, Nov 25, 2026 at 12:00=E2=80=AFPM Niklas Cassel <cassel@kernel.org> =
wrote:
>
> On Wed, Nov 25, 2026 at 11:01:17AM +0100, Pe3k wrote:
> > bugzilla 221713 looks like the same bug. The ML10 v2 in comment 15 show=
s
> > "DMA PTE for vPFN 0xf1f81 already set (to f1f81003 ...)", which is insi=
de
> > the same HP RMRR (0xf1f7e000-0xf1f94fff) that I see on 6.12, and its 7.=
x
> > symptom is the same "Emask 0x40 (internal error)". Their bisect of the =
7.x
> > symptom points to d373449d8e97 ("iommu/vt-d: Use the generic iommu page
> > table"), but the RMRR overlap is there long before that (they saw the
> > PTE error back to 6.0, and I see it on 6.12). So my guess is that
> > d373449d8e97 only changed how the overlap shows up.
> >
> > The H97 thread looks different to me. There the faults are "non-zero
> > reserved fields in PTE" at 0xff4xxxxx, outside any RMRR, and they depen=
d
> > on the request size.
> >
> > sp_off: on this machine the only DRHD reports no superpage support
> > (cap c9008020660262, SLLPS =3D 0), so I would not expect it to change
> > anything. I tested it anyway:
> >
> > 7.3.4 with intel_iommu=3Don,sp_off: no change. It still has 0 DMAR erro=
rs
> > and 221 failed commands with "Emask 0x40 (internal error)" (121 READ
> > FPDMA QUEUED, 100 WRITE FPDMA QUEUED). 3 of 6 copies lost 8 MiB each
> > (zeros), and the iommu:map trace again shows 21 maps with
> > iova=3D0xf1f7e000 size=3D0 from iommu_dma_map_sg.
>
> You mentioned that 6.12.118, 7.3.4 and 7.4-rc4 is all bad.
> Is there any kernel version where you did not need iommu=3Dpt for a relia=
ble
> system without corruption?
>
> This seems like either an Intel IOMMU bug or a HP ProLiant MicroServer Ge=
n8
> specific bug to me. Hopefully someone more knowledgeable in those areas w=
ill
> chime in.
>
>
> Kind regards,
> Niklas



--
