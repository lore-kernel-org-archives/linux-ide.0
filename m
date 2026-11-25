Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795621765;
	b=V6NSvgt/xLHcMtioNS18kdzHaE36RsF+3jpQ0t2bGVeZfuBBsWIdGTOzrJBq9SwOilLG
	 YdSeHhR0jW551am4eUTF8zalxqWjeXis4Rs/rFhu/wBbSMMEhb8iN1apCEUpGGHtUk7/C
	 1InuBpPfYhVwv4BXbwWLXEry3Sn9LSU/2tG7ktscVgR4r3T0azvfnoaPSLRPTgqhbUH80
	 312sC2IshZmSXYoYvo8HaaVy98OYMtvCttWT7cEqm5eTCs4eXLYj88iSnBoenYylu8Sl1
	 uf7qGgVewqiDP/EnASrtsTHj6Q4yNJ2477wgnfbPfB0gVDMvBihzjMehy4Sg20EyHaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kr0E2IPbo3+Z52vgzGFqQRfmeLIehprJaWTH/tm4YOs=;
	b=4rn8wZr7sa4sJxlcpl2hdFvLnhOnYtipGhLmueI7CkOvTZa9OifKvWckSBT7Mp3C/c+4
	 AM7+ClUtiQiD46SmURFafd8ZeTqpDxHRHrt+mVRlUjLpgIfSKh2/qCOL8z6OFyefHc+t9
	 JHbvPQAkSTfMDfAqK5Kb29JF+IDoH2B35Qvw61HDq1L7i1MbIxfOR7sUOzst3wQXdB3Q0
	 3P/gjnxGeVcbHaj4qJyp5B67zahV7WlpoL3JzF1o6SfNs71UgxYVUiPRomzHd1OsI2tPA
	 sEFZatgx1//S6K7+cwH11e9SZ7UhVdzTJ8xyZJyzWGmNSBSl0GbztcoojKTgsDwbwug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RQ4ouqJy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7893606A31E
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 15:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7893606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RQ4ouqJy
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38190551625so11740636eec.1
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 07:49:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795621764; cv=none;
        d=google.com; s=arc-20260327;
        b=CiRZKnt05rMClVe76iQbdvPWByCb4gzszRw8SjCAtBYlDNrvh3A0Pts2WZwqbXU5Nl
         FFm9EaH7+BzxMPEUof6Wf61PBKZqOWHsGTE/QDcvpHOGF6NDaUzaKQXu75NYZOO/1Q+o
         YpuHYBQ+KCf3gooYSc52XH9mcs00MJly5TR2hKWT1sdqq2qjoB2dTfyIEIAS8WZ6Po05
         0/EcZy+So9ZYNcnSJ/ZNT99iNK6CHnpbpuXexNffEHBT1vfyt0OdF3SaNcZGyL3H4uBW
         cWhBrMa/vJ/D9/thNlLCSv9A6tcDLRmFJODzCdol6PWpspVF74Rhu/Sq7Gr1uZdIFbVJ
         Pjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kr0E2IPbo3+Z52vgzGFqQRfmeLIehprJaWTH/tm4YOs=;
        fh=OkFwM/CxoFIQaDF+WipX3MiqCw7byokFRe4hJyV9ZWA=;
        b=h5E6vgfHcPj6+5uIELUgpn5tb7re4JAvAByQ2M5b36oLKR9qKbTT3q1GdV1I5+ODhc
         flpaPTeKZ+Kcl48w0/KHZB51kpJSHQ14o8WTY2DfcUjppNBue3mu8OLRkEwzvXU+njBN
         DcEuVCjjr3ZWSZsemxff0drNZgxGfaGoZjGvwN6owA+HA5nghdpOKDG9h/h3Zv0Xs+lG
         O/3rtZBCxby9/tjrjn5KDS899vIeRIf3V96r1qL/P48Np2BLhngCbD61+JAgAqDXyig4
         G6HpRgKqxKAKp4EGy3/C1Ce/0zOxGQzci9Yafy3fVrMCfE60yPFeT+SrwLi9moJFG7iU
         lVTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795621764; x=1796226564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kr0E2IPbo3+Z52vgzGFqQRfmeLIehprJaWTH/tm4YOs=;
        b=RQ4ouqJyPgqglJ78j5ueMA4dKqoVqHFk+h796Tp87FWIeU8uJuM8fpeC0GapmIxM3g
         WDH3W6uOGZ27J3xN1A3G2owYPa2OQkQWPmF6slZ2k1Dn2qTr8iYrgfQrB5MTyGr+qebk
         HIiV7SPGPZdlrXKq2RqKhkXoqh5naJmTn0gHDxQzjq+7ZJy5dekqMRGCYfqIE08rlwgf
         Qr/5fPXo+7PAclpPvHdx12WgL2ykRqMTlU8sLENlQk0gi76yCT/vxGU5fxYqLjyWKr2v
         tzt7IyteRtg/VwXxRE4TlUorwdYQnzSvnKArQIA2+R6twJZKnw3jvJico6y9B7iywPd+
         XUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795621764; x=1796226564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kr0E2IPbo3+Z52vgzGFqQRfmeLIehprJaWTH/tm4YOs=;
        b=OYuERd9OX1vSnf/eri04bLryMcGn3N73hhl/1h0L+5E24q7ypq+zzgO3wiq0DyCxpW
         i3r6kNyjOKqV2RZW1lIdqjK1XdrqTnek9QaeOTYEQE6x8tzWLrWYrqIRueuB2Ttmna03
         psDAEyKgYKvBKiPja4LPRWUtl4EytpUyUItIPM+5tcCCVXSdXd3IYOKfKsNn0LZz1+I6
         iCPZZLF9/pDDxn2PzbdJ7DPQXv/09tJQMhOtFgiImVY444xNJLFDxrYoX4pUg7fh1DlI
         wpvrVcWJ0nZgJay2hrAzaMJQvUFInWWzcV+le0o5/7CdNGp71Y1r3riSIXTnn1NY791Q
         IVLw==
