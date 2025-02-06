Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB323959E;
	Thu,  6 Feb 2025 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867346; cv=none; b=go9PBSJTnrmTeqONOocxTN5Yh72t2QwplAzGkptKp19pch96blKQV8yfdRziGEDsv9LQgZejUty5btEpcKaWfY02FjT6SWJEZ4TKrej6Q/Y9IMXSA9MK0gmx7UG6tZmxUUx2sEn8GDNBzHW0Im3RUl2vWe5ICcsteBTSwoaCl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867346; c=relaxed/simple;
	bh=ce5DL9ZePWRk+YjzbryLnyxQ1ATF+j1DFescgL0EKCM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=REOLPzYYsF5vHpdLoFt347b43eOwX+AsC3gzT914rrYGSCU7I0PlWQc40FKW1ub2ONpLj+D5c+YcWVaUoUIOPhrF9f6NG4pOJ8RVT7qaW5uRE4iFRAjANF6Q3wicObQ/j1qzS1Px64CTsfg12Ieqap2gpPQmQw0MkaGuwauxz3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5ZsAudP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5ZsAudP"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dc6d55ebaso166688f8f.1;
        Thu, 06 Feb 2025 10:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738867343; x=1739472143; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ce5DL9ZePWRk+YjzbryLnyxQ1ATF+j1DFescgL0EKCM=;
        b=D5ZsAudPJbHPn/GMrs1Trc3nx0w/ZvGR11rquQs718ra+GYttzUVoZhJ4bFLoMTDo3
         VvYclsgV/Jispfbp3VVp5j2wEIqMiNn91ndawjlc342kbSlumBAq9t70BloLibAJzXb4
         9fqymY5YeI+JKJ9LDTs1xTS83J+QkHlt6+7bEFgGlDF8x5IZ12Jr5ypp5nLXFyKxCXVC
         PdD6YDlfusk/4S/AIoNovqDgkQSsJI1GG90z5bX6YA5AFPt3jRacsouwWq9gyVjWc9be
         ilDuhQdn0Vg+z3E4wLRjixdjwXCGIn5pp3h/l2xHhSMSSDk4gQsAmxigh3zQeOv9KuJ8
         FFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867343; x=1739472143;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ce5DL9ZePWRk+YjzbryLnyxQ1ATF+j1DFescgL0EKCM=;
        b=GdRKG3Hb9Fx3vqln1WuAqQIBw0OZ5F7/vtzKguT/9zm83h74iFvt8/CSFqJzyX7qed
         FM1j/r23C2BVTQ5JqP73sk47RQDJK5+J5g2LKyq+xOt1aDgRL3JwWbJxG55NN9o9EZZW
         LRVLCsGFx7Q2anNX80CnVmNQMMXTykR1u3hyNIerUt80iKaGQxHAbisJikdMQBPkx4aR
         MdpQXvJVmm6qOGJQPDKtCKfOh8MPUKHxZrJmVMp1YXPWx/ONB7VXGczkkbPx8KhZq11J
         WaMgmu6g7mtludyiNNB8yUCQpWzfCgdabRD08mhJT9OyAq9tjxHNqr86rwfVnf4Jf5RR
         of5A==
X-Forwarded-Encrypted: i=1; AJvYcCX0R6JvYtOza2siHT91l3eI81E7uavFQhxI0etXcmpIeKS8dG30Z9WLyuZIzakIcEUDWpT5rCX8CWw=@vger.kernel.org, AJvYcCXQl33rUkQGmMh8kKNlTnvSEKzclSBtpV0YzB0lellQ7l0RTDHGQMDoTZ0VcwGWULz9dNxRIv8SC/AN9YIb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0pwm88e6JcSshRoq+gmKNzcuH+iKr4U92rNgbKKvFNbHdlQF
	uOsqP+2y2cB5QQlH5qX/WUQivxDNbb30+DGo6fYjV7t3a6uE3xaT
