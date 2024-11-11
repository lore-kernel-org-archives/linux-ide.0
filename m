Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C341ACDE7;
	Mon, 11 Nov 2024 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361158; cv=none; b=H0izaI4Ej1GCzTOybt4Wu2x7KmI8uYA/kSb3D7JkWtb3eMf97ejiZ0Kc/pk8TEeONZ3Kg38+gdfmUuqnrRceb4XmiFxCBBHUqp4U6LgieyeHAGFrUBsKp8r4uSB3+VgHXMzRMcTztW8ZYNskZi8nmhODrpVLI6X1cf0Vy7rryk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361158; c=relaxed/simple;
	bh=k9fi/wMt05QJl0EOikn4hjFaFoyDi5Lzu8k77A/z9Vg=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=Z1IjIsqbLHSSlcZb0vaClSPM05hmMaly2xAMJ+CDKxOahhjc3a8IVZ63wGCW3bXmxuYi38qtgUpaV8VqehIkpzX5k1DeZo1H2i21qUe3M4nYvGGA7X47au/Ka7bSkSUA843wAhqhrYTaDsqu/h9r+S6jmAE42RoXQ3uS+BgUJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=IzZ7oBQO; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="IzZ7oBQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1731361135; x=1731965935; i=frank-w@public-files.de;
	bh=k9fi/wMt05QJl0EOikn4hjFaFoyDi5Lzu8k77A/z9Vg=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:In-Reply-To:References:Date:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IzZ7oBQOyEiCrH8prKN3AoowZ+tzYyhgKeLfodvK3Us+ijPIy+lGQaDfKLBHHpGx
	 L9kZ48UpR+vQvTdxj+MCBx4EWixuiLaqy+GZWgA73QT7cu6B3rvVC+b9XwICAjZSX
	 YYVByP6c7aSrTKKq3gaexYRLR81+UL1SKC79G2Ohgtp8P7TnZGiY3v1FdAh4ovW6W
	 S8cKbdlxTQfLzvSnRif2hIw6BJJlg/f5BmDlgw6i5LTY350u9HpOwSPJe3lsr0fVx
	 MzRtIrAEcJLdM7wf1kmBMAK149oRPiSQfpnRZJvZ9F+CxmhBMJL/eN1GRDqQKQlsV
	 ED0jYQw7HoUfvn3l/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.144.196] ([217.61.144.196]) by
 trinity-msg-rest-gmx-gmx-live-67cd9ff8f8-2ghzq (via HTTP); Mon, 11 Nov 2024
 21:38:55 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-eac86f41-95be-444f-b081-796766a36d74-1731361135346@trinity-msg-rest-gmx-gmx-live-67cd9ff8f8-2ghzq>
From: Frank Wunderlich <frank-w@public-files.de>
To: robh@kernel.org, linux@fw-web.de
Cc: dlemoal@kernel.org, cassel@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk,
 hdegoede@redhat.com, axboe@kernel.dk, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Aw: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf conditional
 failed
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20241111203611.GB1887580-robh@kernel.org>
Importance: normal
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-2-linux@fw-web.de>
 <20241111203611.GB1887580-robh@kernel.org>
