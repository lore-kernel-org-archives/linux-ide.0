Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6466305675;
	Tue,  4 Aug 2026 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826872; cv=none; b=RedQtA+MsFo9fMhzUoNI0i8+Igf414RjbR7ULYBmPViUr2TRKOBlf2g4XmwCITxkajrAbhLhD3D/M+sujX9kGFWnDs6PztpWW0Cuu090jdh5FFK28qj1yNqj3dN8nOA3JDEaq02X+vcJu+hEVMwAIa6Wl5KcYg+cAFy7NXYOkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826872; c=relaxed/simple;
	bh=zJYYEKL1JC8Hg4h51kbCvQPeNDawU0h3B2zCxZ4QNmQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fllR0c6EPFJV31fKLpcj+mobOR1OZcTYxcN87s8+VcC8MvjTKn7zLcYCxZ1J1RP9xG/xw4CKZddxv8DeS1AzO4lVSWkI6myMM76ahgtxV25H5eqT0EaSzSP87EwAHTEXZqZB+hyaCxnY8yO6tl5xJk/WHU8w8Y9F7lldYmde/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVRE6qDn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVRE6qDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCA81F000E9;
	Tue,  4 Aug 2026 07:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785826871;
	bh=zJYYEKL1JC8Hg4h51kbCvQPeNDawU0h3B2zCxZ4QNmQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=TVRE6qDne3al8A9qkzs+pomWzZo5uJQP0QZn5HeKhG+QR6XhEKFJL3jnCpT+fe53E
	 6+c+r2+Yq3ydnE0tbGVf1dvRrGAnvqaX9lsns9kvz8PGNezKngI7fmirEQRgz1tFVq
	 bCXVKqh81jhXlTHNnoTrbinis6g7YQGb0sup0gvkaIQSzUO/RIxtOke6VOngBTMIVd
	 3ehLKRQ+eG9nATxAB9SbzuN7pSuopaJqFYXE1hfzIbw/inn5jCX0XYX3EkfKnEjTh4
	 IbTD2JBsCIQQrXjrhC9Yumhuvj0i4dmf7zqCuIKEoP7TOal4g3Z+s/JQWp6t0b6Kug
	 hHm+19UyjHBMA==
Date: Tue, 04 Aug 2026 09:01:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
CC: sashiko-reviews@lists.linux.dev, linux-ide@vger.kernel.org,
 dlemoal@kernel.org
Subject: Re: [PATCH 1/2] ata: use named initializers for acpi_device_id
User-Agent: Thunderbird for Android
In-Reply-To: <CAA6zWZJ_TCa4CyEGFd-a-u_NS=Dv64KV-HONhomER2PC7p+EyQ@mail.gmail.com>
References: <20260803-ata-acpi-v1-0-f606afaacad1@thegoodpenguin.co.uk> <20260803-ata-acpi-v1-1-f606afaacad1@thegoodpenguin.co.uk> <20260803151417.3DB001F000E9@smtp.kernel.org> <anDy13qZ6rr1tFqO@ryzen> <CAA6zWZJ_TCa4CyEGFd-a-u_NS=Dv64KV-HONhomER2PC7p+EyQ@mail.gmail.com>
Message-ID: <90FE7BC8-5432-49C8-9748-E958E89FF25A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4 August 2026 08:09:52 CEST, Pawel Zalewski <pzalewski@thegoodpenguin=2E=
co=2Euk> wrote:
>>I do kind of agree with Sashiko that ahci_seattle=2Ec could have been fi=
xed
>> in patch 1/2 (rather than fixing ahci_seattle=2Ec in patch 2/2)=2E
>
>Happy to refactor in V2 so that patch 2 would only deal with removing
>driver_data =3D 0
>in the ahci_seattle module=2E
>

I am usually the one who prefer things to be split into multiple patches=
=2E

But in this case, I think you can do everything in the same patch=2E

Still seems like the same logical change, clarifying/cleaning up the initi=
alizers=2E


Kind regards,
Niklas
