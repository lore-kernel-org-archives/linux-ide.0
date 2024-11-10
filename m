Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60214264A;
	Sun, 10 Nov 2024 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731230739; cv=none; b=WbCLVrgc3RETNnD9nkBAVOJ828bej+EbFk1UTEYRhOVBpwhGQd9HsDsPFKpnCD7eLbgTQcSJUjNy3kJY8I+VGIvYDd87QcE/eP7n0wLbcC+m8bsU5i/Ekp5TPFYhC60OsjtYLDD3euHUVzIhfeP9TtopbLj1/LHkf2t4v2NGuZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731230739; c=relaxed/simple;
	bh=Qaqre+jsEhO0tkFSo2F1PLyonrfGswTYb/oXllxHJMk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZAX9L49tBcnE8fbC795HISk180ZRnvFXvLT6X6nRXJw50+64Ut87sDs0HlDqs9FhGAkx5GvmEGtc4wYf4QCwEBK719cah18pGXAivBNs6LUzNh5aCBmul6Zf/9uEC/JFBV8uXDshLl4dbh2Iqnz13GQU7+/duNy9DvFw6uxEtmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=jSoSj08a; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="jSoSj08a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1731230715; x=1731835515; i=frank-w@public-files.de;
	bh=ODiLHG2Ffc5cmNLj+uQw6bBYYjn+EFVvea+2eMhlgco=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jSoSj08aH6c/G2nMMCpmA4VNk9L6/tGDjjuv1K/+evYySUMrcK95HHIMifrgsdDl
	 7oLbJx7klxRd0wj8sCe/WLg90rOPI1p89/By69OmMP8RceklGb/eGTxDcD1Oqhba8
	 WZwF7eYxn2EIIEZhRChmlnCCYT/ztsI/yNnKsKDwXhTBrZJ6CvWmVFMammSpjJePk
	 pS+1DFS/LwLyPdJDtJ6mhYCFO3tuK5uj4f/qs+fimR9Thea6ovxsEIE/uiHk92f4/
	 8Sg3oTh3uheil5EcUu6uqEUDgANFaJVAIWTR7cOylm42+5GjjdiEswpyjk7L2sGCa
	 5RtrBlS3RRpAeYNTzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.152.71]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Hdq-1tCo0v2Sdu-00GIb9; Sun, 10
 Nov 2024 10:25:15 +0100
Date: Sun, 10 Nov 2024 10:25:13 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Andrew Lunn <andrew@lunn.ch>, Frank Wunderlich <linux@fw-web.de>
CC: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Hans de Goede <hdegoede@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf conditional failed
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <e534c723-6d65-433f-8ab5-1c0d424d7367@lunn.ch>
References: <20241109094623.37518-1-linux@fw-web.de> <20241109094623.37518-2-linux@fw-web.de> <e534c723-6d65-433f-8ab5-1c0d424d7367@lunn.ch>
Message-ID: <9B1A5D20-3DE5-40C1-8B2D-B1C4F53FA5F4@public-files.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:maTSukvmMra9qVKvHkk79WQlRTYa0IZQRVTxBhre9SYrZ/pYGoA
 r16LNgxS3BAgLczXLgdXcJZ5CueuvVkMLMUl3RrTNuT9G3Pq9APO5LNt/oiW31lCHPgyqvf
 vX1FO7mYRP6ILBNbwSNKRYMnxVSNBpV4mjcD+SqyWDmocMGWPFnZ3do4wgVus8xHCF3878t
 L2w1h8sFZeTMzaWwkVRcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iV2Z3Z0ITEs=;c7adgpma3OaHJNJrenNxn9fHEun
 EmVbBaVYsLHkLqwLL/mhit20Vy0Fego5GuDZmMXuY1980qL5C1+aTBC5pHPXCzHvkNDfiqLxi
 UQCUkVlGpfbLxFhBLnO2ii8+OCacYRrIMyB4rB085cZiLnnUrc/WE8Y+IZXL+RFbMlr8c57rE
 gObYmEBtKIbnf/3gDUQb3hAExsDN0asnZ8qZUs/4UD+oNtpFlTKPs4SjCUQhnPeRTMo35wYrn
 cqy/k89qcGAMbeb/JsU76T+lNKQUYgI3HlEjWChbmHYPyWHmovmQ4qXyNQineqGy3WLbRazAl
 kzKvktjRhhFrGx+R+3olIC8k8OrK9sKIv4iQCFZfmWlWz/6Oig+hMW+/TAYxpcTAkxwnSu3xE
 NFr+G+xYNiMVyacURCCttgXogQblKigQ/DDz24Im6lCPmxYBNN40oSxDUCJL/lbNMUCOSQVhF
 n+AJ1xhdVQ+2j3EATfmULHPryDQeyVXCxTrSo1DqXBbtE+fRWPqkaiaVnj0DP77tZegpHijJw
 7040z/5tYHMsGUcbV8+cib1P9y2k3Z+WxVG0KubuMdZWV8cCitDT+mxQ2Ss99TTbixlufYyyc
 v9AWtO2lUn358IaZJHRlkUXan0xiWDOnhIJIpUg5lTg2hJE9goIxZnPavd4CX+8L+kgJ1egZZ
 bZnG1GF9xgdjtxitfaPeoD8WhLHCJ5fhjZ2aIhMMAonfRM1nDBeFEHG/+WLsuTbS4IjYTMjYC
 Cp1RgKTwLe7oNmpHIEoDvgGpP+3pjMBebwSZigU48enkeRETf/oQChhCjDOHhern3AexjqLmQ
 0qGJ7/UAeSoWDxII3E1T/IXg==

