Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B6523B63C
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272247; cv=none; b=Wgl4jrsgCdhqS3uy52qywUzJ4TrqePkFJqhiK5x8FXeC1dTq5rw0fPMYEQ5WAlpfSpRsXGgw8ovPVYNbXrsnIJsRkAo0eQoi4+NZxHRROZXuSBkHKxlpnSdCklUVp8nypuSk8zj5t32U/lnzne1eT2xMY7dAbh6VOIylBaa/+E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272247; c=relaxed/simple;
	bh=VPiqj7mEcHlt9m/SWfa9+DNeDXRiMpA9UNJvNWLSDgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WrZB5xu2RZ8XdK1ZjrojH3gXzb1JVk1zsw1vuw9rlcmrumCH+fjtnCZDV86FTqG4qjZ5Gu3BdQIlNHLWoeY66MksZSCrLBkd0OPkjR7MUe4qc80VBS02mQsd07vqV8Q4y24tWmK0LbukpUd28Jq0jPDqzLtAJdbTKuvsOwDWLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahE5u4UZ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahE5u4UZ"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32cd0dfbdb8so15416441fa.0
        for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 01:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751272244; x=1751877044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGHqj8eOyI/UChdbEl+GdFLDTc0a7bH3b8jshvqftPc=;
        b=ahE5u4UZX1X+yor7v3rIgRI/qmDyl2dELw0tv3fS/zgNaWVD0E8RIE+enS1aW2VL05
         dn1Bxn8a5pLUWB5JyzXfbOEWxyqE8bncPhqmcXAvbtUgvb6rIN6XoYvwSOaHrDOw6gKb
         7tnV0dsVKXDHY9f0n+mc/KJUwzwspUT+HKNSW8wzelq9zKcAGbT9B526xx7fF4JaPZSs
         fCjjOgpzr9s9AdvfSVD3Yi+0ovH9B9/ljVgN42oBnaiqNNhaW8o8+U7aHTNEgsV9YeHz
         TDDOlpCEHaXqWhoWnXahyOkAcY3XEkmhMk+e1VztRnpUPSb4oT5Mue4PgufnHt8Yl0AU
         YUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272244; x=1751877044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGHqj8eOyI/UChdbEl+GdFLDTc0a7bH3b8jshvqftPc=;
        b=Yd0TPBBG250IroCWnEf4sSSpMVCaqfE8uKSTFz4mskMfDFTxsEiorbHg6XTEg1YQEo
         XFNkymNJyI3t+hwSOul/sM3vtFd6KYmWVQUDmkB5SS+xSow9YZyV9tIKpuIBQaxvwj6b
         4AE2+YTnqIXZF8p5a5GoPEnazCI1AaDdsg2qwFrzuSrZDc0ZUixlfwE5zB9av3Q3ogsM
         5cLJ21UOIG2AS3vAcBeRnfI4PLAoiLqJpCgtsT4RrE+DMBoKXsoME9QhFXzyHfkWKAY0
         AWrvcTpyCJ7YAOJW8BhEzuwuh3U+NT2CdDUpHEqhwOEqVBKkre11iw3aEETD+lrDiH2r
         DzTg==
X-Forwarded-Encrypted: i=1; AJvYcCV5zgzFWx88RJBZ7Tj29sV7zp68EVXgOEpFmWpNRono3dhIiA1Zsl+QogaAd5rnApg0BymVS5LdNc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBS8E9FGyniZ0btkU/fidbz4wpj94pSijyJM6CtY8F6dXRjTmd
	4af4T+xws7O3fosjFZXMgL0IdoBFa2OXqbyEe7mlPM6qb9H045wopmzbRWjhAA==
X-Gm-Gg: ASbGncuSnsjYm2bjKnFc4JU2XIDwgLMdPu0JvhdAFcfRFzXRIPLMWmfB5eRRGlVjIM6
	OF8xXXGV2gODMoScVvrozSSLeu7f+gQ4qP3TSvKhQDMu16yS7xmWTP8bRd7x9b9H3j4TY5BSkQW
	jhPixKDtVGMT5Of6MPKTzg00sVc07ZlM7OdhYTi6kGfB5cgk/cq5FIbQvI17miCvvifhirY0C9E
	7zTXI0E149OF60w/6AmBy+BbeBwIasx5klgaxig/Oeri3Gezb+CaG/HfmPtyHy4bDL/2CNXO/e/
	kJbf3aHwb+0tH2uZYUjYTXZD27zf2BoYXTUZuRv94NKRSXgr2ZHzQjuVAGeuoLNHTyN5udrGOHV
	TQY7NmDqD8+KdlshJoO56Ybu3cDTtC5AnT1LWs6kE/oA=
X-Google-Smtp-Source: AGHT+IGToQnJqV9pKai/DaJ9m8hDOht117QuuBxd8NGCsZGSsvG8qlEQwkd5+Fsyuh8LnSnD8gRauw==
X-Received: by 2002:a05:651c:608:b0:32c:e253:20cc with SMTP id 38308e7fff4ca-32ce25338b9mr21633621fa.11.1751272243243;
        Mon, 30 Jun 2025 01:30:43 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:428e:a448:cb45:3edd:6764:724f? ([2a00:1fa0:428e:a448:cb45:3edd:6764:724f])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32cd2efb8adsm11961971fa.87.2025.06.30.01.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 01:30:42 -0700 (PDT)
Message-ID: <230dd6e9-23f9-4329-b552-c26c033d99e5@gmail.com>
Date: Mon, 30 Jun 2025 11:30:41 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] ata: ahci: Disallow LPM policy control if not
 supported
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-9-dlemoal@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20250630062637.258329-9-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 9:26 AM, Damien Le Moal wrote:

> Commit fa997b0576c9 ("ata: ahci: Do not enable LPM if no LPM states are
> supported by the HBA") introduced an early return in
> ahci_update_initial_lpm_policy() to ensure that the target_lpm_policy
> of ports belonging to a host that does not support the Partial, Slumber
> and DevSleep power states is unchanged and remains set to
> ATA_LPM_UNKNOWN and thus prevents the execution of
> ata_eh_link_set_lpm().
> 
> However, a user or a system daemon (e.g. systemd-udevd) may still
> attempt changing the LPM policy through the sysfs
> link_power_management_policy of the host.
> 
> Improve this to prevent sysfs LPM policy changes by setting the flag
> ATA_FLOAG_NO_LPM for the port of such host, and initialize the port

    s/FLOAG/FLAG/? :-)

> target_lpm_policy to ATA_LPM_MAX_POWER to guarantee that no unsupported
> low power state is being used on the port and its link.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

[...]

MBR, Sergey

