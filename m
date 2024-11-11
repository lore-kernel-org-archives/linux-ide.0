Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973601EA80;
	Mon, 11 Nov 2024 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731305679; cv=none; b=Hg92KOODhjTemYcFrohdRQVF7/3RPqw71EFpGkDcM3xDa1C/8XfGQBzwzAp3hM8qxRG8yOEltA0rFURqd24G7D0N/jI3uFptxRYWArHBJrwrE6EALDjaBI6/u7uN85USQgaJSjjeHlAjI2WN96KPBDyaCMHUEdUg7wcwy2aL830=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731305679; c=relaxed/simple;
	bh=r00k13bJOtFaWOaYvtCwbROOQSCXB6VqNkV5/x6pz8I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WXJ8xwNxKDT1Ghpg1LJ/5+d225guXGbAs3V1NVKLsjfNvylEev/ilEHxWDl6nbpNztxlSiMGEG6d+MHGS+Zp9FE/1X2skXI7r84wL0Q/suw4BEED/vFVPHBNCmP335T/25Q0jKyUc61NB9BM8/a/t7AHlzH+zdFOYmbKfkzsQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=hfg7tzu7; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="hfg7tzu7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1731305657; x=1731910457; i=frank-w@public-files.de;
	bh=r00k13bJOtFaWOaYvtCwbROOQSCXB6VqNkV5/x6pz8I=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hfg7tzu7K0UMRwCqkjh6HUY82atbVacbqfe0PkrxTuj2yRI3J8ED8IRAuvN9tzbv
	 /9LZ+DyTF0g9lq/UBsYnq8SkTU61zvrWqCp2BMKdukqHvJCdCGyhc/+dFGTYJHdK2
	 GFvzKRe1j7xbkfbIlI8cx+bLSaq2TiHpMhSmoSZhmvTYUqrZUS6SIwTpZL1Arlper
	 jOdF//6tb8oJ0r4/2BfaT4CBhi70hSVliTnKHadIKs6OjlJXbR6I7knZr/F100aPH
	 jjuP79bxXldXvISmek9hZrbuatoo0nIVjTVITqNh9AHALFFQEkK5Wz0z56tkU7Ev+
	 Bj/eD+kudPLEIVkN1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.144.196]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKGP-1sz6Cf3dJR-002K9U; Mon, 11
 Nov 2024 07:14:17 +0100
Date: Mon, 11 Nov 2024 07:14:16 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Damien Le Moal <dlemoal@kernel.org>, Frank Wunderlich <linux@fw-web.de>,
 Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Russell King <linux@armlinux.org.uk>
CC: Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_2/3=5D_arm64=3A_dts=3A_marvel?=
 =?US-ASCII?Q?l=3A_drop_additional_phy-names_for_sata?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <c6dade2e-fd8a-4a7b-89a1-b1276d8e9106@kernel.org>
References: <20241109094623.37518-1-linux@fw-web.de> <20241109094623.37518-3-linux@fw-web.de> <c6dade2e-fd8a-4a7b-89a1-b1276d8e9106@kernel.org>
Message-ID: <C415B917-DE36-42DE-96A8-E1A90A049375@public-files.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BKOFQ1Mi9FnHIK8Ipfu90R0zSkYFQC5djJf+f2dKjZ+vdGbr2/0
 O9nRetLYm6jx/ouWj9NqiQoZo1SYKtJukrGPlVSoeqhDpASqWXBB+3V/QZuGzcaWNZV1svd
 Sb69X2rjnCjoheHZJ9hj8cKBMPs5IXq9f319YzgnWRjycWmVcUwbiXCTZeHvvFh55DcRogM
 BMPs9oUhvNKkBI+39kmzA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tD1zr+Lt7VM=;Rb6j5Bsy/H8+ktsYyjKppjnEP6S
 iwfCAZskY7YuYdTIhzwCOL/+d9ea7hSGaRF9OutD3sRG7G2iIZK5NALMRuPRuaZjdt1PgGBOv
 4AIWIUN32VJYSz4ODf++vGe5dqRdTTeG/kFKwkRtrXHpyqrqTXmgo0Wx0CVC49hvND5gg3v2Z
 aPIiDbXw4K/4zYQZi/iPJvktkwfcst8TEbW/42pLP2cqDSL96VHhww29vc+BnXvYa2740zC36
 q62b7KU+iIcTAIflflVfJSMx2xNiS9JVvw2ZFSSoVi5YvqRbjpx/cTyGp2OTgnIDwwPabfMtG
 Un8+hD2dAOyDusPIEZOg+COJ3JHZS16Cagj/2SyVm5qz3fIfjuUp58H6lRQL/IeFMK799pm3R
 Jnfnj9K1/CZ7Qqz1ucpSOcKbHIS9vs3IVorS2YDBS3D0nED474+H1ZTTs92sOAev12h8FDafM
 2aYlk5hJD0icP9+mTCgozNXrbqnKDODTE39aPME9LCdqkWChhPzONOw3cqsKynMqML+ZsIXuo
 Plw0b6c5kUQGoUBex6NdS8DfB1BqerYTh2DmKHFoojoltHNCZLitZq0/446WAUTDtzpmTkw07
 do33YEn9FnzNBG1Q8Ap1riBKhjjFXQ84vw+NBm2YPseZWLEWMsY2UaBxjhHgkXX2NPgRZq+h1
 AV/9NAU0U+r3g8DMRCS24UTS1yChT/RXBpCQgkJJ6IgAet5+YT736WiNdYlPPKBvfNb5nknaL
 ixX/jQ+MRw+oEkBCJOR/IxqKsjZOlNKQGH83ZiYn6sEzST3+0yVz5p781jytl8XrKdckLqp2G
 KXWuFRqBJpa89tvWWRI7Bk2Q==

Hi

Am 11=2E November 2024 01:05:48 MEZ schrieb Damien Le Moal <dlemoal@kernel=
=2Eorg>:
>On 11/9/24 18:46, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Commit facbe7092f8a ("arm64: dts: marvell: Drop undocumented SATA phy n=
ames")
>
>Isn't a Fixes tag for the above commit desired here ?

I have not added one and deopped from first part because of this:

<https://lore=2Ekernel=2Eorg/linux-arm-kernel/20220315024952=2E3we7hiwrksk=
b4tsy@vireshk-i7/>

>> drops some phy-names from devicetrees but misses some=2E Drop them too=
=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>


regards Frank
