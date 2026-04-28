Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536BF347518
	for <linux-ide@vger.kernel.org>; Tue, 28 Apr 2026 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364154; cv=pass; b=h7Ty6TDYIz6QIqOAsP4Bt7NBg/32WBJUvXtbZmPcwC8ZboobIiEIjAyFYhgv6B2jus4nuUlQ1wW2NJcwO0yA0Cyr5qRr3Z5w5VL4KEL2FqRpHCtRRq/A2k1hMAsbaXNQgKVKpR5iOeUttSPg6b3C6Iq5joTLgNqcrQTk+hNDV00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364154; c=relaxed/simple;
	bh=KlcjeiG2q6/hWPJ95X5cbFemPX7rmwo7+sX+LsWddpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjU3wvgYXeWANzT3yD6fnamzafRxgx94RkKekLTKU2gjx1lNhsKIhS3sA4kmnIPq3ztv7riNcHahUDdzvofjt7Up9QC8GWjzEQptAbD8n461TGOl/802v7xLNakPPMtt66Y+6A7OsDMrHBPo0fSEh2FLatjH/uF42hYlGTcoX30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3AqKqoj; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3AqKqoj"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a3cee3a271so11088855e87.3
        for <linux-ide@vger.kernel.org>; Tue, 28 Apr 2026 01:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777364150; cv=none;
        d=google.com; s=arc-20240605;
        b=YSYHYlQE8BbTRkGYyfsMr9MGpMrt9uhc1FIyxgJq0MXZVN27oCkvf/pa9SOLWzA9r8
         Ox+Hz3o+DDyowGPNo1LPaDtQ0meIgb00vh3wtha4kqJKZrV4uBTW1DWTKTGsZ+V0T8pP
         TZKRPC3SQK10TAPfFQCR9pKNV69nvW60i7rbYLk2U4LAxGY48tNXQLc2gsg8h8Dfyrhd
         HboqPGn/LZV87tZ4nFrn2yehcLymyl8BlYXxE94bOk5rqpTy7p5NHUe4nJzhDHwL6NU8
         QAxreQe9y15dYVAziAVUN6D0eXIJyPwAR7Lxxjph76b6cIYt891KNoxu3xeHWVTq2lT4
         qvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wjfqRtDxAeF40hBuLKq3STaSSCgQmItO5OYkY6XEFg4=;
        fh=cy0L53ImaxLdFcfXb3mGJiOk2qQ0xf+iol3Kd+q8Jf8=;
        b=F42ej8toijUAI8svdLjBpYtrWMkMUA5siYY82OHmkJzAos7kumEbJaoGxxOi51P8c+
         V6sfN2z2ApkN+Gsgb4+Vxs9wnZZZcgjxZRg0yGIs3cbR7Qc+9BYIvqW58Yp402p/IZML
         WAalTqYRVPlr3VuRnVM8Z/1fMa8C46AlTwBoUzRem9nkWQE1prlQFjGJ8kJ6kBu8ZsC4
         dtUIF1VPvDlfujDeD0SGwGcOLQP/jeZESZtlJDs/2sx8bCadXWOIrEAJxZD4qllnHFZt
         4bNj0Z8XK29uFBnNtEg/E3gVkUuKTUpZDKBPWJN2F98tbU8fCqSGyUnpdNVv6RjM5YFz
         nbwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777364150; x=1777968950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjfqRtDxAeF40hBuLKq3STaSSCgQmItO5OYkY6XEFg4=;
        b=B3AqKqojccSyL8CAnbP1M24jm9SeZwSfmOrtMtfKo0gP7Q21kIC7s/2TPLZFu4Izjd
         3HIz7pAFTnlsErjFSBydIbLJFKVMneGPwXGFu5LWh9k+AmWeZMygr2Lp95o4N/f6Yjlb
         Bh1R1+7PBJyC2Ih3vONilFKzG9i4QHAZj9eYn/HK1XUcm6NzuZ69uyhV558k3r7GbFXH
         nD8+oLNhL4/M3jOGR9L4RJ86t+X4WwQM9U+gokgF44h611IIZAK4VpCE3qXyMquAyQD9
         MaFRZSPPSIfmyBn+gIcXwU7oIf0FBPnGUaK3q3gwwEfH85DxbXK/0Y+GFhKBIDueC6mY
         1gcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364150; x=1777968950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wjfqRtDxAeF40hBuLKq3STaSSCgQmItO5OYkY6XEFg4=;
        b=hU5vrqozx6w+93d0pb7h0gdKI5CJeje0TaWstE80zG+YlxB6n12RK8pgRqBuq9aZFe
         4ga6McvXbDg2rsKvVFXMWQYZpJ6ZLhA6GerSTz/KMEBSoVZbqE36xKeMoyCGCKsaeB84
         GGIE5Xqscpg+iP1mbIyxAMpmSNENyUIjNv8HWKQf+xgyHWGKspetwOzKZRZD90Y8cJdx
         o3fLjnmC/3oW6c49h/OhQMCcPlXkwA6is9rheExYhKXevKt24csDexxFD4G5Oolw0wUa
         akbbV1nDrLAMKd8sIA5tqY9oWKGjdmeOhagIk3egS/W+vBEiLrmzwX7kqZN33vRfDQ1L
         Jm/A==
