Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795504842;
	b=fZOmSiLhYFLFaRBaVFL8YKbmgA7zBvrhaoAh+N45dEFYt3zp5I4DkBT6tE9qpGEf0UkW
	 y4A5GYyp0lRBCxpQkni0I/mYIey24i1/UK0LgzY5eoryPFgzqPOJ1inqGFx8nbMpCou60
	 sdrt+Wv3jjmY2jozZ2V3DGmkag1VC4RFef+NNpa/y4CjQRqqQDzXxurKarpqN5DK2vucM
	 4cbWiTXyZ/rZZRxwvxEDHTy8cJ+E4K93lD6zULRcVnsY61XL+Tw1Lo2mU/8aqXUagrZlf
	 Fn9wGb4ueW+9jLecMVgPJWPLK/9R6PqctzvAc8aibePPj6VzCwdUpMm1DP09tPmZ6cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795504842;
	h=DMARC-Filter:Received:DKIM-Signature:Received:MIME-Version:Date:From:
	 To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:
	 Content-Transfer-Encoding;
	bh=tHvSxvXCf5VkLnPhHQoHOjXTPcUMHCtMx3XeIE3rH08=;
	b=Sa/eKGjdXfm70PKTUVpdMPHKbn2xnB0gKGsLR2/rtIZrtpeP3B3XBZwLPqXsmTJOk/oa
	 roDFTi4kJ2ujrW00IDmsJOdqeT8MeYOw4jCayV0oVeYHunRDDAFf2lHZnkbozx7tXkwAm
	 vSAxSLiTig+hbYGj/+LRDh2wLXqrXWCehmXyfFREWfbvZ29RcDMjYTeh2uAF98INmI3JT
	 XDMMeETleTKhuH3C57PKKnKVfgfxzge0WDRWic8pyLoHlw+NxYLF3HL/nsPZxIJ9q+2bV
	 yilTYZsRv2lGEyyMO4DcdKpZ1+U6lWwsdG7x/y0Ct71vG27tEzgC2yt2I4dOAhi45jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=CsoC5hck;
	arc=none smtp.remote-ip=185.67.36.65
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05701606A32D
	for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2026 07:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05701606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=CsoC5hck
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id E626D24002A
	for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2026 08:20:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1795504839;
	bh=tHvSxvXCf5VkLnPhHQoHOjXTPcUMHCtMx3XeIE3rH08=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=CsoC5hcktA08PIURAy8uvdKnj1gYgr5vDUKTQma8mgYzRrKQ38bWNDlB8LJ97gi4w
	 rK3727e8WOkEgU7XgZnOg5EMSySyOKmfVb+C061+W1AJ1wOCmg57Pf/VPG0Nu5uKCS
	 fvlhYRQ5MLZBJbHORM3Jd6++PHSsXpnqSBCX6D8BqSn4lhRIfkJtynDJ/B2akwqWFQ
	 P0ojy/ceRnTi8T7tf0dZOtuJJ3dh1xCbAQb7HN6/Iw+TgDU6Ixqwm87X5HSYG+0jnM
	 GhsAsP7OioCl6JweO0wkLN68Xr2dqc4pvyorANu2ykPcgwb4lF9xBJ9uAkxoDu1Wtj
	 iHKlpdzmsrTCQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jYZ3B1gqXz6tsb;
	Tue, 24 Nov 2026 08:20:38 +0100 (CET)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 07:20:39 +0000
From: Tobias Laas <tobias.laas@posteo.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 regressions@lists.linux.dev, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Lu
 Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase =?UTF-8?Q?BLK=5FDEF=5FMAX=5FSECTORS=5FCAP=22=20=28=36=2E?=
 =?UTF-8?Q?=31=37-rc=31=29?=
In-Reply-To: <awSs5Cw3hFkf4O4T@ryzen>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
 <awSs5Cw3hFkf4O4T@ryzen>
Message-ID: <572a3776f303846961d9897c55421a0e@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Am 23.11.2026 22:15 schrieb Niklas Cassel:
> Hello Tobias,
> 
> On Mon, Nov 23, 2026 at 06:51:03PM +0000, Tobias Laas wrote:
>> One way forward could be to a new entry to __ata_dev_max_sec_quirks
>> similarly to the recent commit 
>> a12cc63129380a5364e787d92b30a3257f66c250
>> ("ata: libata-core: Add max sector quirk to INTEL SSDSCKKB240G8"). 
>> However,
>> I wonder, whether that would fix the underlying issue or rather be a
>> workaround, because 4088 does not fit the pattern of all other 
>> entries,
>> which specify either a power of 2 or a power of 2 minus 1.
> 
> Your attached kernel log shows that you have a
> Samsung SSD 860 PRO 1TB, FW: RVM02B6Q
> 
> This SSD is probably quite common, so I somewhat doubt that it is the
> SSD that is at fault here.
Hello Niklas,

thanks for the the quick reply. Indeed the Samsung SSD 860 PRO series is 
quite common.
> 
>> 
>> Furthermore, the first error messages are DMAR faults, and a SATA SSD 
>> that
>> isn't functioning properly shouldn't cause any DMAR faults, because 
>> the SATA
>> controller should never read from or write to areas outside its memory
>> region.
>> Since the issue with mounting the rootfs disappears with 
>> intel_iommu=off, I
>> wonder, whether there is a limitation on the maxmium block size either 
>> by
>> the hardware or from the configuration of the IOMMU and SATA 
>> controller by
>> the kernel.
> 
> Considering how common your SSD is, my guess is that it is somehow an
> IOMMU or a BIOS/ACPI bug (since the BIOS generates specific ACPI tables 
> -
> DMAR on Intel).
> 
> 
> We have seen similar reports here:
> https://bugzilla.kernel.org/show_bug.cgi?id=220693
> https://bugzilla.kernel.org/show_bug.cgi?id=221713
Thanks for the pointer. The first report sounds as if it discusses 
several issues. I agree with Ivan's comment at 
https://bugzilla.kernel.org/show_bug.cgi?id=220693#c42 .

I am afraid the second report is specific to HP server mainboards. In 
contrast to the logs in the Debian bug report, I have never seen the 
following error:
DMAR: DRHD: handling fault status reg 2
DMAR: [INTR-REMAP] Request device [01:00.0] fault index 0x1c [fault 
reason 0x26] Blocked an interrupt request due to source-id verification 
failure.
On my mainboard, I have only observed DMAR errors with [fault reason 
0x0c] non-zero reserved fields in PTE.
> 
> Does it work if you 
> revert:https://posteo.de/webmail/?_task=mail&_id=4553111306b0538dd90e75&_action=compose#
> d373449d8e97 ("iommu/vt-d: Use the generic iommu page table") ?
To be honest I built many kernel versions between the increase in 
BLK_DEF_MAX_SECTORS_CAP (~ 6.17-rc1) and HEAD for the bisection, and 
since the change you mention was not included until 6.19-rc1, I have 
tested kernels with and without this change, so I doubt a revert would 
help.

Best regards,
Tobias Laas
> 
> It would be nice if we could involve some Intel IOMMU experts.
> 
> If the ACPI DMAR is at fault, perhaps it is possible for the kernel to
> patch the ACPI DMAR for your platform.
> 
> 
> Kind regards,
> Niklas