X-Gm-Gg: ASbGncscCF76k59U/OSTWHN+6B1BzPTK2jnB8KjTiOyqgc18uy7jImQ0nTEz5WLr47e
	xSN38NFXEpilNvVCNVsuyfHZVuF4BGXWxMNaWbKIM3p8AMeuTa21EOCzt3nfgO7LJbYcmfz8La0
	zCBf5UxrrymK3UzBiD0OrqzS0ZJ2SD0sm2DZx6dn5NQg4HBOTvC1Eh0aDmtXnJnBhhbTx7QkVfu
	zzq7CcqSynuQuizAqZvoyZROxgu//22qLdwVstFIQMVX/Nb76EqMxc3L1PVN14YgFwnYtYhR0Eb
	yuT/7zHkgdcJOWVKe1cTcNbDEw6yuG6a9L5Ii+c9BE4vBeiGIdb/V3mt7EfSZQ==
X-Google-Smtp-Source: AGHT+IEL5kUe5vb8qA5Yj4FQemd+Yf4TNdrQt7tvmt+1YPAXywV94VuA/TDH0jQPDyqKtb2g1BBePg==
X-Received: by 2002:a05:6000:1ace:b0:38a:87cd:6d67 with SMTP id ffacd0b85a97d-38dbb11f0ccmr3607027f8f.0.1738867343119;
        Thu, 06 Feb 2025 10:42:23 -0800 (PST)
Received: from ?IPv6:2a02:168:6806:0:8f7e:53b9:c5ff:c420? ([2a02:168:6806:0:8f7e:53b9:c5ff:c420])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde31ccesm2422559f8f.98.2025.02.06.10.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 10:42:22 -0800 (PST)
Message-ID: <016bbf83fec9a0a7c7697462ce0970b94572f50c.camel@gmail.com>
Subject: Re: [PATCH v2] ata: libahci_platform: support non-consecutive port
 numbers
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, Josua Mayer <josua@solid-run.com>, 
 Niklas Cassel <cassel@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Jon Nettleton <jon@solid-run.com>, Mikhail Anikin	
 <mikhail.anikin@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 06 Feb 2025 19:42:21 +0100
In-Reply-To: <fa54a148-6016-429b-b494-490041564e51@kernel.org>
References: 
	<20250101-ahci-nonconsecutive-ports-v2-1-38a48f357321@solid-run.com>
	 <bcfa145c3227b13e7b9d8bb3b0f92c678464cfdc.camel@gmail.com>
	 <fa54a148-6016-429b-b494-490041564e51@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3-2 
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-06 at 10:34 +0900, Damien Le Moal wrote:
>=20
> Can you try this to see if it restores the probe for the second port:
>=20
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platfor=
m.c
> index 53b2c7719dc5..91d44302eac9 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -651,8 +651,6 @@ struct ahci_host_priv *ahci_platform_get_resources(st=
ruct platform_device *pdev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * If no sub-node was found, keep this for device t=
ree
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * compatibility
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 hpriv->mask_port_map |=3D BIT(0);
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rc =3D ahci_platform_get_phy(hpriv, 0, dev, dev->of_node=
);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (rc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err=
_out;
>=20
>=20

Yes, it does.

6.14.0-rc1 (plus patch above) bootlog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Feb 06 19:31:51 spare kernel: ahci-mvebu f10a8000.sata: AHCI vers 0001.0000=
, 32 command slots, 6 Gbps, platform mode
Feb 06 19:31:51 spare kernel: ahci-mvebu f10a8000.sata: 2/2 ports implement=
ed (port mask 0x3)
Feb 06 19:31:51 spare kernel: ahci-mvebu f10a8000.sata: flags: 64bit ncq sn=
tf led only pmp fbs pio slum part sxs=20
Feb 06 19:31:51 spare kernel: scsi host0: ahci-mvebu
Feb 06 19:31:51 spare kernel: scsi host1: ahci-mvebu
Feb 06 19:31:51 spare kernel: ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-=
0xf10a9fff] port 0x100 irq 40 lpm-pol 0
Feb 06 19:31:51 spare kernel: ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-=
0xf10a9fff] port 0x180 irq 40 lpm-pol 0


Tested-by: Klaus Kudielka <klaus.kudielka@gmail.com>

