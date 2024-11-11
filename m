Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3361F19B3F9;
	Mon, 11 Nov 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351030; cv=none; b=coXdSC5HFZQkbHmsfMMTOafhUwiZ3xpIJZK1dU69U2yQ4nOBamxlPyYGV0Mp31/3KZ0YaEIxQCBTQCiy6q5QSV6odpNjTiQQwvG5Bf2RCJRNUOzJUip3Mzc+/q0EmG4Wk/pT0gKfE0pfNaIQRldLRcJsgwOhUuLq6GY2FiZqOt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351030; c=relaxed/simple;
	bh=y5vtfq2Cf3dQpqUQecvOkB5OhwQcaUej1WI0Wb2c2tc=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=UrJVdXbrZ+KnfxhSwCP0HUwOiib/WIMVb1J4w6llIV7FNctQNpjXJb63xAjJzdv7LNiglMyFHeVQZNj6aduOieU4M8bFeO7Hb/X4ZuV5/xAwt/M0zNbumIhQQCLxQ9ZLNYATuQofU5ibg2kI0SHrs+PPD4oCC7M7SABYaOIgXic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=oGlIN2uu; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="oGlIN2uu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1731351004; x=1731955804; i=frank-w@public-files.de;
	bh=mTLhO1kTOoQKkiWNympYWNxRE9YaSNUlDtJFuAoJjS8=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:In-Reply-To:References:Date:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oGlIN2uuTLEjOgWZF4hAVcHiLRweuVkBpJ6c3hkDHkQnnjxZAzaKDJWY3QEnTKpt
	 qQ9FOvPa5hCYFzUB+YuY9ERq92ceJ+7fT+J5lbhjHUfgdkzMMbjNprQEqYW2JbNTP
	 mqMfa0gpNapyvfXqxiMTdC3Ha+I1BK2Qt+7yQ5leQmJ6d15Llk2AUoWaiRXPkoDlM
	 q/3lFLrKRNlf0KIYHqUJeWgmUfwcn9KtW5tPzdy68+9GC0w+vmeiBmnnVAKzikUOE
	 PLXtTjChM0BjbsNMBvk5Nd1gur3o2dm29Sx/CtcFwDeIrG84DuKxYNutecaZAHJX5
	 kZ3tEynFtzvEbLQwdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.144.196] ([217.61.144.196]) by
 trinity-msg-rest-gmx-gmx-live-67cd9ff8f8-fkcfn (via HTTP); Mon, 11 Nov 2024
 18:50:04 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-e3cbc89b-e051-436f-95d8-a912f2b880b3-1731351004644@trinity-msg-rest-gmx-gmx-live-67cd9ff8f8-fkcfn>
From: Frank Wunderlich <frank-w@public-files.de>
To: andrew@lunn.ch, robh@kernel.org
Cc: linux@fw-web.de, dlemoal@kernel.org, cassel@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk,
 hdegoede@redhat.com, axboe@kernel.dk, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Aw: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf conditional
 failed
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <e7a8e087-fb92-4911-b7fb-34521635e8da@lunn.ch>
Importance: normal
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-2-linux@fw-web.de>
 <e534c723-6d65-433f-8ab5-1c0d424d7367@lunn.ch>
 <9B1A5D20-3DE5-40C1-8B2D-B1C4F53FA5F4@public-files.de>
 <CAL_JsqJnOa_9Poz86vOWBCQigvv-Ab4Tt1hrwTxSa5zNraVxXQ@mail.gmail.com>
 <e7a8e087-fb92-4911-b7fb-34521635e8da@lunn.ch>
