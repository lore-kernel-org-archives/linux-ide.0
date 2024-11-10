Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ECA2563;
	Sun, 10 Nov 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731234067; cv=none; b=heHWLMItXPFvjybcaJ+/WId/Rfooy7j4IxL9bs/J3vi1a/UkbEDNNKH2JIn+yanfp/ASt5MS794xuLGTjFCPsclkwVUqEcwi5BTVZim0uMW5yBEv1vPvvQWEQJ3sQK2uMaiUvLXE9Ml30CbkdXF/+34zF1gZBlC5DjGcUsyjW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731234067; c=relaxed/simple;
	bh=b0orM1whYBf/oNXTiwqSx6Kvzd/1fyGJiGI31iywyCo=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=jjub76i9VA3BWEnuehOD2/Tl1VE/S+5zBRAE/f5MOVIVMjmgwiV1NoOB/DcEvpYeae+8q8y6Fq2EfY1Hbel2BtPwNPTf99WERWMSbFihxwZMdErHpQlOMJk0EvBSEzq1nOSB4thK/8JhKJJCqHgD4DZ73mWqGgOJxmgScUSzVZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=o07JoO8R; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="o07JoO8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1731234046; x=1731838846; i=frank-w@public-files.de;
	bh=seuUOA8EujvZMml8ixlG9ZE12iNZkVTraJ0yEC7Fi9s=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Reply-To:
	 Subject:Content-Type:In-Reply-To:References:Date:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=o07JoO8R5tmZsHEKrzbrtKciCUIbKdWYyerlGFRofRIYF4gDNZYKgqpK2h36SAi1
	 uWaDhWMZlA6X4JALFt7E45zZvDHt2S+Ps1B0bGJMK5umQLJC6D7/mp8HBnLokQ3Fb
	 28BSvlESLym7FVYx2HG9kGSdqOkUn/GR3C0lRx+mENVRtRtCZ6IDSpFn1B46+mnAp
	 h+jXVevoMXkP51cjZ3XzUI5RzSwhCeh2on3/lsnq15xiVBVSmLQ7fnZcvWUzSjIi7
	 i76TeR9gHjqSroKKaC9yWEd2CRYBHe3DUecHu0KIEYjxUbolZ4EIFcgEfPivHQpH7
	 qXK8sEE1xBrmUnKb5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.152.71] ([217.61.152.71]) by
 trinity-msg-rest-gmx-gmx-live-c75c5fb4b-6zcvs (via HTTP); Sun, 10 Nov 2024
 10:20:46 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-d08557e5-9d2e-45e0-b9e2-45864ef192ff-1731234046657@trinity-msg-rest-gmx-gmx-live-c75c5fb4b-6zcvs>
From: Frank Wunderlich <frank-w@public-files.de>
To: frank-w@public-files.de, andrew@lunn.ch, linux@fw-web.de
Cc: dlemoal@kernel.org, cassel@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk,
 hdegoede@redhat.com, axboe@kernel.dk, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Reply-To: frank-w@public-files.de
Subject: Aw: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf conditional
 failed
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <9B1A5D20-3DE5-40C1-8B2D-B1C4F53FA5F4@public-files.de>
Importance: normal
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-2-linux@fw-web.de>
 <e534c723-6d65-433f-8ab5-1c0d424d7367@lunn.ch>
 <9B1A5D20-3DE5-40C1-8B2D-B1C4F53FA5F4@public-files.de>
