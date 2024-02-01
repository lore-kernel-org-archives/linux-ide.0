Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC921586C4
	for <linux-ide@vger.kernel.org>; Thu,  1 Feb 2024 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771537; cv=none; b=DupBfVyePOhpdbXQygmWyZBZ6P6Tz50El8JZW2Lurb/j5d9tzSW5bB6dgGtniwDRu4+k/b58lyjB+kktoFs0A1eFjWSV8Mb88mX4Yoex4EpTDrhl2nRNRT5RAfQNwurt/icPsh8LyPIQMpgS1xr6A+IVQq0h261eXLP06bymUZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771537; c=relaxed/simple;
	bh=vMoYAWcGduUBGNkxAgLOaenzfD7j4UePnSo7IMHVIDA=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date:
	 In-Reply-To:References; b=aeQ5GLxIuHVZE5gCqRSZKmmRTdyNylQrpLZs85fXflZI2uqHBKoxxwgJFaB3MYQ7YzqIU8dWGT9EM5PyK4U3u5VwMYmfVe5RHGOm9b7BVolNhxQlysDl9p4uERr8x6QRqbVJlYlCgO5r/FQdjNO6XLm5mpoYBIgVSC++xYuDrF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=dmummenschanz@web.de header.b=wqnmC6pJ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=dmummenschanz@web.de header.b="wqnmC6pJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706771527; x=1707376327; i=dmummenschanz@web.de;
	bh=vMoYAWcGduUBGNkxAgLOaenzfD7j4UePnSo7IMHVIDA=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=wqnmC6pJ16mQRWtRe3eqAS0gydnIlj8O7sNJRSPilJ4OM3XvyN7n9TUvTC0H13pa
	 ef7cJ98YcE/bNyyYE9Ek3ieqeNpp8LRzVB18aFOWtjoaXx5dSlK5Yq1vGnvYbllJz
	 Z95LEDq2gd5WnBRprirvN4DkkM5ac3/y011TrXeZ9KdYdCbcE0zDIoO+lRXzu29xV
	 UaoPFdkH9m1GQMHdx0XhgiMmHmlcaOobOgKlmr0jGfqJicoy+MhuvAFUFuhqRQg8V
	 tBp5WgczDZlUfR5R/hLLgVF2jB4ywySiafVeiImUZb5HdKivKRGMVL6xMpiXLjU4c
	 +Cck6q1dayO2vQseog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [45.130.105.48] ([45.130.105.48]) by web-mail.web.de
 (3c-app-webde-bs18.server.lan [172.19.170.18]) (via HTTP); Thu, 1 Feb 2024
 08:12:07 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-f42c04e5-aa43-40a6-b65c-ff6229421bc8-1706771527600@3c-app-webde-bs18>
From: Dieter Mummenschanz <dmummenschanz@web.de>
To: Damien Le Moal <dlemoal@kernel.org>, cassel@kernel.org,
 linux-ide@vger.kernel.org
Subject: Aw: Re:  Re: Re: [PATCH 0/2] Power management fixes
Content-Type: text/plain; charset=UTF-8
Date: Thu, 1 Feb 2024 08:12:07 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <1a7f5f79-95d2-4efb-a76a-6b7cd0cfe006@kernel.org>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <DU0P251MB082515FC8FE77424231B475CF4682@DU0P251MB0825.EURP251.PROD.OUTLOOK.COM>
 <345be856-8959-4148-bcae-00b3fbcd0d08@kernel.org>
 <trinity-0be6e8a8-e6d3-4d60-be0d-59592a9edd65-1706010022623@3c-app-webde-bap10>
 <a72daedd-48c4-4eaf-9a77-a34679636a8c@kernel.org>
 <trinity-0df92d73-be55-433c-bdb2-4387f7ea590b-1706686178879@3c-app-webde-bap43>
 <3f7cef2a-5ba4-465b-a1f5-77e2bcc50ddb@kernel.org>
 <ZboztvrqKKdLQ1mt@x1-carbon>
 <1a7f5f79-95d2-4efb-a76a-6b7cd0cfe006@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:yFFF5ed6QgjAnY/kfbKqxegG/ico4oREslYUE19MIOR/OSbjkwsKlcMpNi6CAe8srmQoE
 HhxDLXLyhTLId/PX2JOwFJD+00q93GCwYpkzESykcVsy8x/ScskktZlv5O2rn557uBntk31v36mW
 TS+eZqtU1E2ejpMRzd4OLxSDKeCwUzIf1Tg2ww179x682XrU5fnoEXcc2FlbXWlVkRL/s7DyWuuF
 fFW1j2xyC8qiy5hDW+3PKnBgY9x7z7Mn+cp4MgHMjz4iRcJ9cnBctkDSX7wBM4b8nOypg7cbROvC
 tw=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d1QqoweSWL0=;zjmyKVaIb3QdDVWaf2MPH9iuYhF
 K3SMHCikV0Oy8LelmfIG513uVyDTK/Y94yU37FTkxZbW19VbxWc6EeFK4f6Qn6pZ5pL0K/26q
 bfp4RC4ZfStojafxt/W5cI8N3MZHqYQfWkNuc96FO7O+OkgBii8Yeo5Knx7ev42r4WyoDX5OI
 TGgtQKYqyQXm49p1bezON5ttI1vAd0ZV2pqOsJgdcBDiHXzyATLv7K7q+vPPt+nQyzOal81FS
 R8lyif4S7W+XmZ0Rijnm5QvnqmHT9ZGSwMOlllCrp223oR4jV19zlJbVnnojJxAXISXdWGLK4
 Qn5tu1G+kr1n9Uwp/IjKZTNtbmbiEKHC9145w/RNqBc/lCU0o+zA6BAERFF/zS1y5gOU1f3NJ
 zuMF6c2ikQji7IB2/K60SflgxnSXvuj5FRFl0Ti6Y4uyx7EFINT+C/F5KBUFqb/MGOAWenORQ
 8tUkOKfSCIX/ZvZ9nZLl0PdSmW37d3MyF6QwODKi6gRxtvxMazNcU3+I5q61fTapwndho5rRH
 iL003dDz9oukmkX+/Z/RVaZi34SWzfVMoNxgnk4grtmxygOIQQThZt3gdfl/T7ucuN1Y4/kpQ
 +3dg2Kj28u7TVWEGXVewrOTRtkRhtvzo1gwcuG0S6HAt0XCj3cM6gj86+r5fcXr7vesxYj2dC
 v2uLUBAleVf/c0orgmYet1I/VdyVInI4Heg00sWHsj95XcyOelAJ/jXLI5kRKIM=


> Indeed=2E What is the AHCI adapter here ?
> It would be interesting if it is a Tiger Lake :)

No It's an older Coffeelake/Cannonlake Platform=2E

lspci -v |grep AHCI shows:

00:17=2E0 SATA controller: Intel Corporation Cannon Lake PCH SATA AHCI Con=
troller (rev 10) (prog-if 01 [AHCI 1=2E0])
        Subsystem: CLEVO/KAPOK Computer Cannon Lake PCH SATA AHCI Controll=
er
=C2=A0
