Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7313A265;
	Sat, 24 May 2025 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748124608; cv=none; b=CsHUq1l/qlT8NX176PdwrFVBezkrCKPpQ2MPRMBC6S5C+SYRXTwCQmU5x8ohGIGs/4lQD2RiIF4TiZPoE5sMtdieUNLrLaxXD0GA2Kc8zviaKa2nsydvUBW6zAuhDTwqQIqQ9txL5c6Y/raxXyszTiu5STtNGVZKz++vKhnm1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748124608; c=relaxed/simple;
	bh=FDOS0BPEeDg9pJVv6rPfpxvctSUkp6RvqNXGS6GpvAY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tA1MOeb05W05Uy8DVOqMeFxlK3pE6GvKHRXBFVks6zdMZ5cUEJ1qQyrPVNfeOh58p1B8XF92fMhEx0Du4j87mpsZ/oxZ9H0YJ2CkFrQoi02e7Ve/vHagTXZv459hYjo9kz0DYvwvNeJUqciSrdogmU3wxx/+INtsTbQHxgi6UjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2Ytpppo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2Ytpppo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF00C4CEE4;
	Sat, 24 May 2025 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748124608;
	bh=FDOS0BPEeDg9pJVv6rPfpxvctSUkp6RvqNXGS6GpvAY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=b2YtpppoZ0zD/ZoWWb3Hw/S3/ATZTIdbjZvcPeuqps8ZW2iHfpcMdNkoSZFh1Hct7
	 O5yGigKWaaceo/1apHJFNB5sGI7aswFnDpnXawY6mmThuXLyMsZYApbTGrNi3McYGl
	 0uR/nfY4FGhB0Zvk+6WdL8u2MqKK/G+hXwiV5lWMmtkd+o/q/N1gso6BsqnDAU2vlx
	 HuOIae7ssHKMLkZ3oxtCiGhVaf+gNRIn8I/HHFq/HEQ2IDk/f7fd9dX53jl8W5v6E0
	 CplVph6zYCuN5Wrt0Yvl3AO02VCetbj1SO6dA206Ogth0iwGZAgyOLdQwvj1C6UFUL
	 UgocZ/ZNZZGew==
Date: Sun, 25 May 2025 00:10:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Alexander Roman <monderasdor@gmail.com>,
 linux-ide@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] ahci: enhance error handling in ahci_init_one
User-Agent: Thunderbird for Android
In-Reply-To: <7533f274-dcc9-42a5-9e5a-74019255fd3c@kernel.org>
References: <f2db43ab-97d0-4731-9b51-18876f342b42@kernel.org> <20250522102653.1169-1-monderasdor@gmail.com> <7533f274-dcc9-42a5-9e5a-74019255fd3c@kernel.org>
Message-ID: <C819CAA3-3F8B-44A3-BD65-82B06378839E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24 May 2025 14:36:24 CEST, Damien Le Moal <dlemoal@kernel=2Eorg> wrote:
>On 5/22/25 12:26, Alexander Roman wrote:
>> Add comprehensive error handling to ahci_init_one() to:
>> 1=2E Prevent resource leaks during initialization failures
>> 2=2E Ensure proper cleanup of allocated resources
>> 3=2E Provide detailed error reporting for debugging
>> 4=2E Maintain consistent error handling patterns
>>=20
>> Key changes:
>> - Initialize all pointers to NULL
>> - Add centralized error handling via goto labels
>> - Improve error messages with specific error codes
>> - Remove duplicate Intel PCS quirk call
>> - Adjust log levels (dev_err for fatal, dev_dbg for quirks)
>>=20
>> Signed-off-by: Alexander Roman <monderasdor@gmail=2Ecom>
>
>I received 2 x v3 patches with different commit messages and titles, but =
these 2
>patches touch the same code=2E=2E Very confusing=2E=2E=2E
>Which one is the "correct" patch you want us to consider ?
>
>And please send patches to *all* maintainers of the subsystem=2E
>You can check that with "scripts/get_maintainer=2Epl driver/ata"
>(you are missing Niklas)=2E
>
>Note: it is too late to apply this patch anyway=2E If accepted, it will g=
o in
>during 6=2E16-rc1=2E So no rush to clean this up=2E Take your time and ma=
ke a proper
>patch please=2E
>
>
>> ---
>>  drivers/ata/ahci=2Ec | 98 ++++++++++++++++++++++++++------------------=
--
>>  1 file changed, 55 insertions(+), 43 deletions(-)
>>=20
>> diff --git a/drivers/ata/ahci=2Ec b/drivers/ata/ahci=2Ec
>> index abc1234=2E=2Edef5678 100644
>> --- a/drivers/ata/ahci=2Ec
>> +++ b/drivers/ata/ahci=2Ec
>> @@ -1611,7 +1611,7 @@ static int ahci_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
>>  	struct ahci_host_priv *hpriv =3D NULL;
>>  	struct ata_host *host =3D NULL;
>>  	void __iomem *mmio =3D NULL;
>> -	int n_ports, i, rc;
>> +	int n_ports, i, rc =3D -ENOMEM;
>>  	u32 tmp, cap, port_map;
>>  	u32 saved_cap;
>>  	struct device *dev =3D &pdev->dev;
>> @@ -1619,60 +1619,72 @@ static int ahci_init_one(struct pci_dev *pdev, =
const struct pci_device_id *ent)
>>  	VPRINTK("ahci_init_one enter\n");

There is no VPRINTK() here since a long time ago=2E

So this must be based on some ancient kernel version=2E

Please base your patches on:
https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/libata/linux=2Egit/log=
/?h=3Dfor-next


Kind regards,
Niklas
Hello Alexander,
