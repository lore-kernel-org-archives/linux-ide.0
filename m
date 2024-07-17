Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DEC36AE0
	for <linux-ide@vger.kernel.org>; Wed, 17 Jul 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721207113; cv=none; b=P/ECqGKYisqYhGYn+fcZd7cwSNhyTkW5+ByBh3fIMPEm1knY7wHA7k6sve64s8RwEs+0P6cokYTwFtTiGSCXuF+C1ws1jZL6JOG2P2weE7iCFJ10AzVS8Qn/LYob2h7IPhqNYHqyuTqdrH1Bm3K7gBABSOSZXZL7peWKNMiQTqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721207113; c=relaxed/simple;
	bh=ObqfQUtYDie++HmPt5ZorDO9+Q/jMbX9mYkwseqns2U=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=VftkDFcbITWXJcRMnvkHF6LuH7C92d0jrcDbJ2GzIsqGUf07PAzsa3UouJ8+vhAJ1MATZ0Fwt2YMP3+jLThl6z3dacv48qJnrBoakupwF0ZIhcBpklnxwGXSZsuoQyQqdAPOhK916I9WhcONstExUlHS9wU4S9cAmgOMRLoR2Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E6duU5ZO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6duU5ZO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso45795545e9.3
        for <linux-ide@vger.kernel.org>; Wed, 17 Jul 2024 02:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721207110; x=1721811910; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAzQXd9LJcp02DYmVNQFa1UX+nCqT+MKPqGArjh8hKc=;
        b=E6duU5ZObJ8feswjlHLkAkFu6WdVPWjcS0JN/QXZrat/20NhOgO/uQcBwnz19xDt54
         BTSRXjnni09tkMv1/blCpbuKyaxLFyvzXZJJMafwf0tyVhbH8zjnwM954jm9FeRfT+2X
         xEGa6L9U3nXg9AfMu4zOydOkmjNAjnqFH699q6ZzThfWuBBYKNL/hXXwbvUPAjAOJXMr
         Om9sGJH1GHR2YyCQ+zRcUNrvy9IeducYIlAC8LpyVCKC6cEyhd4GlRM4BtqVQ3Wr5+g8
         IJMfSuuBJTG9BhqhnS3TFO+si/OhSIURc0St+NZb0f4YM/sbqeSKRToV1aTH8yOa/SPf
         4r2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721207110; x=1721811910;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAzQXd9LJcp02DYmVNQFa1UX+nCqT+MKPqGArjh8hKc=;
        b=GupSWkCIdAMeAc+U896tcDi0m3r257efEOhGqnyM8rF7RguHgojwPMnZTKCBszFWBi
         GlWGktNf4tEcwackeC1Ud4DDd4c9+c1qjtMa0pvcFZ6XlhMgx/sJbNAakAW1gXgjkHlk
         FWSoPI9N8p4V3QoOvJwFozIntF8eDkikAa+YLPEEFEzsJQk0xAQGOuau032ytS2H9LK1
         S9+x5O/7eYOsJ+CHrQPaKukycs47p4csZAN4HTTpok/76iW5OLcC5IW2eeyjwSuV09Yu
         8HIZW0+c7OsXAwGaTXqZAn89F7EpjEBlQWxyKzw+8x3qYg4dJOJ/yej/Kqj6zd6a1MYn
         wGQw==
X-Forwarded-Encrypted: i=1; AJvYcCVpFaalZaaRVIlcWCW7Uk/B85T3jfOh+d1ePsqspOogYEPiJzdiXGNp4VtfDengTXDMp/p8hslt6MbIdtbKNcpAHvGcukuYydFj
X-Gm-Message-State: AOJu0YwoNj54kSehmd+Is7mOB678lSbAyCcu+iJf89UWIWOhn9fOxhjy
	YDX1wsNWfFZ7pKvDKosCWjoKzCx5eSpCTXtVZ93Cdp52MYIR326Vs/SLAE4XYD0=
X-Google-Smtp-Source: AGHT+IGa1tDli7v6EaGQTMt/tidR5Lrxr8FuvL748K63FzAfgBVSYo8+y/5aPRJPTBufRud9pKlU0A==
X-Received: by 2002:a5d:4843:0:b0:367:89b0:f58a with SMTP id ffacd0b85a97d-3683175d0admr787786f8f.58.1721207110081;
        Wed, 17 Jul 2024 02:05:10 -0700 (PDT)
