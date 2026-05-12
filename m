Received: from mail.tkel.ly (mail.tkel.ly [149.248.17.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AEA370D7B
	for <linux-ide@vger.kernel.org>; Tue, 12 May 2026 02:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.248.17.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778553714; cv=none; b=roprGcx2suyhjr68sJNdhTctnes2EBvk1pk2ruNJbYh+wZW8CtdvUXxrP6SHa6o8eS+8JoVn1Ynp0OyICox6tlal9h8q0/8JH+o6swvLigv1EEhbLYnjVKok8hHyfwqDsaCcfAahHQigZBOBlLKvTpPvOolB6g6IPjOGV3JWF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778553714; c=relaxed/simple;
	bh=RVctu00e7P56rdrngF9anXzjqc58yQsi3gxcPBPFSac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQ4U+yczkhD8qR84ysxgMzHSFBD79OGgx1lCxJ61NF6EqsNdvF9F4tnHclfxHhW2kfLrwyfB+0N3Qb3ycxMXxfKAVuTUUlVQIpMTcm/ousjMhx494RsioOtrDd4hqQSCOSh0YaDBz8Si0ly134KWnzdud+hDstTOL37ZvSuq4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly; spf=pass smtp.mailfrom=tkel.ly; dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b=ZnM1nNIx; arc=none smtp.client-ip=149.248.17.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkel.ly
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b="ZnM1nNIx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkel.ly; s=mail;
	t=1778553711; bh=RVctu00e7P56rdrngF9anXzjqc58yQsi3gxcPBPFSac=;
	h=Subject:To:Cc:References:From:In-Reply-To;
	b=ZnM1nNIxHQPw5x+3bgRpgeyr01lDRpCxEtmhkUMWE2fvNnj4ijFsC4K+nAHcHq0+M
	 sass9lw6Xia1x22lvxB5WRHDsGbqoMqfnKppE2OjuyP1lpb5jS5AfluwDNzzzO4rbj
	 6/GHwmcBY0Cg+Ma/s9J8iS9dum13+TNABQynbAGbleiGvkWK0UbNGkw7fNkU7FVQRZ
	 6s5QZ8p+8f0EdhMrCe8d9/m5IlfLIiv0YvHUd4Rek71mIYBF/g2NTyXcjnH5B9joi9
	 4zlAjoV8gsRWIfGSd5st49jd5Lg7Oa5H4STu8soJVersMsV2rAOUvlrPBDQ6rd8gDM
	 zrLI41mGEdpqg==
Message-ID: <38ec669a-f69c-4c55-9f47-995d6722806f@tkel.ly>
Date: Mon, 11 May 2026 19:41:45 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] ata: libata-scsi: do not needlessly defer commands
 when using PMP with FBS
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, "Martin K. Petersen"
 <martin.petersen@oracle.com>, John Garry <john.g.garry@oracle.com>
References: <20260508195051.188207-4-cassel@kernel.org>
 <20260508195051.188207-6-cassel@kernel.org>
 <cc742ac4-4278-4546-be6e-07b74f1be979@kernel.org>
Content-Language: en-US
From: Tommy Kelly <linux@tkel.ly>
In-Reply-To: <cc742ac4-4278-4546-be6e-07b74f1be979@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/26 19:01, Damien Le Moal wrote:
> Looks OK. However Tommy did see a warning, so I wonder if we still have
> something missing...
Sorry if I'm causing confusion, for clarity:
I didn't see the warning with this v3 patchset applied.
I saw a warning with vanilla linux 6.19.12.
I just recently got FBS working so I was reporting any issues with old code + FBS for completeness.

With this v3 patchset + FBS, no issues or warnings.

Best,
Tommy
