Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830BF35C694
	for <linux-ide@vger.kernel.org>; Sun, 20 Sep 2026 04:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789878838; cv=none; b=ZQsmbZcK6zwSULzM3dasRwMSfL2lyK3MndMckQE28ZgfCSRC+IvO+NMl/f69UnRbQ02BUhsmneGo023C0rKYVG74MOcmOLzWjGBNLkDJzhLUiohpZ/ytu+1Yb8flG5KqoDOEw8H3v8LkVWzqKo3xTBAYinbRul0lVcETqD8PFm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789878838; c=relaxed/simple;
	bh=7BfVeuFSbGfBHAhF07ya3mH1MHg5IVopKXqee3NusJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOFbRVErUke4vj89Oq3M1V/i4I/eTSK3/82Vx55E7DGdW+xcU6pI6m2fvkmlLDLK4VZgGwBbnrxO2UxcQ7GvY7I+AsewU8zZ9S3oaJ8N1Kv1OE54jUKkrUjuwauQg7TblzaoFeWCsBvu0gf2UiWCUmfWQ7k7bqtGCQVt9zW8x4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dodrvhxf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dodrvhxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406061F000FF;
	Sun, 20 Sep 2026 04:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789878837;
	bh=e06kCwxhvfcHyqKqo02OWrkaKu7RmCBgJ7Lm/FynNug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dodrvhxfbnGoUu+W0H/pHOjPxmvswyN1IHiPrdSKHTsnHdfZz/ThdeYPwiI3UTzaO
	 GdUITxqAWcwXbQ5U2/i1lphvHV4M+5mGX1PQB9sZznzvAeQqpGNhsUyW0qwC7nKscx
	 2CYw/bFF5dCL5VG+FKJQRnYhJLUnFF/E67+4MvQYB1hJvhBGmyxsEIQ1swOCdbGKid
	 ihmVC5QmMiMVp8e/djSnZ2udDrRV41qZ4cHLxu4WG19SOYUqLS50C+ZSvHNqICmf7n
	 +OcekwJMHvvydUbW3GseUthXIgnQ6XlO5lFruWSfj6COhjEdIRigPUDYGIrnFk2Yv5
	 iMQo7lt7un63Q==
Message-ID: <e28ecd67-abd3-444e-b218-136ec2d9735b@kernel.org>
Date: Sun, 20 Sep 2026 13:33:54 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: libata-core: Extend Samsung LPM quirk to AMD
 controllers
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, grandmastertriplej@gmail.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Natikar, Basavaraj" <basavaraj.natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20260918124030.1962773-4-cassel@kernel.org>
 <20260918124030.1962773-5-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260918124030.1962773-5-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/26 21:40, Niklas Cassel wrote:
> A Samsung SSD 870 QVO 8TB connected to an AMD 600 Series chipset SATA
> controller is reported to time out on STANDBY IMMEDIATE during system
> suspend with med_power_with_dipm enabled. The command completes when
> using max_performance instead.
> 
> The existing Samsung LPM quirk only matches ATI controllers, leaving
> AMD controllers unaffected. Rename it to
> ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD and extend the vendor check to AMD for
> the same Samsung SSD model patterns. Keep LPM behavior unchanged for
> other controller vendors, including Intel.
> 
> Leave ATA_QUIRK_NO_NCQ_ON_ATI restricted to ATI, since the reported AMD
> issue concerns LPM rather than NCQ.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221986
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
