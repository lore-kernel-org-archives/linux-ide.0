Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66717A300;
	Fri,  4 Apr 2025 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743758548; cv=none; b=Z+0yD4VX1UvUhLSmcXu+7qQu8czEJ1RXawDrHfeVazaW7a7JVz2SL4eej5h/saEpmXQsALsDbnMxcTLP9Mq0uSs/H0fVJirXz5NW4vOTXCwO/Q9ulrLSD59m4VqXPACqnN3sVi3YaBcTCtaN2uLuCMkmmwhlwDeuaNGGbZE1kdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743758548; c=relaxed/simple;
	bh=4Rmo1OIYfneloOqpbx4GqzJBdNJaS3RqAYXs514+VFA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=L/JuU95papleQ/EaT9t8IltZXcw0syPMG6xTDgWvTHBuACtHEdqYXOv7AgTVrsudAVDYiHK9uwuPrEvPtRMYKxiUOLgXh98/ksH5SwxpvlD+QnUIXHicXJXQGFeqkJ6dSX5kQ6sfe7rU0/jHcfF8XbPrN/zQ1gZEGn672XaT+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fqcdGoYj; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fqcdGoYj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743758526; x=1744363326; i=markus.elfring@web.de;
	bh=4Rmo1OIYfneloOqpbx4GqzJBdNJaS3RqAYXs514+VFA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fqcdGoYjwDCm73eGlCCAZmCCOCbDjUQ9eYSJdBu9Za/o8oVr5mpY9YyS3AP4lVV2
	 NU2rw/rUURCTfRgfDK6uDHoK6TU1nTB7jPUQavnfFi1XibrBcuEwiV0Aj0MUcbwZi
	 PZ0H+J6dlpwc6BpOV53L/sOrS7QCV1OaGdvXHc6HKs4+2EilgtRrD9Fy3oumHOKys
	 sGMATqyjHLjtPB9hRUL8IgSplsgkEjL5yACGNPDAwLkCvUJfqAIJECMmUsQ+Vmdyf
	 lDe3b1i09zCBJcFqKct4ghNe1IWjNI/sHMvfm26DQvFISlqd0VB80bVNuRqGIJzSu
	 H4Dzbq8zLFuRpJmCaQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.27]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Phi-1twmxc2nks-00A9jP; Fri, 04
 Apr 2025 11:22:06 +0200
Message-ID: <879740e3-d485-4150-b0d4-538cae5bf39e@web.de>
Date: Fri, 4 Apr 2025 11:22:06 +0200
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
References: <20250404061438.67557-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v2] ata: pata_pxa: Fix potential NULL pointer dereference
 in pxa_ata_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250404061438.67557-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J3YN1v4LFbVMz8/fgW2pgoPiU14nM8S6d3tgV9tJZBA0RllY44A
 MNj+NSWfeT/oG3dfDfVsRozVlly4vFCTVH58Sn1yhVzw06o/xR4gg+fkIIN7+rIBZTiFqK5
 4onzODLvNLj7zu9gJekp3ayis4SRyL4tj1+Dnw4DjdOpEBHrE5RPSxQ1fDy+JLR7AUI5WUC
 fvK56f/GDVbygLwOZW99w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5EydMVgJFUU=;524IjyqXC4wNhljffufiWc/e2EB
 HMx6wUUgxnJ7+NZEvEd8wXbuqoUr4I9SYAYmNAS2V+8j4k6oQLQFJxXytJybprKktB455fKne
 tfLQtuW6+4d9BzK77tR7wgxmNnMRCWCuC16Y0ITkEpqu6y3qWtTyHqMJ//yhTCOMiR0gejas7
 +HSZ6I36PCOqFXcs77MceIZpBzYC3NW2zYJPR7C3ZciRZ48lKVQ6u/eRYOckqssL9q6ojh+3e
 js1X0ZZAeG/3dF+B/ryUmwsvDM0+ykOWXELJjkEmJlPzneHke51mjTkcVxohJHMrg2j4AsdFk
 w2OK6uB13hqQrhHnTTCE7I7FiVd002dJxAziDFqGNWra53Ob5HpfbXWpyIMgcOs+4sO+OYLE4
 uT6KHB2k2OVyShAn3oxP13XqXFcJJQbEspRQDMLB4432YsRdIikSuQ/D1qAJAQKZ5xgw8tSw7
 pkb/cCTmADMYlZsG5evlHEtCoY8YOYty2RmgwD6kJxFCMaVw9DOcadobPFRkF8SKzwSP/s/f/
 Hop2fQmzf3bPk0urPEFcPkBzXeauuPKjntm14Xjjwukp6jJrvWO+jQ+VFuWhQufBj4LJvoWY8
 lcuJy66+Z6XcizS0CN2IQ/cqGlEG68EhW/DTWKGPFXo9UNMi3YJBvsecHR+8lday3rUi1Lk+H
 JUq4w/P49ENNpq69HQEpZ2+wQ9o6qY79o43glXI+NKW70FZIbzUd06G6O80JYKeTXnm3J4O/7
 jI+xIvXbGc4wmidtOAiKowB96X+WoUzd0IVzT5NHzwtgSJK+01VU7sdmq6WypHCKKmM0UqtTG
 S6KuMRWcoUHhc7aw9cqM2yiBb26gDVsJXr5oxnWZ2rSLMbE2HDksoY2otp+FY0OWTFgTAjwr7
 FhVYF11gR0RPc+HOxDM93KrGgvuB+L3xIELEplsoggN/mBVVEwEbnphfj7brC7wSJPYFTRkBJ
 GQcd5/zkwv7V9Mwqys6V4VX2TKoQZkByFp55jdIv159bmgdIBcOpeyxjfXECpCkax9zIv/WeW
 FvRSTaAY85iVBOflGqosMGocx1UGU72KRp7y4jRLycK9ZYb/0DGD7kksplvdouuQlPQYMBJuu
 UOE4cR14SF7yiWk/fu5xPV0XSWeUo5k9hiVIMgo9A0dhLY28y7vsrxzHTJKhe6fLrnT4j3Dgl
 TdoqPHtG5HxUz6q3Q64bkHSvQV6lHiJw+Bc0mnxEGMPFEP5hyeqZpjIK+ooOWsepeC7appXc7
 du0l6PbZbB1gg2beZaS4a18AkIJE/ToAFwPUAsPKk0WXLcfDdhfSMCgDGU4FJQT932tQz3iFV
 YH9KuyeROJQU+qRUHc+WhgSRu3HsTrukPt+kR9zu28r2ExUl+WWHy90mFpvQs6sq7PvMNjXK2
 lkQnMQxSsFstSkaNRRjvBWzX2QSE1nzzBsPgP9YjGf9vnyno78Fafec2O8GGnuxYuf039Xkam
 nQLcr3/stuUSaCzzTLCQ/zug6RuU0+lFaAUmTcnYyWk3ow38pX/+sjhV3m8AIkk0VlbmjUw==

=E2=80=A6
> Add NULL check after devm_ioremap() to prevent this issue.

May you omit the word =E2=80=9Cpotential=E2=80=9D from the summary phrase?


=E2=80=A6
> ---
> V1 -> V2: Correct commit message and keep a blank line after check.

Can such an adjustment become helpful for any more places?

Regards,
Markus