Received: from localhost ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db048a8sm11095848f8f.111.2024.07.17.02.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 02:05:09 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 10:05:09 +0100
Message-Id: <D2ROZY3KYF19.3KJC3CS82AWMO@linaro.org>
Cc: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Damien Le Moal" <dlemoal@kernel.org>, "de Goede" <hdegoede@redhat.com>,
 "Jens Axboe" <axboe@kernel.dk>, "Konrad Dybcio" <konrad.dybcio@linaro.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, <linux-ide@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Rob Herring" <robh@kernel.org>
Subject: Re: [PATCH 1/3] ARM: dts: qcom: {a,i}pq8064: correct clock-names in
 sata node
From: "Rayyan Ansari" <rayyan.ansari@linaro.org>
To: "Niklas Cassel" <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.17.0-0-g6ea74eb30457
References: <20240716105245.49549-1-rayyan.ansari@linaro.org>
 <20240716105245.49549-2-rayyan.ansari@linaro.org>
 <ZpeEq_QmV-aerpCW@ryzen.lan>
In-Reply-To: <ZpeEq_QmV-aerpCW@ryzen.lan>

On Wed Jul 17, 2024 at 9:45 AM BST, Niklas Cassel wrote:
> On Tue, Jul 16, 2024 at 11:45:59AM +0100, Rayyan Ansari wrote:
> > Correct the clock-names in the AHCI SATA controller node to adhere to
> > the bindings.
> >=20
> > Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
>
> Hello Rayyan,
>
> This patch is 1/3, so first in the series.
> A patch that is first in the series usually has no other dependencies.
> (Unless referencing another series in the cover-letter.)
>
> So is this a fix that can be sent out separately and picked up the
> QCOM maintainers / ARM DT maintainers directly, or does this patch
> actually depend on patches 2-3 ?

Hi Niklas,

Yes, this patch does not depend on the following two patches, I just
thought that sending this as a series would make sense given that
patches 2-3 would surface this error (as we can run dtbs_check against
yaml bindings but not text bindings).

> If the former, I suggest that you send out patch 1/3 as a standalone
> fix, since it does not need to be blocked by unrelated DT binding
> conversion.

Ah okay - for v2 I'll send patch 1 on its own, and then patch 2 & 3 as a
series.

> If the latter, perhaps reorder the patches and improve the commit log
> for this patch.
>
>
> Kind regards,
> Niklas

Thanks,
Rayyan

> > ---
> >  arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 4 ++--
> >  arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/d=
ts/qcom/qcom-apq8064.dtsi
> > index 81cf387e1817..277bde958d0e 100644
> > --- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> > @@ -889,9 +889,9 @@ sata0: sata@29000000 {
> >  				 <&gcc SATA_PMALIVE_CLK>;
> >  			clock-names =3D "slave_iface",
> >  				      "iface",
> > -				      "bus",
> > +				      "core",
> >  				      "rxoob",
> > -				      "core_pmalive";
> > +				      "pmalive";
> > =20
> >  			assigned-clocks =3D <&gcc SATA_RXOOB_CLK>,
> >  					  <&gcc SATA_PMALIVE_CLK>;
> > diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/d=
ts/qcom/qcom-ipq8064.dtsi
> > index da0fd75f4711..dd974eb4065f 100644
> > --- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
> > @@ -1292,7 +1292,7 @@ sata: sata@29000000 {
> >  				 <&gcc SATA_A_CLK>,
> >  				 <&gcc SATA_RXOOB_CLK>,
> >  				 <&gcc SATA_PMALIVE_CLK>;
> > -			clock-names =3D "slave_face", "iface", "core",
> > +			clock-names =3D "slave_iface", "iface", "core",
> >  					"rxoob", "pmalive";
> > =20
> >  			assigned-clocks =3D <&gcc SATA_RXOOB_CLK>, <&gcc SATA_PMALIVE_CLK>;
> > --=20
> > 2.45.2
> >=20