Date: Mon, 11 Nov 2024 18:50:04 +0000
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:QcPAxYStbZ35Ke0xAH5VF0tjiIpqa05M6016qw5Np2evzRUk8kv4okCbkw0Yd+7SOLhSu
 KexxLb4is4p5HYU/AdHrFAKaHrIr3fFEBzOYBA4rZuiLb+hfC3/mBuJvS3U1It6D40+fBvsx/Got
 bYkeIA/GisT4MYpiNRgj+IktwwHBD5uEf72CQTG8A68k4UFuA3qCKx5/MKPMIiJNDnTL28AHh9Nv
 qmnAaMZDdi0gcqYRGGTJDUBGklrghyvfd9JBbFG5oZt509TBf3al8F0kTUdMCx6iZBH8RiQq3CkG
 xZ6geXmHsD1qofX5o3ySoymHnnWBhg8Wo6ThdwmJ71fMIkNdC6PmHFIxORNB1TMy90=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:diK5IeRk6GA=;mGuyRpDPt3CMfRTiluWb5Fd35Dd
 K2HhjBpSHyemMJtMQCtJNRocDcjwgjjTP6pxwTl+dil4q5TmB5cxB2If5/MtNEVv9fZ99YekV
 2ZGCTYYjn4vexENc5lEk1SNIMtf7EdBBQi8mOgrlp0UhekAUJr5oXaPk4XkaqwKHVA6G9iAV1
 dv0ZaaSPwqOIwKMNFPrpCGLrVlbWxJNRto88lr7fDeNPjMxLhG9u6XG6YkSbX2rsI/o19QcBV
 TDVjnNdgWLc5phjwK8lfNScdW4RqcQ/0GGw1MucRPmjEl42U/Vsxs8qvkj2w3km74EP/y45nh
 u5fU7EAMkzSlN33WiWSyBScmt4B8jPtyrT7eVi7bPVJPfGbwYu8TEkjsdiOAcs72PTFyJ3WrI
 qupVmNt8G5L/y36RFWrFrSHTIPCkYp0uroC4wVv5SBkEW2XbC8W8rgmiCR1L+JCmbLSqImewO
 VlMzL03bqQbCiJSgUm5BPHMpOB2jVooy9r95GKVF42/NnHHcUBRLCnSOpGIu5x84WebDseCvf
 zXon+ErjJwR6YD+OKPOj5VVaaGQG2H8LByzIURaPmY+YwNNPvTNOYOI3/uDl36l4mUorS5VRC
 C3JAMXXfd7cK8r+DyI/TyTEJoWkRpII+Z8ZMWO7d6snmGoIW8A7mcbrUxZl+0a4WVp5c7Tg1M
 BdpnyLenm24ZUxIgei9ac3D/ocUQeOqaTyx6j9RcLw==

&gt; Gesendet: Montag, 11=2E November 2024 um 18:15
&gt; Von: "Andrew Lunn" <andrew@lunn=2Ech>
&gt; An: "Rob Herring" <robh@kernel=2Eorg>
&gt; CC: frank-w@public-files=2Ede, "Frank Wunderlich" <linux@fw-web=2Ede>=
, "Damien Le Moal" <dlemoal@kernel=2Eorg>, "Niklas Cassel" <cassel@kernel=
=2Eorg>, "Krzysztof Kozlowski" <krzk+dt@kernel=2Eorg>, "Conor Dooley" <cono=
r+dt@kernel=2Eorg>, "Gregory Clement" <gregory=2Eclement@bootlin=2Ecom>, "S=
ebastian Hesselbarth" <sebastian=2Ehesselbarth@gmail=2Ecom>, "Russell King"=
 <linux@armlinux=2Eorg=2Euk>, "Hans de Goede" <hdegoede@redhat=2Ecom>, "Jen=
