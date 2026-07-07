Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD3A2701B8
	for <linux-ide@vger.kernel.org>; Tue,  7 Jul 2026 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443726; cv=pass; b=swaFcozUVOO+G3qV7kH00Y24sB4llLdYJqnG8+JwuXZ+gEln+CGVwr0SH2MLQslViAvKi4wKlM0qwpruBAyaOPZKLt8xwy6/MZ5HAA/+dBDo4uI7BWA0ikJ49WBrHacFHGT7M5hTqEhANdHP3lIbVSSTjjECla/XoFCKnavFmbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443726; c=relaxed/simple;
	bh=6R/Ug0s/0Xl6O+oGKRBy7Jg3E21rPNsNPvzygTUgQBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIsn6egVa5H8JARFDPGo6J4NkRG+uaVGz6dAu13Oylol9UTBj+NVsv9jblhRy0B8vZ23cL6htz4qjcP1AiiJ7tfyv10GAC+NUzlZjy8FpSkH0DrSBGG6P0V9ccPekEPcvl+LEp21vanIx0deCcf/DwrC1dEpi7qskNhlAsYiy8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oSBrQwkw; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oSBrQwkw"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso56290265ad.1
        for <linux-ide@vger.kernel.org>; Tue, 07 Jul 2026 10:02:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783443724; cv=none;
        d=google.com; s=arc-20260327;
        b=IhNge3LDmxy1Ny+hWP9T/A9rEehcwfX4QmqflWZMLovtxP2PsP1EixDOEvJF+nT/rs
         MXV/vHGNWWtrmSihzCiEd1tFxtVI3IZ6GhiSS/NWHbPrp649fz7lBM7fFdmwg6cmvZSH
         3BnIRpj27Z1ao4QkqLzG5UulFvT6nKysEMf1FIM83cCN5gcC7oJRM+CYFh0TgogVR/Ag
         /F9qps/0vlwp71AIC0+69UgovuosQ2rQZG9fJMV94sqRTAHRTCQBHQnmkBJIOA5UGwUe
         ghBFNHKFR2GZPe3wVkZ+s1ZNlqSkdai6so+rM6Bn4LbfVkbkM+9c5J35c0UP1/weDudx
         VacA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6R/Ug0s/0Xl6O+oGKRBy7Jg3E21rPNsNPvzygTUgQBc=;
        fh=UTaDdbLylc6hyaW2ZctYI4P5LX04Y8blejrYDaveWjM=;
        b=VHsiOY7zELL4mxVN5MlUGGyzcmeV/3EENWv+rkDRB64m7TayXHySUnchf72vElCVzi
         D3HZFbEi3ns3KGSrgqfadDDtZPyfzDxXcsZiFFCrlbNAMqXN53jGRkiYbA00F3dgrxWr
         3+HZa9g+xwpQHGFoTgne/xu3YlTYlGo3JEuZU1ZI7Z5W4vgFrd7MHvXiPTRvoXaR8awX
         troUgIC98L+Y/7x7Hypw45RBJmZ9RBHpJGbY8INse+GeVKXFNJ8stW681YwAd/8SireP
         sAJcntoQlW9t4/ljkhQXdYHFjODfa8ld45IS/5E9RWGKADVFtN5YLVPx+M6J2VqsobDU
         Rebw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783443724; x=1784048524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6R/Ug0s/0Xl6O+oGKRBy7Jg3E21rPNsNPvzygTUgQBc=;
        b=oSBrQwkwIyzDaf0CuL9lCD8Gt1aurWUdzap0W42d06it8wPCh4kd5HavmmoBASM00k
         pAECkYdZ55BmwGD7pzSk9lvvqBTI/Hfu0bDWFmcVaqNmgZmFN6eYRtY7I0EUdv6kEmcY
         B4UUU3+OxpiGigUo/UDu/gi2jTeM4+JS3O62Zt2mEjdHQYhBqEPxP9zoHqHymJlBpWh4
         fkME0ymqpZG1DrC/zZ9jAOU5XRD96FY5h8PCqL1pSY212U8NTk6Q6ERI7v+lvHTQWnjY
         BiCmuihh9uYyDLCdlpejXxAXFZ/D4zSfiVIYEVuvK01woISaiKJXxlZZyIEkGAo1Bor4
         uh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443724; x=1784048524;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6R/Ug0s/0Xl6O+oGKRBy7Jg3E21rPNsNPvzygTUgQBc=;
        b=GA5EX+K0RZZrqvkAgTVHK3aHF7UkL9k4qNGzSEiXVHum3WwwZkssdU76JC5mc5Zf4N
         oP9FrTr4OAyFVt781ZmyVtNEuOQEbiWfqYqrBw0fu2eSUiqk3UtChyngYpK0F7zjl+U/
         ICDdFgeGqtdFLURn4RsiJL4kAl7EtszSApPEj+N+AsZsurh++OJbvSpajEc61bpN/qQB
         gpidssADmokt73UMKFp8eMw0zEcQDer/s9jcFWC73Qksb1XvP3plipZ0g+vR/oTbLpeh
         FiBH9PvCacJ/cq4MvoN/dWhH2v4B68vuYkrSFP3PPKV7nFGtX977XsO5edrz/EYsZZbX
         hs8w==