X-Forwarded-Encrypted: i=1; AL+hErHJlyiAF5+fLW2chirwvnG4DdvJpKR5U/afQ841afIgBgmgomETkg2ZVWnraF2q3VtbpNzKL+sUdk0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2lH7fyIcbfV+sOu/uuPpeJ9hnaRVmKxOTVIUeWqqxUSVlbfUV
	pl1PiwS4AJo6tGorT8bSdRLO15gPv9imGtNDEEGE9ljUjaCzKAmrGVsfuL+JcdxaPAzYfTWmPTj
	T7siAVN0DDptIJJFgsqVXT5a2Qt8OzYo=
X-Gm-Gg: AZFdTZefDYae1ICYoOTwLRWSCIw5zURX2B3Ncoz7OQf/V9XSrlOQxHsBDDBHzS6blfs
	qx9SKtK2IPO0BJ9Uvtis0k76Ah4PVKjA4hyKIhGQoSbYIU+aJb2pMj4H4dX6tWKmDvadEfS+oB7
	/JWHmqKwXyBYGyKUTYmi6MUOrGAPTdfHaLdOmjxwBTy7YTx/motWskTYkEyN4hT9Oo90NEiywU2
	/8dRZX6ePPwA7SEkQUyZakEThEBfOhOVXOBUkT4DJ3HHHsBoERzIFt5J9FrMsjlssJZOuLOCdW/
	vZ4QhB4zYQiDxE2BWRgZ28LFfQNr3jkY+9qKBfb4O09CMczvPkvy7juGABfjSpt5WuJIZLNRWrN
	hJjeHvqr7dp9zoFaBma2ita8PLmgIfhhoKDvy
X-Received: by 2002:a05:693c:8209:b0:383:e7af:c28d with SMTP id
 5a478bee46e88-3856f14d5b2mr18886039eec.9.1795621763371; Wed, 25 Nov 2026
 07:49:23 -0800 (PST)
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
 <awa_ys0XSt9UwAZE@ryzen> <CAGvcwsCvuedSN4Fs1TaFRTVc2QbcQK94P6+xqH3qmEvNqq3d9g@mail.gmail.com>
In-Reply-To: <CAGvcwsCvuedSN4Fs1TaFRTVc2QbcQK94P6+xqH3qmEvNqq3d9g@mail.gmail.com>
From: Pe3k <pe3cek@gmail.com>
Date: Wed, 25 Nov 2026 16:49:10 +0100
X-Gm-Features: Aa3M54re8Ic4_ndXbRCPVeO2fo44dNsRCNSsdqfZpXbOFg13fIKcZDy5WBGGdQA
Message-ID: <CAGvcwsDzu1HEUPWNRvybqH1=Lte0rYk9JohctDgR252eByBtvg@mail.gmail.com>
Subject: Re: iommu/vt-d: data corruption, AHCI gets IOVAs inside its RMRR (HP Gen8)
To: Niklas Cassel <cassel@kernel.org>
Cc: iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I tested the suspected commit and its parent on the spare Gen8. Same
setup as before: intel_iommu=3Don, translated default domain, the same
copy load, and the 5.11 mainline config trimmed with localmodconfig.

  c062db039f40 (parent), two boots: clean. 0 of 6 copies bad, no DMAR
      errors, and no map in the RMRR range in the iommu:map and
      intel_iommu:map_sg traces.
  c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu
      ops"), one boot: broken. 21 x "DMA PTE for vPFN 0xf1f80..
      already set" with the WARN in __domain_mapping, 1 of 6 copies bad
      (20 zero pages and 1 page of RMRR firmware data), and iommu:map
      shows AHCI mappings inside 0xf1f7e000-0xf1f94fff.