s Axboe" <axboe@kernel=2Edk>, linux-ide@vger=2Ekernel=2Eorg, devicetree@vge=
r=2Ekernel=2Eorg, linux-kernel@vger=2Ekernel=2Eorg, linux-arm-kernel@lists=
=2Einfradead=2Eorg
&gt; Betreff: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf conditiona=
l failed
&gt;
&gt; On Mon, Nov 11, 2024 at 10:25:12AM -0600, Rob Herring wrote:
&gt; &gt; On Sun, Nov 10, 2024 at 3:25=E2=80=AFAM Frank Wunderlich
&gt; &gt; <frank-w@public-files=2Ede> wrote:
&gt; &gt; &gt;
&gt; &gt; &gt; Am 9=2E November 2024 18:29:44 MEZ schrieb Andrew Lunn <and=
rew@lunn=2Ech>:
&gt; &gt; &gt; &gt;On Sat, Nov 09, 2024 at 10:46:19AM +0100, Frank Wunderl=
ich wrote:
&gt; &gt; &gt; &gt;&gt; From: Frank Wunderlich <frank-w@public-files=2Ede>
&gt; &gt; &gt; &gt;&gt;
&gt; &gt; &gt; &gt;&gt; after converting the ahci-platform binding to yaml=
 the following files
