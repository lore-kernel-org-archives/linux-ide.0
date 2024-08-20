Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8D22EF4;
	Tue, 20 Aug 2024 02:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724120949; cv=none; b=kGeM5gGETQYajs4Q9hzVmb9M6pJ3AAZUi01i747xhC0n8Q9P31y/yw6tDfi6RwmGpUlT10UB9Goq4cpvZJGtcin9Q5W86O+2JTQs0RmCYVABjeZtEeoadDzzZnDFu0vCiTqQd8hHo9XbllbFjUFavzJdSXp74puShjbyVYElyqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724120949; c=relaxed/simple;
	bh=Fem/KRV0aW+Ybvx+XkPJCshMRoG84jviBq6gJMhZB60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kbuoc7G64UFASlJjITLxkHYtpgNrhGpEgYNSygHE0dCiHGtzHwO7P31G+HI+WIYmcWTLq7nIDmjtRFF3glqWzU/jW5IjC/YmWqENMoXwfrMUVvzcugqf1CoTo6BqFb6KyP6nDIVOMGXcMmMrRcAF5/tmHUC7M2GP7Jsocggm94E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=EeULGUlN; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="EeULGUlN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724120945;
	bh=JYhMS9u8ZTJ8sPzxbwWOaXQOggyNI+Esur8+zhF4uWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EeULGUlNGbiOIbjPTsblY2BbDNvAaXAc1D2RMq6U02zOeMbZrfWww5zut3YH32j0L
	 p+3+MJpQkoxz7vfFT7celZVVdPsVyYT1TDG6nXvRVqsrjIHOhs6SRTPXivjD9RSlU3
	 5PRSGtSVhqWm0IeZlvSNx5YmrEuT2SnuOPrIIdJ+TwE5Zs0mUGCMf8jv1AUUz9q7Dv
	 Ii/OFYII8RHZW2eOs0lcgfMNr98ap0dDS4wrdyBJKxy89lrsLET7g8A21I/+Xty5DF
	 wtTPM4O1psszqJaXOlcu6blf1OPv8OQqe/V1R/pe+OUl+tio+bCc3w83h7Prn6e3gO
	 tmOnVmFZd2Zvg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wnth131JNz4wd6;
	Tue, 20 Aug 2024 12:29:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Damien Le Moal <dlemoal@kernel.org>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, hch@lst.de, linux-ppc@kolla.no,
 vidra@ufal.mff.cuni.cz
Subject: Re: [RFC PATCH] ata: pata_macio: Use WARN instead of BUG
In-Reply-To: <737ad178-1198-4103-b1ee-46a67ecf12e4@kernel.org>
References: <20240819101913.489513-1-mpe@ellerman.id.au>
 <737ad178-1198-4103-b1ee-46a67ecf12e4@kernel.org>
Date: Tue, 20 Aug 2024 12:29:05 +1000
Message-ID: <87bk1osz9q.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:
> On 8/19/24 19:19, Michael Ellerman wrote:
>> The overflow/underflow conditions in pata_macio_qc_prep() should never
>> happen. But if they do there's no need to kill the system entirely, a
>> WARN and failing the IO request should be sufficient and might allow the
>> system to keep running.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  drivers/ata/pata_macio.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> Not sure if AC_ERR_OTHER is the right error code to use?
>
> Given that this would trigger if the command split has is buggy, I think that
> AC_ERR_SYSTEM would be better. Can you resend with the change and no "RFC" ?

Will do.

cheers
