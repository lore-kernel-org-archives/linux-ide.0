Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F9158DAC
	for <linux-ide@vger.kernel.org>; Sun, 11 May 2025 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746991097; cv=none; b=dnWHhRl5fjs1nHLoPtI87uhzoYhiu1Ixpn3svr2GKhN3r0QrFxyI3YbiAf3xZgK9b/EYW5ElALmnM4Oyw+sXpsTP6ENlJJ9p/5sC+QNwTVopo5V6HvrkOF2aCQdqjKx4rvYgP1EncMcl1/DJVM7Iq/OksbZSwZGosH8D6CKT5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746991097; c=relaxed/simple;
	bh=UcnxY6ZqVqD7l5fRnmYk8gRQ2o/UQFtJxHnMmKcEnjc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XxV6e/OU6QSnL/wbPH5Vkd3q3HPLDp3qJVvPMoQd829aa0rouwp/z5VgJWIK4z5jQ6HM9Mgi1Aq59hBg/KuPa24mUPKYVMqES0r6KFfCWN/cQle4uyMOO0pVFzQd70fUhM/QQMgho62YF/chfCx+WXdMVV8EddF6bKQqvOBJYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rldz1a0M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rldz1a0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61656C4CEE4;
	Sun, 11 May 2025 19:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746991097;
	bh=UcnxY6ZqVqD7l5fRnmYk8gRQ2o/UQFtJxHnMmKcEnjc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=rldz1a0MAUOYFD6XaFqGouvh4scUCBIWP6shO92UEhsFgzKnFw+3fS2QFe+sL0VOh
	 DH1tdn0vS82OpUMxuQJfqK5uRF22zXHcssWXI302V2NqsaFeYVFdwNYtULmnuaBq6S
	 MSU/WgYfz72Jdc8EbKkIsBNf4KAixZxVcoIjPf2Ap8ctXpdbIHfg91K8K3eyvWb0yQ
	 5xeD2Kz3IHcM2fsfD8DUK7GdM3dv005/g8d+GKvfgsR+PC+dAsHFKxz9z22g9xjOyB
	 xH9O6XthlbXYkn41Z6XzRqL3N7yFTNodIM9MMH4jRbK1tOLCUPssszhSFKkkfIVNpM
	 lHU8iqToK8Glg==
Date: Sun, 11 May 2025 21:18:16 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
CC: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>,
 linux-ide@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4=5D_ata=3A_libata=3A_disable_LP?=
 =?US-ASCII?Q?M_for_WDC_WD20EFAX-68FB5N0_hard_drives?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAAZ0mTdcAazi=133Dz0+OgSGOERe7WmCTr27ePudEVhkJj6VbA@mail.gmail.com>
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com> <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org> <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org> <CAAZ0mTeepp7G9CtLFq+U_n0h2+SF8V8j2K=0hkNAp0Fzdc7TAQ@mail.gmail.com> <aBjbSt5hTaUP_JhG@ryzen> <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com> <f572f7d2-7b14-476e-aab2-bf674811dee5@kernel.org> <CAAZ0mTf3T5RTDKtd148GyGOiVz98isFFbMDXfku8yAk9FfLVeQ@mail.gmail.com> <aB8_rITWsMzkTiyE@ryzen> <CAAZ0mTe7Tpf2F1cKbmr==43pXDUxcPP4Q2AydpyDFJUrFHzNHQ@mail.gmail.com> <98E34F63-CCAE-48C4-9584-9053C3D1A7FD@kernel.org> <CAAZ0mTdcAazi=133Dz0+OgSGOERe7WmCTr27ePudEVhkJj6VbA@mail.gmail.com>
Message-ID: <48F49924-F5FE-4A91-8323-E2C789D1BEFB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 11 May 2025 20:59:12 CEST, Mikko Juhani Korhonen <mjkorhon@gmail=2Ecom>=
 wrote:
>su 11=2E5=2E2025 klo 21=2E53 Niklas Cassel (cassel@kernel=2Eorg) kirjoitt=
i:
>> >linux-6=2E14=2E5/=2Econfig:CONFIG_SATA_MOBILE_LPM_POLICY=3D3 (good)
>> >linux-6=2E8=2E12/=2Econfig:CONFIG_SATA_MOBILE_LPM_POLICY=3D3 (bad)
>
>Oops got this mixed up, my bad! I meant:
>linux-6=2E8=2E12/=2Econfig:CONFIG_SATA_MOBILE_LPM_POLICY=3D3 (god)
>linux-6=2E14=2E5/=2Econfig:CONFIG_SATA_MOBILE_LPM_POLICY=3D3 (bad)


Ok, I see were things went wrong now=2E

Damien asked for the good output for 6=2E8,
rather than the good output for 6=2E14=2E5, when you plugged the drive in =
to a port that was working=2E

Basically, we wanted to compare the good 6=2E14=2E5 output with the bad 6=
=2E14=2E5 output, especially the lpm-pol output=2E

The 6=2E8 output is not interesting at all IMO, because that is before we =
enabled LPM for all controllers that claim to support it=2E

Sorry for the confusion=2E

If you get a different lpm-pol print, when booting the exact same 6=2E14=
=2E5 kernel binary,
but just having the SATA drive plugged in to different ports, and you have=
 hotplug disabled for all ports in BIOS, suggests a BIOS bug to me=2E

Tomorrow, I will send a patch that will print, per port, if BIOS has marke=
d the port as external/ hotplug capable or not=2E (Because right now, when =
we see lpm-pol 0, we don't know if it is because of BIOS settings or Kconfi=
gs)=2E


Kind regards,
Niklas



