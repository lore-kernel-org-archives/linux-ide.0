Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A108218E050;
	Thu,  3 Apr 2025 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665618; cv=none; b=kVWL3HLo9TFENxw5+kE6rh1pNGl17E/jO+anhMnNU0qYMuXTQionAUikxwVLoFGydir4VZyFk32Aq78S8dYBN0eN9K5oN4OklaJOyJDsSyBFkn0BpWPk4vNg2PHw3h9RCvrRfv+PW2BDT2Lud7oc2puwJjZtDC29OD1Bq+s9unw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665618; c=relaxed/simple;
	bh=dJJ+aUFzS1eJ3Y+9Uq7t/cMOdPGeVZ8qrjdzXaqiXCg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NQClmyun/LPXFp6X8aa0V0WLbcZELXv5mXLaBcRNDB8+VCL4dmAysRfZ3RPzBpjylxBG9z1n31rI+8QYrue8UjV+bxDKBe14IrJJmOHaHKmEA1MUcukdlhwGdaK4S7fKKjwnSv+nqbaeVwO1nbpanQhEBRrdJIXAfxsuhPlDnOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QAjUFM7M; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QAjUFM7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743665608; x=1744270408; i=markus.elfring@web.de;
	bh=aWI+DAOkP8WUf4wenIkcfrLCKPmvyIpL6FkBiQFz/cc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QAjUFM7M3lzEHgelNCdeBpnSmnoUgkRzn2ZBjCh66gmyYtIItmC0hUUkQ0qMAtCh
	 u0E/DNuJGlM98+56VNrRTo3clzRyt9UmmlhDg9Ulk0m2cWKg2cl9cotccuBQ8kg63
	 qBNcT12nMQ24miHhDugm8VGgZv8Ak5q5acUOJjXK/afVWjMTu3D0E7sxWdp7EnWqR
	 jxacQSWjUJyHdNIO7aijqWGqowmjW2Cz7oc1BIL1B9RHrfz6KKO8EBJF/rl1UOEIa
	 xBh5xUpFi71je/enktmw8g+NCJnELcdNsgkouwLUhR48M9Ns1MjwB2XL04xcr+BhY
	 M/LMQ6hPFY+fcTTWBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.50]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5CQh-1szzn30GJB-00s9jR; Thu, 03
 Apr 2025 09:33:28 +0200