X-Forwarded-Encrypted: i=1; AHgh+RqN3TGpV2ZUTMMW7T3SaXtbmrHMGbvTSNPR2q7IzBp5cW0c7xfSnNEYTkvsbGI1hCnr7SbLaZiLKcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjDHSxTK7hGZDtzyTA3ehHLSyWNOtTNr4hgOgRnywov/vS3eT9
	5ZIJrhdInYIhgRDlq5lklf2OElU28w1ibkKA6jzaz3sikPlOtytEOwLAC6U75kZpF4tZ1DdrMw1
	XTWmbaCz3qBR8GWzELw/91iNy37kAARx5GKuBlpZf
X-Gm-Gg: AfdE7cnbIn01JY2G2DYOccMY+jDxPrG2i5vW2eyxBt557rWWxxOrAX+cLd65p3k1reQ
	egbnyXObYvMQOnSCa3T/59FKPW77qM69RUHHeQd9U7yeryAz/b3c3txzP4yFHPESS+vrmc8Uzbt
	drxUPzbavof6Ky/6/kiHTrabz2cy7vrHGh2vFh6wEmv7NgyRMegW713gJkZi2Y5YlRF1KyCi3M2
	FWLvLPORdlwEBl3qLf0btLXC3rbTENdWPYhyIArvKFtDJk/Hw6QXntut6W0oHy8ID/3fUt1Sohv
	MLmNZ0pn9l6yZKfhZg6uPgowtPs=
X-Received: by 2002:a05:6a21:310c:b0:3aa:c964:3c27 with SMTP id
 adf61e73a8af0-3c08ef729c3mr7616249637.46.1783443724151; Tue, 07 Jul 2026
 10:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <akaHPScetfl1VbF8@ryzen> <20260706210054.1336654-1-tadamsjr@google.com>
 <20260706210054.1336654-2-tadamsjr@google.com> <3fbfd30e-1555-4ce2-9cb5-72807c1a8b23@kernel.org>
In-Reply-To: <3fbfd30e-1555-4ce2-9cb5-72807c1a8b23@kernel.org>
From: TJ Adams <tadamsjr@google.com>
Date: Tue, 7 Jul 2026 10:01:51 -0700
X-Gm-Features: AVVi8CfqLbRNPK4Ya_pxHqk-D3eLGLGUgwiq3r01ghr-6Vc-yEEoP6FSnzLLKvs
Message-ID: <CAL54JgdpKG6VJ6GLjjs5prB7tH7mF-SCVdH-AHgCzBj2uCynfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ata: libata-core: Skip HPA resize for locked drives
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, 
	Salomon Dushimirimana <salomondush@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 11:02=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 7/7/26 06:00, TJ Adams wrote:
> > Skip HPA resize in ata_hpa_resize() if the drive is security locked.
> > If the drive is locked, the command to read the native max address
> > fails with -EACCES, which currently causes the sticky quirk
> > ATA_QUIRK_BROKEN_HPA to be set on the device.
> >
> > Setting this sticky quirk causes subsequent revalidations (after the
> > drive is unlocked) to bypass HPA checks, preventing the unlocked drive
> > from exposing its full native capacity without a reboot or device remov=
al.
> >
> > Signed-off-by: Terrence Adams <tadamsjr@google.com>
>
> Doesn't this need the same fixes tag as patch 2 ?

Hey Damien,

I don't think this should have the same fixes tag as patch 2, because witho=
ut
commit 91842ed844a0 ("ata: libata-core: Set capacity to zero for a security
locked drive") the problem still exists.

The quirk gets set not because of the capacity being zero but because the l=
ocked
drive returns -EACCES.

I think Fixes: 05027adccc09 ("libata: remiplement ata_hpa_resize()"), might=
 be
better for this patch.

If you agree, I can send a v3 or if it's easier, feel free to amend the com=
mit
message yourself.

Best Regards,
TJ Adams