X-Forwarded-Encrypted: i=1; AFNElJ+a4aEGQjOq1ZsnLQsTGifCwRlVeW5l6JegrBhl5vt5XMsrRgtr9yKmQb5m67U00NKLa49UslaX+eU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycy74JTusMEpEZFcRX5Z70oKFKQZ+ynxfPRyGfGOxnJ0/AdB/U
	cOVBxFy7hAnbnmq7t1l75gbxQndwfwjueMXHjUUnfkc+SD515PJE4cAxSm+HD4PcFQJIQVaMirR
	i+yiXIINWHxzkw+UgD72BEnFMQX9SpS4=
X-Gm-Gg: AeBDiesvSuEEgnWPK3BdRvSZOeMJ/i9LiWbGrJC2bqSuz1JsOc1ZFwGGOS+H6mWUEPO
	8fVNRm2d0dL5wPD1wuAv7livfRs7Lf5ScSk8CrIrQ8iTcEaHhO7BETMu1WCr1UJHjZrfe726A7h
	ehc1DX6EjJAT9tFuZYzhlLPOvAX8ztI4pPo+AJIb06Ds0TljADi5a9Ig5APViBqfyWvLQgcs+mC
	FH92wWAhB4Np8lIIErgDlOfet77i2H8CJHHhtFnyI17zjiEsxo/mfmb8vTx7Bl6UZe7HBXqlbGj
	7la+iWk+DwD3icLPBERVcee8o735hw==
X-Received: by 2002:a05:6512:3b11:b0:5a2:b903:3b43 with SMTP id
 2adb3069b0e04-5a74660485amr902698e87.7.1777364150184; Tue, 28 Apr 2026
 01:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419222355.5842-1-rand.sec96@gmail.com> <5584ba17-bc68-4d3a-aa63-0e18c3eff22a@omp.ru>
In-Reply-To: <5584ba17-bc68-4d3a-aa63-0e18c3eff22a@omp.ru>
From: Rand Deeb <rand.sec96@gmail.com>
Date: Tue, 28 Apr 2026 11:15:38 +0300
X-Gm-Features: AVHnY4J8dhmB2u9wuwORthp5dyqu6Vxb_-qwMg6EvD05Cu-TYFkzssn_rw5LVZM
Message-ID: <CAN8dotkWCxBT-Sg=Sv+nbZCdTD=DWoHL=Kb2atFoo2KgcCjzSQ@mail.gmail.com>
Subject: Re: [PATCH 5.10.y] ata: pata_sil680: fix result type of sil680_sel{dev|reg}()
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: stable@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, deeb.rand@confident.ru, 
	lvc-project@linuxtesting.org, khoroshilov@ispras.ru, 
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 4:11=E2=80=AFPM Sergey Shtylyov <s.shtylyov@omp.ru>=
 wrote:
>
> On 4/20/26 1:23 AM, Rand Deeb wrote:
>
> > From: Sergey Shtylyov <s.shtylyov@omp.ru>
> >
> > [ Upstream commit dafbbf5c57dd6ae01d20b894bc2200e9d9834c4e ]
> >
> > sil680_sel{dev|reg}() return a PCI config space address but needlessly
> > use the *unsigned long* type for that,  whereas the PCI config space
> > accessors take *int* for the address parameter.  Switch these functions
> > to returning *int*, updating the local variables at their call sites.
> > Get rid of the 'base' local variables in these functions, while at it..=
.
> >
> > Found by Linux Verification Center (linuxtesting.org) with the SVACE st=
atic
> > analysis tool.
> >
> > Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> > ---
> >  drivers/ata/pata_sil680.c | 30 +++++++++++++-----------------
> >  1 file changed, 13 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> > index 7ab9aea3b..fe60f884b 100644
> > --- a/drivers/ata/pata_sil680.c
> > +++ b/drivers/ata/pata_sil680.c
> > @@ -47,11 +47,9 @@
> >   *     criticial.
> >   */
> >
> > -static unsigned long sil680_selreg(struct ata_port *ap, int r)
> > +static int sil680_selreg(struct ata_port *ap, int r)
> >  {
> > -       unsigned long base =3D 0xA0 + r;
> > -       base +=3D (ap->port_no << 4);
> > -       return base;
> > +       return 0xA0 + (ap->port_no << 4) + r;
> >  }
> >
> >  /**
> > @@ -64,12 +62,9 @@ static unsigned long sil680_selreg(struct ata_port *=
ap, int r)
> >   *     the unit shift.
> >   */
> >
> > -static unsigned long sil680_seldev(struct ata_port *ap, struct ata_dev=
ice *adev, int r)
> > +static int sil680_seldev(struct ata_port *ap, struct ata_device *adev,=
 int r)
> >  {
> > -       unsigned long base =3D 0xA0 + r;
> > -       base +=3D (ap->port_no << 4);
> > -       base |=3D adev->devno ? 2 : 0;
> > -       return base;
> > +       return 0xA0 + (ap->port_no << 4) + r + (adev->devno << 1);
> >  }
>
>    And why exactly is this needed in 5.10.y?
>
> [...]
> MBR, Sergey
>

Hi Sergey,

This is a direct backport of upstream commit dafbbf5c57dd.

It fixes a type mismatch between the helper functions and the
PCI config accessors (which expect int), as identified by
static analysis (SVACE).

The intent is to keep the code consistent and avoid issues
flagged by tooling.

If this is not considered appropriate for 5.10.y, I=E2=80=99m fine
with dropping it.

Thanks
