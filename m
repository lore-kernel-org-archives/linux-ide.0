Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C92319BDC;
	Thu, 28 Mar 2024 01:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589752; cv=none; b=fPpOgDUXJv4XbuEEvddq08hjPTeg+rdilIBpl6p30NR6omHa8hb320bPiatXSEGdWgwiMbN1GSpxL7cqjVZToAGnodxTPeLQIAIIfWWSoBoBZHYmlvLiXKwe1VSp1Bg21tGPL6reiT6P06qtJ7gijagXNR98Lx0C0tLRaOOfB4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589752; c=relaxed/simple;
	bh=HfCbzi8iUVRuRXPUnHYEpkSXB7JL7W4MBDRSe1+IxXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7pzaZc+UP1NXWTE3MORmLLqOCcfK+Ikg2jgO1aZ4LdazV/vo3BdtGGXnRyRr0lt3PSJOUNlTu4JXpkYllRUo53akNIXSkHSVGaPppwlvEpbNaLIZ7R2AGhQ7uUgSrM3byHv7APq8o9Tv7m8Na1BFiFwzU3QdivgVTVw/ojTfiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFnqRYBo; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFnqRYBo"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22a8df1df8fso281231fac.2;
        Wed, 27 Mar 2024 18:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589750; x=1712194550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfCbzi8iUVRuRXPUnHYEpkSXB7JL7W4MBDRSe1+IxXA=;
        b=HFnqRYBo+ePG2iCtMG4XqTCCeLzy8IZx4Ff4VrnZIZ80VfpIf4dJZrGj1aS6wH+HRk
         0YdNeNnxKmqhEdqMWQLEfdj2o1wpXm8RS3gm7CvYvSsjlMGgH1FjOcKqzKirbJLmpb3G
         Ot7MEwtF7ASi02JBcLh+tX844bVgR9ormQTK63Je1gGDzJZOQxNZFVqtrY4yhCRNvg2M
         r7u4PJsGociB8humvFkvY5I/es/5WHrT13TGoK9UZ3lneyDkchRk1PNYGZ6TVI9qpeRX
         L1vZmaIWnWjXaRY41Bb1LacZUuBvm2yqtWqE5lPqKu26B02q2VR37PTnBbGYiUK6YCSw
         kGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589750; x=1712194550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfCbzi8iUVRuRXPUnHYEpkSXB7JL7W4MBDRSe1+IxXA=;
        b=Gsqgyc4luF5tpYkiVCp/pbXBUcOYnK3lqSAjkomxKFFLhZBesSMlRkwEwB+mA5naet
         KtxOhd/qec4DfnEo6eh4+/FmikUSPFfLp14tesTmFngc+JXkC+rZr9FRvcEi3RF1I8NY
         h4w2gU1hZXlu2qIFYa57GeZz5mexXPoDUHgR4t7C+f6b3XQ5o99nYUEX53Y3/VODQKVu
         ES0P7dkGK7nv5Hjmv3w7B1YmiBee0JmEsgJlr49Tcl6slx1yn1T0eGWPX+5jXxeItpv1
         1m9JT+vweHI1KjI3ZTZgOqRal/UlPWNly+6Iu8YLDImjfyaMxIycGr7C4zzOr/yaxMBe
         j3gA==
X-Forwarded-Encrypted: i=1; AJvYcCVC/GBUiV3Q9Lv3+Y+w7wxlk0rmPP+MUUxK+0EExbsq3KIAmXB4hyzy8brZULKJMzV3zQJREREx6EMCwXmv+/GffnOG5jKo3VLafc8J2NbFuvo50XnBrdzhW544OqVDUr2DxSBzSqQooXZ4chOOD1ofs7aFoz6ZFWGecGJeneiwFNQdbQ==
X-Gm-Message-State: AOJu0YxacMm9qUV0Jr+/sN/sreVamC2xrZkdjygOwMjH53rSfySR33ew
	XOXVXF157yL1CKhKEn0Ht2VoDtkiXo331dGiQWzthUs63iPbzlbYY5IW0gqhJodNvZEZJjN83Lz
	IaTXB9eljlrKkqhp77b5tmZTcdUw=
X-Google-Smtp-Source: AGHT+IE6Ex6sHZHlYYGGzQjS8RUfmkMjquUXvGQaW7YQlgTb5Ytuef8jZUPtpsotLo59rSKibxc9Wsl5F6lZznxqIDg=
X-Received: by 2002:a05:6870:3283:b0:22a:3a53:df4c with SMTP id
 q3-20020a056870328300b0022a3a53df4cmr1528136oac.44.1711589750154; Wed, 27 Mar
 2024 18:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327064354.17384-1-animeshagarwal28@gmail.com> <20240327-dumpster-capital-fcb7d205b294@spud>
In-Reply-To: <20240327-dumpster-capital-fcb7d205b294@spud>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Thu, 28 Mar 2024 07:05:39 +0530
Message-ID: <CAE3Oz80pwN3J3fzbX-U1Ez+hNb_ismLCUcy8F9NXWZMCLPnRpA@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: ata: ahci-da850: Convert to dtschema
To: Conor Dooley <conor@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 10:16=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks Conor.
