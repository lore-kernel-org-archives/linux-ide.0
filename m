Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA813A890
	for <linux-ide@vger.kernel.org>; Tue, 16 Apr 2024 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713310204; cv=none; b=V8JWv5Xxg5d+TYaCU2CE9/+lD/JavQHGcLSA6oV+nbALpxVB+kmN/bIvddu5CvL5A4xZT+R1F6Y625x+R4I7KHiZXKbEGj92SciRaSdB8mSwOakFg8zj70/aZ1Lb4c/JHtqsgsX+7xvpYbJYoXoMiSA1HBD2BkPwVJdpS2w0LwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713310204; c=relaxed/simple;
	bh=PNzaUN9pEVAwdSSn5KcF1o5DaVasySc+PXZWWjvk9uA=;
	h=From:To:Subject:Cc:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMWHekNipqRp+6IsLsM1ax1gpnuKwcc6fgN5wPVbwRZrq2ZdE9bMHzDvBGnniZBfrSxYy/pEBbg6M1USmLA41wgBDmtDb1l9IKDKNn2YTrsGto7+cq6koTrE4c5drAp8ZdGt3s2bksIRlCmmw64YweQdirI3FD6aIda2G5HKku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: "Conrad Kostecki" <conikost@gentoo.org>
To: "Damien Le Moal" <dlemoal@kernel.org>, linux-ide@vger.kernel.org, "Niklas
 Cassel" <cassel@kernel.org>
Subject: Re[2]: [PATCH v2] ata: ahci: Add mask_port_map module parameter
Cc: "Szuying Chen" <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
 Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Date: Tue, 16 Apr 2024 23:29:56 +0000
Message-Id: <em8c57d6d1-0213-4adc-be97-e0d601675951@ed1b2594.com>
In-Reply-To: <5fdd9099-61e4-44c0-acb2-72f766f0e87f@kernel.org>
References: <20240405125143.1134539-1-dlemoal@kernel.org>
 <em6045942b-7739-40b7-8c9d-ad047918cdb8@a351f4b0.com>
 <33e81fd6-2d0d-4d23-9cab-fed775917bc0@kernel.org>
 <em46c5a70c-ff8b-415d-918e-fb53baf8fd68@5422b68e.com>
 <5fdd9099-61e4-44c0-acb2-72f766f0e87f@kernel.org>
Reply-To: "Conrad Kostecki" <conikost@gentoo.org>
User-Agent: eM_Client/9.2.2230.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello Damien,

Am 17.04.2024 01:13:08, "Damien Le Moal" <dlemoal@kernel.org> schrieb:

>OK. So despite what I thought, it seems that the mask should be applied to
>saved_port_map to modified that value permanently instead of using the mas=
k to
>set ->port_map. I do not really understand why that would be needed. It se=
ems
>that saved_port_map is being reused without the mask applied somewhere, wh=
ich
>should not happen. I need to dig further into this.
>
>In the meantime, can you try to add this patch:
>
>diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>index 83431aae74d8..830a59f68620 100644
>--- a/drivers/ata/libahci.c
>+++ b/drivers/ata/libahci.c
>@@ -546,6 +546,7 @@ void ahci_save_initial_config(struct device *dev, stru=
ct
>ahci_host_priv *hpriv)
>                         port_map,
>                         port_map & hpriv->mask_port_map);
>                 port_map &=3D hpriv->mask_port_map;
>+               hpriv->saved_port_map =3D port_map;
>         }
>
>         /* cross check port_map and cap.n_ports */
>
>And test again ?

I can confirm, this works for me. The non physical ports are now marked=20
again as DUMMY and booting is fast.

Cheers
Conrad
