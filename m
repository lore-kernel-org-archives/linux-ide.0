Received: from devnull.tasossah.com (devnull.tasossah.com [91.121.165.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F437E554
	for <linux-ide@vger.kernel.org>; Sun, 19 May 2024 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.165.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716118952; cv=none; b=GAeNc2f7yJY4GOjPCNA3KpmTcqL/aYJCu+pvqzcAgMRQLsG/rRYbydVkPuP+mPRk159icPelMbHHPoSTDF4Hxd2yriIEzSbghM3m+84dblh19q/LAYut1WEktc7LgKGPzbgbkHuixzzWUY46m0mmtB3NecV6Pd5YdCzz3GMwDP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716118952; c=relaxed/simple;
	bh=fqpPoXkKXNzY728Z49D9FLk3aTr7RKXhqMzf/nhlIbU=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=dYXQsaiKpIR6q+q4om5fP80HwRXyr9RzykGFy75DHRi3KHtVEw4iBazCvq+QfDexZlG7FbeB5JoUWXnEsWqVvbzkQ5l+qR8dAE1OsYt73wG5DyZ4RXvGuZNn9IMKIZ6pOGSSHF7ibXwZwK5HBRDbs3CWwGeBYJ//eOlzKFLx3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com; spf=pass smtp.mailfrom=tasossah.com; dkim=pass (1024-bit key) header.d=devnull.tasossah.com header.i=@devnull.tasossah.com header.b=a46F+7mi; arc=none smtp.client-ip=91.121.165.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tasossah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=devnull.tasossah.com header.i=@devnull.tasossah.com header.b="a46F+7mi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=devnull.tasossah.com; s=vps; h=Content-Type:Subject:Cc:To:From:MIME-Version
	:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fqpPoXkKXNzY728Z49D9FLk3aTr7RKXhqMzf/nhlIbU=; b=a46F+7miGiL+vqz9c6ixdbNFEI
	e/y8x4tuWcXYXVKfJWfzL0K/tmcijwCMi2RIzSJVKK6FO7XYFNHtnytM0flmjiVK56Ae09rgzYwhf
	lipEci9ZX/V6foqmOlsFLve3t9mxN/h4eKGfkAEMU1HwDaOzDLG4OSzJILMndO7QKdTE=;
Received: from [2a02:587:6a04:fe00::298]
	by devnull.tasossah.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <tasos@tasossah.com>)
	id 1s8etj-001EKX-40; Sun, 19 May 2024 14:40:15 +0300
Message-ID: <c41c5bf8-9ed8-49c8-a9f4-431d523fffbf@tasossah.com>
Date: Sun, 19 May 2024 14:40:12 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tasos Sahanidis <tasos@tasossah.com>
Content-Language: el-GR, en-GB
To: cassel@kernel.org
Cc: dlemoal@kernel.org, jhp@endlessos.org, hch@lst.de,
 mario.limonciello@amd.com, mika.westerberg@linux.intel.com,
 linux-ide@vger.kernel.org
Autocrypt: addr=tasos@tasossah.com; keydata=
 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
Subject: AHCI hotplug no longer functions on ICH7
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LS5RMwVR3KuRgfgTzWLPtuFr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------LS5RMwVR3KuRgfgTzWLPtuFr
Content-Type: multipart/mixed; boundary="------------OFqygY8iiDL2KWuzljrtO6lK";
 protected-headers="v1"
From: Tasos Sahanidis <tasos@tasossah.com>
To: cassel@kernel.org
Cc: dlemoal@kernel.org, jhp@endlessos.org, hch@lst.de,
 mario.limonciello@amd.com, mika.westerberg@linux.intel.com,
 linux-ide@vger.kernel.org
Message-ID: <c41c5bf8-9ed8-49c8-a9f4-431d523fffbf@tasossah.com>
Subject: AHCI hotplug no longer functions on ICH7

--------------OFqygY8iiDL2KWuzljrtO6lK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I have a hot swap bay connected to an Intel Corporation NM10/ICH7 Family
SATA Controller [AHCI mode] [8086:27c1] (rev 01) (prog-if 01 [AHCI 1.0])
and since commit 7627a0edef54 ("ata: ahci: Drop low power policy board
type") SATA AHCI hotplug no longer functions. Plugging a device in after
the system has booted results in it not being detected.

Looking at ahci_update_initial_lpm_policy(), it is evident that
ATA_PFLAG_EXTERNAL is not set (ad->pflags =3D=3D 0x84 when the function i=
s
called) and there is no option in firmware to mark these ports as externa=
l.

My kernel was always built with CONFIG_SATA_MOBILE_LPM_POLICY=3D3. Bootin=
g
with ahci.mobile_lpm_policy=3D2 or ahci.mobile_lpm_policy=3D1 results in =
the
device being detected on hotplug, but the unplug event is never detected
and the system thinks the device remains connected, resulting in hangs.

The only way to restore functionality is with ahci.mobile_lpm_policy=3D0,=

which if I am not mistaken has the same effect as an early return. Is
this the intended way of getting hotplug to work again from now on, on
systems that don't mark ports as external, or is this a regression?

Thank you for your time.

--
Tasos

--------------OFqygY8iiDL2KWuzljrtO6lK--

--------------LS5RMwVR3KuRgfgTzWLPtuFr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEsXLJ1Ds+HVUj+TWiAaHcuiLgBcQFAmZJ5R0FAwAAAAAACgkQAaHcuiLgBcR8
gA/+JXgwGp5U4ViEO8I0ffvEQPFjx7ijeNjeoxd/+RZm7UTRGDp/91Cy8EEfXLfoIVlWfd3jfJds
8gyyT6FiynCcdj5wfWR8zf38Lct0hemUxPNE//bGpCF8uC+ezVAXgSPok3j8QOER4Nuq94QSu7Im
95L1CfCCKGrhm88F2QE/BvDujG/ZsA+YqR1O5kNEBXA0OT9GNM8UGgawWX9JYOQGFNVFrUQksm6g
9jbJoRuJ8PYFMzx8Gw2UtLRiJlMyO/7okLlx7mXmeDESu5kedSwQRiXbEnJas+btvXy2J+mhhPCi
vuPxYdfJjPsfJN1KHSE9AYdLpNyE4or2h1udop4Ja2+tnpEA8gOf9+PFMFmc/XPwgC0+2x6+IbPd
8pyUK+MKmbMSuNgxmlbPERhslTC+YAbv2dpuPxRD7vITC3CPhD24VWvpTEASckM1Otb2R4UBoxXY
OZgyG/DBBD0ccmO79V0FIWBxjRql3DsN7ZAc+HHx7wI3+8Mgr7ru7391X4FzoVjRECPg8rosJ0l+
OqN1sjUaKaRhwVl01znfY069IjQuP340t8epDbz70Nwc2XSB6Jnh12xUXfcnykMWMt7mqnkxg0kA
HRplFdA22ngFBZqw7NlbpLpYgvgG05uHVF6afMQ7OAyhmC4CjjoBc2/IP8b3ZBz7VfJWNETaJ7hR
Zcc=
=VQBX
-----END PGP SIGNATURE-----

--------------LS5RMwVR3KuRgfgTzWLPtuFr--