Date: Mon, 11 Nov 2024 21:38:55 +0000
Sensitivity: Normal
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:lZR0DvsH3QX1w4bKctCowevKaTXuw4Ks9EBIr2FuJm2doKGM884LhonhVb8nA2lv5ILF5
 f7N7GMRSrRZwrTC8GMLJ3Q8qkVVevozVl3WYlcAZ5tG2WxptRB6HGt964d/Y3lotAh7Wp2U77o7I
 jp1UNl1j0T4tD/9cjCiOeWiaSDw99XPXBoT75DkcDMn0JWLQ3Xm2xz+VzmLjR0GtAI0rDrNUGy0G
 cZ+2lwLxIUABcArbWOwOLv96kRmBm4wq4kVQJo7g06KjZj0zDqYQM9dMxa9oIWOLO129Ovnuda/z
 qJ79hHbvkOVg2cAo8EW5+EuPfda0hmPdyKavi1rfjMw9ypQKKoPOjzWtzqJ6CNWOAw=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nKyzwVksTyQ=;xsBUYsyaU+Khx5EKGnKqsTpKBJ+
 4EOGZ9kt9eJt4K4wvxj03PJ3hU9VnZQSoJEC4H5LygCPdpz5gpBetVqQ3CdlYk3yM8cFo63hk
 HZnBrBpnn7tnIsJSanrudi/Q5psnqmApnwu0BoV5lYKzRHQqWr7ondBeblc8qwYhWgQhCkuPj
 rWzQvDdQ0nNN0xYwin6HMpBPqPbPFSknn+TlIlnt6NSq2d7RxgeRHsnjwNMg/gvTxz/w3Ydju
 wwJKOwDvv3EaKefgbcZLW143Ikrn/jT4RyzMaIKLwBDvWIj4xAz8YHWFg1AmcANWdad0oCsM/
 WDlbZnqNqVDFaiuMUARgp1qlFjtIB2P7VYuML7t6F03BJQsDDErDhO+anUjclENCH2X744yMF
 o56RAWYpv4+AR1DkeTspOYqCF2KnswZgLAJTuOu2c1MUrfspuCjLTG2NXvE8XdFWeAHHE2KTD
 KZGnxQlTeXVDjSXhEJ/9x/DP5R6+gER5i9DIR4a2Lapp1K3cxLRcySeM3o3I4u1xCHvKXczp7
 k5Zj8Pnv00lvZ2VPVohAc0DYSQkZo9uxURT6psmhKaz2Mo9CBCaqyabdskzNNSg0nwFe03qn6
 ayHThBl+wiYNJfDKifTt9VEFxs2bwy9pLvLMvHtezwcccW4RaE2Iy7ZcGVmNXYPPpkBQlfE47
 s+y+vsxpLKtrMhE5qbNa+peJx1ixRvqWx09pMGbdIA==
Content-Transfer-Encoding: quoted-printable

&gt; Gesendet: Montag, 11. November 2024 um 21:36
&gt; Von: "Rob Herring" <robh@kernel.org>
&gt; An: "Frank Wunderlich" <linux@fw-web.de>
&gt; CC: "Damien Le Moal" <dlemoal@kernel.org>, "Niklas Cassel" <cassel@ke=
rnel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <con=
or+dt@kernel.org>, "Andrew Lunn" <andrew@lunn.ch>, "Gregory Clement" <greg=
ory.clement@bootlin.com>, "Sebastian Hesselbarth" <sebastian.hesselbarth@g=
mail.com>, "Russell King" <linux@armlinux.org.uk>, "Frank Wunderlich" <fra=
nk-w@public-files.de>, "Hans de Goede" <hdegoede@redhat.com>, "Jens Axboe"=
 <axboe@kernel.dk>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org,=
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
&gt; Betreff: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf conditiona=
l failed
&gt;
&gt; On Sat, Nov 09, 2024 at 10:46:19AM +0100, Frank Wunderlich wrote:
&gt; &gt; From: Frank Wunderlich <frank-w@public-files.de>
&gt;
&gt; Thanks for reviving these.
&gt;
&gt; &gt; after converting the ahci-platform binding to yaml the following=
 files
&gt; &gt; reporting "'anyOf' conditional failed" on
&gt;
&gt; Here and the subject, "fixing anyOf" isn't very specific and is just =
an
&gt; implementation detail of the schema. "Add missing required 'phys'
&gt; property" would be more exact.

imho it does not match what patch does...i do not add required phys...i ju=
st disable the nodes and enable them only where phys is set.

&gt; Rob
&gt; </frank-w@public-files.de></axboe@kernel.dk></hdegoede@redhat.com></f=
rank-w@public-files.de></linux@armlinux.org.uk></sebastian.hesselbarth@gma=
il.com></gregory.clement@bootlin.com></andrew@lunn.ch></conor+dt@kernel.or=
g></krzk+dt@kernel.org></cassel@kernel.org></dlemoal@kernel.org></linux@fw=
-web.de></robh@kernel.org>