Message-ID: <d795a7e3-1558-49c9-85c8-4139c7699304@web.de>
Date: Thu, 3 Apr 2025 09:33:27 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
References: <20250403034520.59597-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH] [ARM] pata_pxa: Fix null-ptr-deref in pxa_ata_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250403034520.59597-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P0596af5ImOODw9qjsedMeKjJOPssNC8dnN/AZJ9h6TIW8YVTf8
 KI/7kJYBiSNSYPOCyxv9tnm36HB/WpYy/w5gyCJR9YO/1Ngy0Yq3Ns53qNi9L+R8XEU3xBL
 K/8utBiuIP6ltVp+KpOoXfm5Xb4Bhv9xmRcikkKaphpNz615Is96Etz/w6KeghN3gy2QxRH
 /obiBRuP09LHwVD/gSYzA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xF30ZRSJXlI=;NYQzFuTKlmtshV9ccHiMBtvtyNg
 KFZXVaNxkuavLV0gydzsX7go/AYBD0vgaLceKJt3EzLo+xtNJkZ2sFBwmyrxy7QRMvSMF5yLK
 HoTZhRAaUjzSV1F4K2XmlsNNuJgPWPlCJIg5BXCjSKUx/hVNKSt5ReTxut91oIBJkBsahjL5U
 53qFYaA7nKe2y12FfcmYbfmY/WoQq96cm1JKPiYR2MREsvz8vmrRDzSExMXipPKYaiUn34eoo
 h25x62rIZ3g3Y7QikYYuITsLumMo2RBmHQl9EY5SBVE7yHkaSPa9vyObEZpV99Xd+dI7BXVyS
 lb98thJalKPseKae1m3v1X0ZVqEm/XWJdDAHhuv+xQtaSWapLGX4hinah9l6BJ8XoAkT9CBJY
 G+taGF0uQkm9NTWec0k/urBg5cgLTcBfyzlDg9refbu60VgKp2k3NLtrDjp4JbZSc9rM4QOSE
 OWYcnHZSYjmWYnq47I9/tlW/WL6MFSO/ovurkHVrygXtGbBYh04e0c3iaocRiG0G0ZeLLxvkc
 6N6dnmOeCL0M8XGvJYuKBjb7CA4sJQ7ETPVPNcMIWZdpXGEB99Fc7aK/XsdmjfnE9QAGntA/r
 NIveEFU+f0+sZqBPdlhyBLUj/6izF4wDXaOYv6IPy+D2mmIhkVf/6yD8laNTJPVZNbcuujR/s
 rI3oQ3hrK5zJqu8i8qVQ0hBdP/agtR5EgZ4Wci4QHEY2F1a/ZlTUJFs44U5c8wcDuYznZWsOI
 YI/RQt+D0Fl+h/V8CwMdUrIQVXh5jhJAe4197PbQBr5dpc+9S4iVaODoGfVy5LsUAbG17gh8A
 Q5eFeBfnDTZ07IUMRbK7T5R0o0jsQ7xWxkAbnl9KE1Y4SPK9ENZ+Q/0RbYoFtbDUDtpXTSEEB
 1BzTIBWK6PTuGuU5kF8U28yTJCMST+xLAnuOeVLnmKL/SBmRgQ5k4f22dr74lboWOevAST9dO
 Yde+Hkk7xl7X2F3/YpDNK21HAdpfgyiNmD8HtqwslqHvF3kCeeFb1nBr18L2yeEcfYEL0CCeK
 L8ueEhv4Icl/mTBpFtFfeD4kU/+IDfN53jRh63Cn6oVdwotI2aZxil+LpqG/WULhW6Je4uVSd
 mtF0qhpeoi8uaRe+42KH3rel3v1MwFTnI7CzA2kEW2kfcET/mMFXQM2aa73xU2luEavdPgrk7
 gc5tyV2eg6HvYNCI8G+6PWvdx98hnj6Ea64/wV2PuMpOLfWIScr88vG8U4o+zNGqiVm3AGTWI
 ZOA+MWhFg5ezn9izFvuMQg2Lm6YceSQoInAjX8NwM9t9k2McuVJpLkRJ5SQD4AesYlhPhPBO6
 WNR3/Z1p9cks63q4hBmJ05FpgElHRpZaIDO8Rjb6Kt69+yHHF8ZSWTqwV8plx3FsxFDuI6LJq
 IFqF4UbBLiO1CZopU0OJTEmQBg8HwwgUWoJiLoBQkyjAZ2D4neYmzmiN5ASph6Ly6xR6/PVNY
 ia/95pUWSr4Lj2EInuKSfzypJHTqR37/abk3W8oJNH/HegR7V

=E2=80=A6
> Add NULL check after devm_ioremap() to prevent this issue.

Can a summary phrase like =E2=80=9CPrevent null pointer dereference in pxa=
_ata_probe()=E2=80=9D
be a bit nicer?


=E2=80=A6
> +++ b/drivers/ata/pata_pxa.c
> @@ -223,11 +223,16 @@ static int pxa_ata_probe(struct platform_device *p=
dev)
>
>  	ap->ioaddr.cmd_addr	=3D devm_ioremap(&pdev->dev, cmd_res->start,
>  						resource_size(cmd_res));
> +	if (!ap->ioaddr.cmd_addr)
> +		return -ENOMEM;

Can a blank line be desirable after such a statement?

Regards,
Markus