So c588072bba6b introduced it. Its changelog says "Remove the iova
handling and reserve region code from the intel iommu driver". Before
it, VT-d reserved the RMRRs in each domain's IOVA space itself. Since
then that seems to rely on the generic reserved-region code, and on this
machine AHCI's RMRR does not end up reserved in the IOVA space of the
group it shares with 00:1f.0.

Thanks,
Peter

On Wed, Nov 25, 2026 at 2:48=E2=80=AFPM Pe3k <pe3cek@gmail.com> wrote:
>
> Hi Niklas,
>
> Yes, 5.10 works.
>
> I picked 5.10 because it is the last release before VT-d moved its DMA
> API to dma-iommu (in 5.11). Until then the VT-d driver reserved the RMRRs
> in each domain's IOVA space itself. Since then the IOVA allocator, which
> is the part that hands AHCI addresses inside its RMRR, has been generic
> code. So 5.10 was the obvious first candidate for a good kernel.
>
> I tested the mainline 5.10 and 5.11 builds on the spare Gen8 with
> intel_iommu=3Don, translated default domain, and the same load:
>
>   5.10.0: clean. 0 of 6 copies bad, no DMAR errors, and an
>           intel_iommu:map_sg trace filtered to the RMRR caught nothing.
>   5.11.0: broken, same as 6.12. 23 x "DMA PTE for vPFN 0xf1f80..0xf1f94
>           already set" (with the WARN in __domain_mapping), 2 of 6 copies
>           bad with zeros and RMRR firmware data, and iommu:map shows
>           iova=3D0xf1f80000 from iommu_dma_map_sg <=3D ata_qc_issue.
>
> So it is a regression between 5.10 and 5.11. The likely commit is
> c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu ops").
> After it, the domain's reserved IOVAs seem to come only from the device
> that sets up the domain (00:1f.0 here, which has no RMRR), so 00:1f.2's
> RMRR is never reserved. I have not bisected inside 5.10..5.11, but I can
> if it helps.
>
> Thanks,
> Peter
>
> On Wed, Nov 25, 2026 at 12:00=E2=80=AFPM Niklas Cassel <cassel@kernel.org=
> wrote:
> >
> > On Wed, Nov 25, 2026 at 11:01:17AM +0100, Pe3k wrote:
> > > bugzilla 221713 looks like the same bug. The ML10 v2 in comment 15 sh=
ows
> > > "DMA PTE for vPFN 0xf1f81 already set (to f1f81003 ...)", which is in=
side
> > > the same HP RMRR (0xf1f7e000-0xf1f94fff) that I see on 6.12, and its =
7.x
> > > symptom is the same "Emask 0x40 (internal error)". Their bisect of th=
e 7.x
> > > symptom points to d373449d8e97 ("iommu/vt-d: Use the generic iommu pa=
ge
> > > table"), but the RMRR overlap is there long before that (they saw the
> > > PTE error back to 6.0, and I see it on 6.12). So my guess is that
> > > d373449d8e97 only changed how the overlap shows up.
> > >
> > > The H97 thread looks different to me. There the faults are "non-zero
> > > reserved fields in PTE" at 0xff4xxxxx, outside any RMRR, and they dep=
end
> > > on the request size.
> > >
> > > sp_off: on this machine the only DRHD reports no superpage support
> > > (cap c9008020660262, SLLPS =3D 0), so I would not expect it to change
> > > anything. I tested it anyway:
> > >
> > > 7.3.4 with intel_iommu=3Don,sp_off: no change. It still has 0 DMAR er=
rors
> > > and 221 failed commands with "Emask 0x40 (internal error)" (121 READ
> > > FPDMA QUEUED, 100 WRITE FPDMA QUEUED). 3 of 6 copies lost 8 MiB each
> > > (zeros), and the iommu:map trace again shows 21 maps with
> > > iova=3D0xf1f7e000 size=3D0 from iommu_dma_map_sg.
> >
> > You mentioned that 6.12.118, 7.3.4 and 7.4-rc4 is all bad.
> > Is there any kernel version where you did not need iommu=3Dpt for a rel=
iable
> > system without corruption?
> >
> > This seems like either an Intel IOMMU bug or a HP ProLiant MicroServer =
Gen8
> > specific bug to me. Hopefully someone more knowledgeable in those areas=
 will
> > chime in.
> >
> >
> > Kind regards,
> > Niklas
>
>
>
> --



--
