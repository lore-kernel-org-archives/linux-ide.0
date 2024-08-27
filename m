Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C9C20E6;
	Tue, 27 Aug 2024 06:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739123; cv=none; b=TGnWkj37cxLAA5DYAHW2Tr9jZ7Nel1wqROP3khtw50BIitI2rd3YMPKGs0JPfAqtytEp5Qw4s5nygbngljcOwGxweim3NI4yObrvyx6udAGTgA5AMCA2emawyj+8w08raawN5Lmq0/JrOqzqiRSRmBBpM5shdYSH/vHgtp5p+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739123; c=relaxed/simple;
	bh=Pz3zs7emzxMhdswiQOLuOpREg/Gm2DreLGc5RzejLeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KmKDsYXywLrTqssQK9eFHku3ORcprSYLaNBQRceOePezbcIRaQSGt1Y4am4lPcFAnzDy+vTPdIH4v/VQoDB8MXF0XFeLsQdDx/uufbrSuUL6L69D4e+CVUEXcpEdu+fm3GvGJCGTfatblrtPWct5d2kz6qDQpUdpvjBMIdLhwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=clIaXTg7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="clIaXTg7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724739119;
	bh=fG7x1OH97cuYrqXwRt3tfXrSo2tqzR3kMonHADTQYJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=clIaXTg7srpOEu96sVX7cpgJT3VYl9yK8hIkUNuEuwYyuxtbh0oGaXBJi3Odw+yr8
	 +QoMQ1OLgrTtIoOXO33jGJPUzFAuBA2fnRmJfvGVSXukBeYzpGUdTq+Z3fhgg+4Blm
	 3u5L20QwG+lWe2MTK9tbnz7MvEY4ZZRuaMoh4k5zhzEyUsKrU7WKfYPEd8ETvSdf9K
	 8GTDRVC14UZhN1CSXXOw6yOOydDEPRQFylel2JGw1fnCXx+UPjG5Vgw+iTKsqBYyYe
	 zmnhq4cSxTVYbVRmIqb0ve2MB7FxQkfO0PKRJT/m8qYzMXEA+tv7u1VNW06qHlSq8g
	 KumBqIvQ0inhA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WtHHv3gXSz4wnx;
	Tue, 27 Aug 2024 16:11:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>, cassel@kernel.org
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, hch@lst.de,
 linux-ppc@kolla.no, vidra@ufal.mff.cuni.cz
Subject: Re: [PATCH v2] ata: pata_macio: Use WARN instead of BUG
In-Reply-To: <6b2208d1-c18f-14d5-e6d0-acd5c82b4db1@gmail.com>
References: <20240820030407.627785-1-mpe@ellerman.id.au>
 <6b2208d1-c18f-14d5-e6d0-acd5c82b4db1@gmail.com>
Date: Tue, 27 Aug 2024 16:11:54 +1000
Message-ID: <87a5gyfqad.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sergei Shtylyov <sergei.shtylyov@gmail.com> writes:
> On 8/20/24 6:04 AM, Michael Ellerman wrote:
>
>> The overflow/underflow conditions in pata_macio_qc_prep() should never
>> happen. But if they do there's no need to kill the system entirely, a
>> WARN and failing the IO request should be sufficient and might allow the
>> system to keep running.
>
>    WARN*() can kill your system with panic_on_warn -- Android is particularly
> fond of this kernel parameter but I guess it's not your case... :-)
>    Greg KH usually advices against using these macros. :-)

Yeah, but in this case it's replacing BUG with WARN, so I figure it's
clearly an improvement.

Also if someone is running with panic_on_warn then they *want* their
system to panic if anything strange happens, which is the case here.

>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> [...]
>
>    Please do CC me on the PATA driver patches! This one circumvented my review
> (again)... :-/

Oops sorry, I think I just grabbed the Cc's from the report. I'll use
get_maintainer.pl in future.

cheers