Date: Sun, 10 Nov 2024 10:20:46 +0000
Sensitivity: Normal
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:ofniCum0AvYQ8ubV9b8nMhto0JeMMH1eGUsoVeFPoZXM7JMo/IMCVLU/0UtOCudn0Sl6T
 lsA6vSDdnRuB8tHW5xXutUEojj2mEKzSGe1oOBsfEGcX35ZC4B1qzSwWj77o0XThBHPb/i5KaaAz
 8KaLWtDlnWADBL4QhMTpErH8Y03Sy3lhFVW6+vpiF8GlFcR3LUoeqLbmGZiJEDdce5VXNLhHC2n6
 nLaDm8p9vslys/BZSR5h69U+/T7HNd06NutJSf6VjekHYeCspYrbRST/I2qqg4isQvP45jehgWZe
 xFr/7y1ebsDTX3Q/IFkBFBnzs6AHSpmNmZuNU0FB1GIxdk3FzDpKmzRxJgxfFKkHYE=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NFFR1Mehv0c=;qGX+JdGSm20nkSCpeFlKUqK3WB3
 6e2t7vSlIIRWpRZaRCnKVC//DFOhao2S8W9dKr9nNaZOVq6bhXQ48iqIQwC+KZYOYqhqIX9hg
 8bAkN4QjTvS+5glJ9gSNnXfKu9l0IWz743a+ipNvOtegdPPzh7LZoDDNoC2H/hOb64uQ/5XuU
 OnmSBuZLBc/a3PWVUILfZoX/4nStjNU4gdACkJURSv7c05rANOAgM2ZKqLt/BD8Y/vYxDKIvR
 HKQ2/ZYnClafyyzsJ0bovfb6V+t5nutv72XzETpBk9xqcThi2GV6R2Dbv179DygoVnYLxneZr
 gDEkVQHRYskzv5mi50MzRjZhlZuSIEv3w9e3UdzvyCJ8Qy4W+FMF1XzPZS6w6yKS+MEuDGx0z
 tD9yc3y//u3JDspDgZ4yo7jDvHcg8qjkDiYMJIiDg0cQRTF0U83cceduKHVQeDlQ47hkWTmfc
 wnXlCktacIZZQbWs7ypAdUXLTHFokpGEmF1LTKX7Y/TF/WRuZch2wvVtstPO6pAs4oTIoFh6A
 ZiVv6qUsZs9OnWH4Pbam04mnU+Om9F+t5vLIRs6AdsZABE872TLP24xJP9r7i9qF1BnzG8ZE4
 /encu4l5vk48kl3rILuDcyu0iwRu6mSL+2HnAc25QMeNx0ULUawJYV2sS7OMeEpamanwefR0/
 2QNZiyYyb4YfGCB9+c99C8WNnm9vHW71rBRxKY1slQ==
Content-Transfer-Encoding: quoted-printable

&gt; Gesendet: Sonntag, 10. November 2024 um 10:25
&gt; Von: "Frank Wunderlich" <frank-w@public-files.de>
&gt; Am 9. November 2024 18:29:44 MEZ schrieb Andrew Lunn <andrew@lunn.ch>=
:
&gt; &gt;On Sat, Nov 09, 2024 at 10:46:19AM +0100, Frank Wunderlich wrote:
&gt; &gt;&gt; From: Frank Wunderlich <frank-w@public-files.de>
&gt; &gt;&gt;
&gt; &gt;&gt; after converting the ahci-platform binding to yaml the follo=
wing files
&gt; &gt;&gt; reporting "'anyOf' conditional failed" on
&gt; &gt;&gt;
&gt; &gt;&gt; sata@540000: sata-port@0
...
&gt; &gt;
&gt; &gt;I don't know the yaml too well, but it is not obvious how adding =
a few
&gt; &gt;status =3D "disabled"; status =3D "okay"; fixes a "'anyOf' condit=
ional failed".
&gt; &gt;
&gt; &gt;Maybe you can expand the explanation a bit?
&gt; &gt;
&gt; &gt;	Andrew
&gt;
&gt; Hi angelo,
&gt;
&gt; I guess the dtbs_check only checks required properties from yaml if t=
he node is enabled.
&gt;
&gt; As you know, phys that can supply different types (sata,usb,pcie,*gmi=
i,...),but only one mode can be used per phy. So only one controller can b=
e used with it,the other(s) can not. I do not know marvell,but there are s=
imilar in mediatek (xsphy) and rockchip (combphy).
&gt;
&gt; From my PoV it makes sense to check only enabled nodes for required p=
roperties,but i do not know internals of dtbs_check. This patch is 2 years=
 old and i only rebased it and run dtbs check with the others to have a cl=
ean result...i can test again without this one to check if anyOf is shown =
again.
&gt;
&gt; regards Frank

Hi

issue is still there and patch is still needed...without it i get these me=
ssages:

$ ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make dtbs_check DT_SCHEM=
A_FILES=3DDocumentation/devicetree/bindings/ata/ahci-platform.yaml
  UPD     include/config/kernel.release
  DTC [C] arch/arm64/boot/dts/marvell/armada-7040-db.dtb
arch/arm64/boot/dts/marvell/armada-7040-db.dtb: sata@540000: sata-port@0: =
'anyOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/armada-7040-mochabin.dtb
  DTC [C] arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dtb
arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dtb: sata@540000: s=
ata-port@0: 'anyOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/armada-8040-db.dtb
  DTC [C] arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb
arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb: sata@540000: sata-port@=
0: 'anyOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dtb
arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dtb: sata@540000:=
 sata-port@0: 'anyOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dtb
  DTC [C] arch/arm64/boot/dts/marvell/cn9130-db.dtb
arch/arm64/boot/dts/marvell/cn9130-db.dtb: sata@540000: sata-port@0: 'anyO=
f' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/cn9130-db-B.dtb
arch/arm64/boot/dts/marvell/cn9130-db-B.dtb: sata@540000: sata-port@0: 'an=
yOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/cn9131-db.dtb
arch/arm64/boot/dts/marvell/cn9131-db.dtb: sata@540000: sata-port@0: 'anyO=
f' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
/media/data_ext/git/kernel/BPI-R2-4.14/arch/arm64/boot/dts/marvell/cn9131-=
db.dtb: sata@540000: sata-port@0: 'anyOf' conditional failed, one must be =
fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/cn9131-db-B.dtb
arch/arm64/boot/dts/marvell/cn9131-db-B.dtb: sata@540000: sata-port@0: 'an=
yOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
arch/arm64/boot/dts/marvell/cn9131-db-B.dtb: sata@540000: sata-port@0: 'an=
yOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/cn9132-db.dtb
arch/arm64/boot/dts/marvell/cn9132-db.dtb: sata@540000: sata-port@0: 'anyO=
f' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
arch/arm64/boot/dts/marvell/cn9132-db.dtb: sata@540000: sata-port@0: 'anyO=
f' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
arch/arm64/boot/dts/marvell/cn9132-db.dtb: sata@540000: sata-port@1: 'anyO=
f' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/cn9132-db-B.dtb
arch/arm64/boot/dts/marvell/cn9132-db-B.dtb: sata@540000: sata-port@0: 'an=
yOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
arch/arm64/boot/dts/marvell/cn9132-db-B.dtb: sata@540000: sata-port@0: 'an=
yOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
arch/arm64/boot/dts/marvell/cn9132-db-B.dtb: sata@540000: sata-port@1: 'an=
yOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/cn9130-crb-A.dtb
  DTC [C] arch/arm64/boot/dts/marvell/cn9130-crb-B.dtb
arch/arm64/boot/dts/marvell/cn9130-crb-B.dtb: sata@540000: sata-port@1: 'a=
nyOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb
arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: sata@540000: sata-=
port@0: 'anyOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: sata@540000: sata-=
port@0: 'anyOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: sata@540000: sata-port@1: =
'anyOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: sata@540000: sata-port@1: '=
anyOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: sata@540000: sata-port=
@0: 'anyOf' conditional failed, one must be fixed:
	'phys' is a required property
	'target-supply' is a required property
	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
  DTC [C] arch/arm64/boot/dts/marvell/cn9132-clearfog.dtb

that imho confirms my guess that only enabled nodes are checked and withou=
t the disabled this node is always enabled and
by disabling the SoC-node and enabling at board-level let the others (here=
 printed) disabled and so not need the required
properties.

i can try to add short description about it, something like this:

The dtbs-check only checks enabled nodes and there required nodes must be =
present. Nodes are enabled by default (current state for sata@540000 node)=
, but some boards seem to use the phy somewhere else or just not want to u=
se the sata contoller and so miss the required properties 'phys' and 'targ=
et-supply'. So disable the sata@540000 node at SoC level and enable it whe=
re it is filled with required properties.

maybe adding this phrase to commit is enough?

regards Frank</frank-w@public-files.de></andrew@lunn.ch></frank-w@public-f=
iles.de>
