Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD432E65B
	for <linux-ide@vger.kernel.org>; Fri,  5 Apr 2024 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712357643; cv=none; b=gxKiqn3EK0eCQylS2J3o/qLzXco9qEpg4HQICd767w+3VrYxjJxDKHf9qePHZwbdBH95MRca5u7NW4NP3iKYsZ1G242OszlYlzRP5b2hfJvDYIRZpvkWtKL1+HCyhbGxz0dgi7ldgMfpxNrHfyoK0nH/qiwX9hULYSPuq0GIUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712357643; c=relaxed/simple;
	bh=pTMroX4s13hfUkh/tIyws5Zail8xxrKa/qfvKX3LKqs=;
	h=From:To:Subject:Cc:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6eN77OidPbXBT5/Ur83ELH5mzXUY0EZvn791MV+95ZdFikd81YKrVDRbKcmTYrdWHDLrtYEqSg+MQimktBRYxsLCEwhhAygwcANClrt3j5G0aD64wZ7aOno3BAKMBZwU0pI+LcLQRRLSOigUYI5GazaJ4IrAxN8u0ysK7hcZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: "Conrad Kostecki" <conikost@gentoo.org>
To: "Damien Le Moal" <dlemoal@kernel.org>, linux-ide@vger.kernel.org, "Niklas
 Cassel" <cassel@kernel.org>
Subject: Re: [PATCH v2] ata: ahci: Add mask_port_map module parameter
Cc: "Szuying Chen" <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
 Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Date: Fri, 05 Apr 2024 22:53:55 +0000
Message-Id: <em6045942b-7739-40b7-8c9d-ad047918cdb8@a351f4b0.com>
In-Reply-To: <20240405125143.1134539-1-dlemoal@kernel.org>
References: <20240405125143.1134539-1-dlemoal@kernel.org>
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

Hi Damien,

Am 05.04.2024 14:51:43, "Damien Le Moal" <dlemoal@kernel.org> schrieb:

><PATCH v2>
i did run a test on my hardware.
It seems to work and adjusting the port_map. But I noticed a difference,=20
that those virtual hostXY ports are not marked as DUMMY.
With the previous patch, only six ports reported "ahci" and rest=20
"DUMMY".
I am not sure, if that should also not happen with your patch?
Conrad
[   13.365573] ahci 0000:09:00.0: masking port_map 0xffffff3f -> 0x3f
[   13.376511] ahci 0000:09:00.0: SSS flag set, parallel bus scan=20
disabled
[   13.395670] ahci 0000:09:00.0: AHCI 0001.0301 32 slots 32 ports 6=20
Gbps 0x3f impl SATA mode
[   13.397111] ahci 0000:09:00.0: flags: 64bit ncq sntf stag pm led only=20
pio sxs deso sadm sds apst
[   13.593757] scsi host9: ahci
[   13.597362] scsi host10: ahci
[   13.600949] scsi host11: ahci
[   13.604548] scsi host12: ahci
[   13.612459] scsi host13: ahci
[   13.616027] scsi host14: ahci
[   13.616437] scsi host15: ahci
[   13.616745] scsi host16: ahci
[   13.617039] scsi host17: ahci
[   13.617415] scsi host18: ahci
[   13.617723] scsi host19: ahci
[   13.637158] scsi host20: ahci
[   13.640666] scsi host21: ahci
[   13.651760] scsi host22: ahci
[   13.652311] scsi host23: ahci
[   13.652850] scsi host24: ahci
[   13.656374] scsi host25: ahci
[   13.664120] scsi host26: ahci
[   13.664570] scsi host27: ahci
[   13.686567] scsi host28: ahci
[   13.690179] scsi host29: ahci
[   13.697603] scsi host30: ahci
[   13.698083] scsi host31: ahci
[   13.698518] scsi host32: ahci
[   13.701855] scsi host33: ahci
[   13.702323] scsi host34: ahci
[   13.702745] scsi host35: ahci
[   13.721520] scsi host36: ahci
[   13.725157] scsi host37: ahci
[   13.736948] scsi host38: ahci
[   13.737383] scsi host39: ahci
[   13.748518] scsi host40: ahci