&gt; &gt; &gt; &gt;&gt; reporting "'anyOf' conditional failed" on
&gt; &gt; &gt; &gt;&gt;
&gt; &gt; &gt; &gt;&gt; sata@540000: sata-port@0
&gt; &gt; &gt; &gt;&gt; diff --git a/arch/arm64/boot/dts/marvell/armada-70=
40-db=2Edts b/arch/arm64/boot/dts/marvell/armada-7040-db=2Edts
&gt; &gt; &gt; &gt;&gt; index 1e0ab35cc686=2E=2E2b5e45d2c5a6 100644
&gt; &gt; &gt; &gt;&gt; --- a/arch/arm64/boot/dts/marvell/armada-7040-db=
=2Edts
&gt; &gt; &gt; &gt;&gt; +++ b/arch/arm64/boot/dts/marvell/armada-7040-db=
=2Edts
&gt; &gt; &gt; &gt;&gt; @@ -214,6 +214,7 @@ &amp;cp0_sata0 {
&gt; &gt; &gt; &gt;&gt;
&gt; &gt; &gt; &gt;&gt;      sata-port@1 {
&gt; &gt; &gt; &gt;&gt;              phys =3D &lt;&amp;cp0_comphy3 1&gt;;
&gt; &gt; &gt; &gt;&gt; +            status =3D "okay";
&gt; &gt; &gt; &gt;&gt;      };
&gt; &gt; &gt; &gt;&gt;  };
&gt; &gt; &gt; &gt;
&gt; &gt; &gt; &gt;&gt;
&gt; &gt; &gt; &gt;&gt; diff --git a/arch/arm64/boot/dts/marvell/armada-70=
40-mochabin=2Edts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin=2Edts
&gt; &gt; &gt; &gt;&gt; index 7af949092b91=2E=2E6bdc4f1e6939 100644
&gt; &gt; &gt; &gt;&gt; --- a/arch/arm64/boot/dts/marvell/armada-7040-moch=
abin=2Edts
&gt; &gt; &gt; &gt;&gt; +++ b/arch/arm64/boot/dts/marvell/armada-7040-moch=
abin=2Edts
&gt; &gt; &gt; &gt;&gt; @@ -433,11 +433,13 @@ &amp;cp0_sata0 {
&gt; &gt; &gt; &gt;&gt;      /* 7 + 12 SATA connector (J24) */
&gt; &gt; &gt; &gt;&gt;      sata-port@0 {
&gt; &gt; &gt; &gt;&gt;              phys =3D &lt;&amp;cp0_comphy2 0&gt;;
&gt; &gt; &gt; &gt;&gt; +            status =3D "okay";
&gt; &gt; &gt; &gt;&gt;      };
&gt; &gt; &gt; &gt;&gt;
&gt; &gt; &gt; &gt;&gt;      /* M=2E2-2250 B-key (J39) */
&gt; &gt; &gt; &gt;&gt;      sata-port@1 {
&gt; &gt; &gt; &gt;&gt;              phys =3D &lt;&amp;cp0_comphy3 1&gt;;
&gt; &gt; &gt; &gt;&gt; +            status =3D "okay";
&gt; &gt; &gt; &gt;&gt;      };
&gt; &gt; &gt; &gt;&gt;  };
&gt; &gt; &gt; &gt;&gt; diff --git a/arch/arm64/boot/dts/marvell/armada-cp=
11x=2Edtsi b/arch/arm64/boot/dts/marvell/armada-cp11x=2Edtsi
&gt; &gt; &gt; &gt;&gt; index 7e595ac80043=2E=2E161beec0b6b0 100644
&gt; &gt; &gt; &gt;&gt; --- a/arch/arm64/boot/dts/marvell/armada-cp11x=2Ed=
tsi
&gt; &gt; &gt; &gt;&gt; +++ b/arch/arm64/boot/dts/marvell/armada-cp11x=2Ed=
tsi
&gt; &gt; &gt; &gt;&gt; @@ -347,10 +347,12 @@ CP11X_LABEL(sata0): sata@540=
000 {
&gt; &gt; &gt; &gt;&gt;
&gt; &gt; &gt; &gt;&gt;                      sata-port@0 {
&gt; &gt; &gt; &gt;&gt;                              reg =3D &lt;0&gt;;
&gt; &gt; &gt; &gt;&gt; +                            status =3D "disabled"=
;
&gt; &gt; &gt; &gt;&gt;                      };
&gt; &gt; &gt; &gt;
&gt; &gt; &gt; &gt;I don't know the yaml too well, but it is not obvious h=
ow adding a few
&gt; &gt; &gt; &gt;status =3D "disabled"; status =3D "okay"; fixes a "'any=
Of' conditional failed"=2E
&gt; &gt; &gt; &gt;
&gt; &gt; &gt; &gt;Maybe you can expand the explanation a bit?
&gt; &gt; &gt; &gt;
&gt; &gt; &gt; &gt;       Andrew
&gt; &gt; &gt;
&gt; &gt; &gt; Hi angelo,
&gt; &gt; &gt;
&gt; &gt; &gt; I guess the dtbs_check only checks required properties from=
 yaml if the node is enabled=2E
&gt; &gt;=20
&gt; &gt; Yes, that is exactly how it works=2E
&gt;=20
&gt; So from this, can i imply that phys is a required property?
&gt;=20
&gt; Looking at the above patch, it appears that for armada-*=2Edts,
&gt; sata-port@0 always uses phys =3D &lt;&amp;cp0_comphy2 0&gt; and sata-=
port@1 uses
&gt; phys =3D &lt;&amp;cp0_comphy3 1&gt;=2E Is this an actual SoC property=
? Could it be
&gt; moved up into the =2Edtsi file? Or is it really a board property?

as i said the phy may operate in different modes (not know marvell here, b=
ut on other vendors phys are defined at board level), maybe the boards wher=
e the phy is missing the phy is used in another mode=2E Without knowing the=
 SoC and boards disable it at SoC-level and enable only the nodes containin=
g a phys property is all i can do here to fix the issue=2E Imho it is alway=
s a good idea to enable only the conrollers a board will use=2E

&gt; 	Andrew
&gt; </frank-w@public-files=2Ede></andrew@lunn=2Ech></frank-w@public-files=
=2Ede></axboe@kernel=2Edk></hdegoede@redhat=2Ecom></linux@armlinux=2Eorg=2E=
uk></sebastian=2Ehesselbarth@gmail=2Ecom></gregory=2Eclement@bootlin=2Ecom>=
</conor+dt@kernel=2Eorg></krzk+dt@kernel=2Eorg></cassel@kernel=2Eorg></dlem=
oal@kernel=2Eorg></linux@fw-web=2Ede></robh@kernel=2Eorg></andrew@lunn=2Ech=
>