Am 9=2E November 2024 18:29:44 MEZ schrieb Andrew Lunn <andrew@lunn=2Ech>:
>On Sat, Nov 09, 2024 at 10:46:19AM +0100, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> after converting the ahci-platform binding to yaml the following files
>> reporting "'anyOf' conditional failed" on
>>=20
>> sata@540000: sata-port@0
>> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db=2Edts b/arch/ar=
m64/boot/dts/marvell/armada-7040-db=2Edts
>> index 1e0ab35cc686=2E=2E2b5e45d2c5a6 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-7040-db=2Edts
>> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db=2Edts
>> @@ -214,6 +214,7 @@ &cp0_sata0 {
>> =20
>>  	sata-port@1 {
>>  		phys =3D <&cp0_comphy3 1>;
>> +		status =3D "okay";
>>  	};
>>  };
>
>> =20
>> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin=2Edts b/a=
rch/arm64/boot/dts/marvell/armada-7040-mochabin=2Edts
>> index 7af949092b91=2E=2E6bdc4f1e6939 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin=2Edts
>> +++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin=2Edts
>> @@ -433,11 +433,13 @@ &cp0_sata0 {
>>  	/* 7 + 12 SATA connector (J24) */
>>  	sata-port@0 {
>>  		phys =3D <&cp0_comphy2 0>;
>> +		status =3D "okay";
>>  	};
>> =20
>>  	/* M=2E2-2250 B-key (J39) */
>>  	sata-port@1 {
>>  		phys =3D <&cp0_comphy3 1>;
>> +		status =3D "okay";
>>  	};
>>  };
>> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x=2Edtsi b/arch/arm=
64/boot/dts/marvell/armada-cp11x=2Edtsi
>> index 7e595ac80043=2E=2E161beec0b6b0 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-cp11x=2Edtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x=2Edtsi
>> @@ -347,10 +347,12 @@ CP11X_LABEL(sata0): sata@540000 {
>> =20
>>  			sata-port@0 {
>>  				reg =3D <0>;
>> +				status =3D "disabled";
>>  			};
>
>I don't know the yaml too well, but it is not obvious how adding a few=20
>status =3D "disabled"; status =3D "okay"; fixes a "'anyOf' conditional fa=
iled"=2E
>
>Maybe you can expand the explanation a bit?
>
>	Andrew

Hi angelo,

I guess the dtbs_check only checks required properties from yaml if the no=
de is enabled=2E

As you know, phys that can supply different types (sata,usb,pcie,*gmii,=2E=
=2E=2E),but only one mode can be used per phy=2E So only one controller can=
 be used with it,the other(s) can not=2E I do not know marvell,but there ar=
e similar in mediatek (xsphy) and rockchip (combphy)=2E

From=20my PoV it makes sense to check only enabled nodes for required proper=
ties,but i do not know internals of dtbs_check=2E This patch is 2 years old=
 and i only rebased it and run dtbs check with the others to have a clean r=
esult=2E=2E=2Ei can test again without this one to check if anyOf is shown =
again=2E

regards Frank
