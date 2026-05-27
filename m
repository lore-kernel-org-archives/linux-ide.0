Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A336363C40
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916207; cv=none; b=tVD5+TEJLU2dqk5aNxrmHtpbkVwZSqZnOCXqjhvJUbV3VZyy62SrzA+uwD4zdq2qQrCfKP+Diu7/hO+LLneQGfRZRVfJ1ZgQllWAOaGYv8n65QSqjax4e+NgPXCGrzoF/xR/xo9Upryq3xDHcpTjcf0fGHqeXbNz5XOsYvs12HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916207; c=relaxed/simple;
	bh=nr3OQqvawcjjVYIsPWl7AAv8IwSGzS/CTQxBl02HxWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyUWhMYfsrLN8hmb9jOjQme6/4uAACg4WKXNK1IkD40fYQWRAfzTRwfFF4sZUo2adtr7slgGFX/drsFrAWElCZXjVIOpZouCJdfLi7D8pmQX/3p0XlI2pAVnqqt/DkpGYRsQ5Vsxld1xNZZ4Hgs/lseMTJ/jI/897cpCi02fTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OKy1mwiY; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OKy1mwiY"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gQj1n5cT9zlfwHM;
	Wed, 27 May 2026 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779916201; x=1782508202; bh=JPsx6taVrG4eGVulcTm+84Vf
	BWDK8UnIEI1RxzO0JuQ=; b=OKy1mwiYJZ8S+CsrhyAgoSZc5D07r86Vqb5cxTXG
	qKwC0KZLTZDwVfpn/fKCAGTi/UqgpiI3Pt/DydO0iwmq9mCNCdUA7BtnAJrIYxCb
	WcwlXQLhizAWGZLFKrBySmXV6k8lDAvvLELXw5kA/veNz78O3kqmwJFRyM08jcwz
	6gRRFsS4eeMxqWNnR8wuFbA5Bn5d3/R3ssGQU5QloZGoWV73YDUi62Pp4BUOBaWe
	Etm+J0Ww1TqZFGy8pXeyBhdaHm0i2oSKbx4f8euyLdqO4ISWfxzQ3O+UH6dwpU2a
	X04wgxHQq3p/YknyPcx4eSXEpCYoPNavzyP38dCeCQEJ/g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MozIvebE3dYK; Wed, 27 May 2026 21:10:01 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gQj1f2yTmzlfvpM;
	Wed, 27 May 2026 21:09:58 +0000 (UTC)
Message-ID: <ba294bb0-438f-43dc-8507-836d56f83a69@acm.org>
Date: Wed, 27 May 2026 14:09:57 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: libata: Document when host->eh_mutex should be
 held
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Marco Elver <elver@google.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Viresh Kumar <vireshk@kernel.org>,
 Mikael Pettersson <mikpelinux@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>
References: <e95c0eb43a8297c9ab5e220341512882f8648512.1779913278.git.bvanassche@acm.org>
 <ahdaSvf_ydZ8TdiR@ryzen>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ahdaSvf_ydZ8TdiR@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/26 1:55 PM, Niklas Cassel wrote:
> Now for ap->lock: It would be a shame if the work you did on ap->lock
> annotations were to go to waste.
> 
> In:
> https://lore.kernel.org/linux-ide/fcc80572-88da-4e16-ad09-69819f43cd73@acm.org/
> 
> You said that you would leave out the patches that adds an "ap" argument to
> several functions. That sounds good.
> 
> If we go with the option to not add "ap" arguments everywhere, how many
> lockdep_assert_held() calls would a patch that adds ap->lock annotations
> need to add?
> 
> If it is not a crazy number, I think we should just do it.

Hi Niklas,

Making these changes requires adding locking where it is missing. I
prefer that these changes are made by someone who has a setup on which
all the modified drivers can be tested.

Thanks,

Bart.
