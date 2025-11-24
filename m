Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C5B261B6D
	for <linux-ide@vger.kernel.org>; Mon, 24 Nov 2025 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764017516; cv=none; b=nP+iKNecc5Sm4NVzCm98xXpw3C3MGHdX2qW4nt/RcFBUZJ7N3R1GzI0eYJNVIeQHjM3cYkx6kzT6WpIu2ixRQDAQCPKnmA+FKL9McADgjbRTH05Dwg1bqvNsrhlsXmJxh5qedpw6cPj1w9q7sRI2+lWXTjWBc3OOXvn+fZRQGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764017516; c=relaxed/simple;
	bh=TNXgHjdHW+7hCc9KU3+HDCu1u7r/n7D9WCP2ChH+81k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+qiTdHT3MKocElSZ7hMx2FfWz5FJGiS0iU6URRCXYSYhgJ7QS2yO5UpyMzh2zWSRoh1Ge1yq7b0tmYfoZP/lmrA4RXB746MY+FwbBIDU8/NaBo26YfWwzsBgk4LPqyYx1BSlYKNsPuF2WKeMMUMjSBvNkHfsRkVkgKkgUpHAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffO0HsDz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffO0HsDz"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b728a43e410so865070466b.1
        for <linux-ide@vger.kernel.org>; Mon, 24 Nov 2025 12:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764017513; x=1764622313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNXgHjdHW+7hCc9KU3+HDCu1u7r/n7D9WCP2ChH+81k=;
        b=ffO0HsDz6iNDtD6Lx9GMR6DAh/1hXYkQRra9vNG/xNAfujD6LpcjDlMy3N/JbfEILO
         Y4fvXSxQHHUxrjNrGEmUT3db/sYntkA2zxN3UPQ4vowJZNyDRur8qH8o4i/Q7OEIddik
         OGvgq51YdMMwtdT4t2vs9Wg3fgZgBMN9m/Uh0ZuGON9mOq9K5JDn8WBVbMiJtNr6tHR6
         2MsiUqLuUu5qCJVQrsHdsyp73KEVlX+tJoF5gX3dNy0d5YwIOtTM5cNVORHt9gZXgwqa
         7qd8HGEHY9hNsWjz0thQdUvRXJeaW5hmCUdKmEZEvWrT8n8NNJZJHo9RY7SVaEJE10VD
         7Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764017513; x=1764622313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TNXgHjdHW+7hCc9KU3+HDCu1u7r/n7D9WCP2ChH+81k=;
        b=pwXiCj4P4z08nQ+Zn9Zo2Ql+7dsEz4a67uXQpbs6EqfagHxTCgHkkipRH+cA3uzjGJ
         O90c216Iwz1bHf1oFd4Q5iP3v5kwu50JteRupW1K+UulvPKoBX7/T3ciXuEoC2p5j1FY
         vOsVEkfRJRQWosHBzGiV35RuxyBVQDrnQsSndvt7V7mrPsYsF9FOLt+CBgkLM1qC60if
         sGLGfpMuGaLFZ8EhnoUyTODqu7ehb6Wyu+jg3jGRdaox/X7fwKRZ2k5UGzD/UBpztLMI
         setyFBIb5FPXwoVPArjKsXrK26YzSYvHiuBVuC3hQVMhTZI/vkbIwcDbmtpX93/YfqUN
         j1LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKYl8bRNrZRc6HSg583rtj5eGOGo6qtVhY/pRgjPLpXUG43pw+VLcpcvesHX9rXrbGuxnse8uvIEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhr1a35+ZfZph80LaQdWUzjCn/cUH6jwFYA4zerKlmBbmNpMeW
	4BglKU2rg3ecCi0Z/RMYxwpvRERxqKKohcwwYsifFhfI2DtdHLGTGNrxJ0WcyfQqZ5Wxa+JD9HD
	5GaB2vuP+DVCBTmLSy64zMoTCJn2E0Oo=
X-Gm-Gg: ASbGncs2xOC93tsoV3n0yMg48KoRFRFPIugolU6igIXt4zL/LoxtvDHH3ob10pVeNq/
	5EUUsK1MiD2Zh1emT0sNmiUp7Yo5luxu8W5rXkm3mCYKtBip3qQe22nuoaXPO5At0WaorPYnuCs
	iMP7jQz0I0GHELDrrPjRZTxMqbr626vuGJJifARaJ0fhVgGOaxVte8ETxrX5X+Q9znhZIRvpQgP
	kxrouJF1ob+S6ZHvwUn7VhdhrnKW9sxvQ216KIFos7jpL2vcXnt/dV1B6ae6fl/mxnYgW1n
X-Google-Smtp-Source: AGHT+IEolpqh4VyTkys/PixTi5XkV8Lp6IrK5gzaB7Nab6YNMUvfFfrOi7K/QletWC/MotglssbNFUwo0tdIvj2NZT8=
X-Received: by 2002:a17:906:9f96:b0:b75:7b39:90c9 with SMTP id
 a640c23a62f3a-b767188523cmr1603334566b.51.1764017512827; Mon, 24 Nov 2025
 12:51:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124134414.3057512-5-cassel@kernel.org> <20251124134414.3057512-7-cassel@kernel.org>
 <aSRnLyyopCslI4jT@ryzen>
In-Reply-To: <aSRnLyyopCslI4jT@ryzen>
From: "Jack L." <xxjack12xx@gmail.com>
Date: Mon, 24 Nov 2025 12:51:15 -0800
X-Gm-Features: AWmQ_bkdiUxGLwsTCKR5miKsgK_IVveTD7egMBBIpe9iZjHuC3l9RFoj8KV9r5M
Message-ID: <CALeGphywgjdp5hBFsvb8+_RXeAKY16a6d=egSFZPZsK-d_x_UA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ata: libata-core: Quirk DELLBOSS VD MV.R00-0 max_sectors
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is there a way to test by setting the value on the cmdline or setting
a /sys variable?

On Mon, Nov 24, 2025 at 6:09=E2=80=AFAM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> On Mon, Nov 24, 2025 at 02:44:17PM +0100, Niklas Cassel wrote:
> > DELLBOSS VD MV.R00-0 with FW rev MV.R00-0 times out when sending
> > I/Os of size 4096 KiB.
> >
> > Add a quirk so that the SATA controller is usable again.
> >
> > Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
>
> Jack, it would be helpful if you could test this series.
>
> We know that your hardware chokes on 8192 sectors
> (one sector is always 512 bytes in Linux kernel code)
> 8192 * 512 =3D 4194304 bytes =3D 4096 KiB =3D=3D 4 MiB.
>
>
> When you write 4095 to max_sectors, we will set the limit to
> 8190 sectors.
>
> My guess is that your hardware chokes when receiving an I/O
> of anything larger than 8191 sectors.
>
> If your hardware still chokes with this patch applied, then
> we need to change the quirk to limit the I/Os to 8190 sectors
> (which, thanks to your testing, we already know works).
>
>
> Kind regards,
> Niklas
