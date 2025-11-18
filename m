Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A312FFDCF
	for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763497450; cv=none; b=nlySwUHgwpBXGtercHarIM8EPwQhpOQFzDlbA1N/HDEt5UAVnfQKXg8BGo6Us/84eQ5aT6MBbeKR9H9X94/oxKhzMWU3UeJkv4DS6L3YnZFq9iqdOnZo7rqJcFrq9rIZVYTfJ0hHf2Uc/mMk2moPwOQza/PEyQGmxfjoEtEzqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763497450; c=relaxed/simple;
	bh=R3+zvlqqoxiLdsn6EdQgkldaoF04Hat+X4WcYHxUgBE=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=uLLkwHZaBEkHLhU/o0+8w3oa+KR1w/Zq61EVseiktuHpayaBxoLPzG9Q0ICTCVFGPeSW6w4Ec9u31yi8lEsvqIt5OibkZfk5t2o2qEPb60GfqBK9BrADoTDkNa2d8AdQR+EtlwsY1xVwNO576YbbNwUchJRZIFs7qrwPK2niAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=Hf8ibx9b; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="Hf8ibx9b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Message-Id:In-Reply-To:To:References:Date:Subject:Mime-Version:
	Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=p53L0BWr/DGDPg70meRhqKrK0lytmPZuQzqLwcDU0AM=; b=Hf8ibx9bqtnCiewvUzcNPQ1dEl
	KhdjbVO8YtMLNNBComXVIQKhBVHh3cMFDNdvVUX6ZCPsRM5pJBN2WtzyfT2E6Df3AmHPNULDIkGwF
	CzKddltxxK1r7f3OvZrJR9a5SWYuPiJcq1Opu/3HDYC986S2kO6Po9/2fKbpeBMogf0G2gc2Yeb/R
	i+sZ6rMNTSQHuUTxUE03vWe2zMIyoLJfUvnw+9Sor/Et/drlc59HijHrzguiOg1SYro5G7IiJ6sdA
	FxgfaXb5Bk/PsKaUxPCPmOXR1AMwtlvT23QqtsphtsZO1poURPzIZaYaugkgSM/UPXaDv7V0WN6SE
	zus65gGQ==;
From: =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH V2] ata: pata_pcmcia: Add Iomega Clik! PCMCIA ATA/ATAPI
 Adapter
Date: Tue, 18 Nov 2025 21:24:05 +0100
References: <20251118.174654.1384716262322584447.rene@exactco.de>
 <aRzSMYp-i4RDYl-l@ryzen>
To: linux-ide@vger.kernel.org
In-Reply-To: <aRzSMYp-i4RDYl-l@ryzen>
Message-Id: <F9CB8C5A-63E9-4736-8975-8CB60CCE96F3@exactco.de>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

IOn 18. Nov 2025, at 21:08, Niklas Cassel <cassel@kernel.org> wrote:
>=20
> On Tue, Nov 18, 2025 at 05:46:54PM +0100, Ren=C3=A9 Rebe wrote:
>> Add Iomega Clik! "PCMCIA ATA/ATAPI Adapter" ID to pata_pcmcia.
>>=20
>> Signed-off-by: Ren=C3=A9 Rebe <rene@exactco.de>
>> ---
>> v2: style and sorted
>> ---
>> drivers/ata/pata_pcmcia.c | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
>> index cf3810933a27..caefcd8c4b3c 100644
>> --- a/drivers/ata/pata_pcmcia.c
>> +++ b/drivers/ata/pata_pcmcia.c
>> @@ -344,6 +344,7 @@ static const struct pcmcia_device_id =
pcmcia_devices[] =3D {
>> 	PCMCIA_DEVICE_PROD_ID2("NinjaATA-", 0xebe0bd79),
>> 	PCMCIA_DEVICE_PROD_ID12("PCMCIA", "CD-ROM", 0x281f1c5d, =
0x66536591),
>> 	PCMCIA_DEVICE_PROD_ID12("PCMCIA", "PnPIDE", 0x281f1c5d, =
0x0c694728),
>> +	PCMCIA_DEVICE_PROD_ID2("PCMCIA ATA/ATAPI Adapter", 0x888d7b73),
>=20
> Don't we want Iomega somewhere in the name here?


IIRC this string came out of some pcmcia tool. I thought it came out of =
the device.
Is it not used for matching or should match what comes out of the device =
IDENTIFY
or so command?

	Ren=C3=A9

--=20
https://exactco.de - https://t2linux.com - https://rene.rebe.de

