Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871B745BE4;
	Thu, 27 Jun 2024 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518927; cv=none; b=EEEjpc8d5vGbWsDCD61+l4EtIdpqkgv4MVDvzj+YYk/pUYEUvDLlki4/MwgxU1ORrVOIhP9AY0DOEGCct4JQdlNLTCucD6qhFfIbwXYumpDBbYa8c6T8IqBhJ4bzI5eo50QowIVY9B4/Jm0Je2qxFDvDijb7hKogxcsh49RNuE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518927; c=relaxed/simple;
	bh=zPmtd4MEhWY9TETQmtswO8F+vsKxoyJWAA+rkefKEks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiC0IpsflsXqyCxfX03LT1UHy9/jlpfPUim4xQDdTnuMIGqVrbOXP+pBgoLRSVDZpuWx/PxxHWex3PBP4yNltg7cS09eEkUf5uu0g6ZKjk3Eimk5jVfN82UO6pVl0hRa9FAgAYnRulKdXOeve3dPqlmtGYLC1S94JkjpTCXByfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqznTP+S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqznTP+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE650C2BBFC;
	Thu, 27 Jun 2024 20:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719518927;
	bh=zPmtd4MEhWY9TETQmtswO8F+vsKxoyJWAA+rkefKEks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqznTP+SgiuHYipe56xG9UD/09R26f5re7yvytGwieB2RsBTbZEExewIVWRlHNyPT
	 gZZ8IlJsJBjTyyhySgPC+WkoX8tyItiU8FtFdcs4rQuQ7oD4rOmc72f/a3zabrS3Ql
	 /UR8Xrcj4BGG7bK3YN9jWNrGYR4t4Kom/CwKR7O1H45WDQ/Re9g6Qs3TkU/yllkAzX
	 xw+NjR7KCStI0saHdmuakntiUW8KOD28L/DiXYWVMunFG8esJK64jr44gGji7TMnTr
	 W2bSgC60LFHpeW+zY0VXX46yM9HkKvDdK7fHNdfzyOneoKqXftI+H17haD8lYaOigW
	 MgYCjKKEA4J+Q==
Date: Thu, 27 Jun 2024 16:08:45 -0400
From: Sasha Levin <sashal@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mikhail Ukhin <mish.uxin2012@yandex.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavel Koshutin <koshutin.pavel@yandex.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v4 5.10/5.15] ata: libata-scsi: check cdb length for
 VARIABLE_LENGTH_CMD commands
Message-ID: <Zn3Gzc46q_gXoD59@sashalap>
References: <20240626211358.148625-1-mish.uxin2012@yandex.ru>
 <ab75136a-cdf5-4eb1-a09a-bc59beb6b8df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ab75136a-cdf5-4eb1-a09a-bc59beb6b8df@kernel.org>

On Thu, Jun 27, 2024 at 11:02:23AM +0900, Damien Le Moal wrote:
>On 6/27/24 06:13, Mikhail Ukhin wrote:
>> Fuzzing of 5.10 stable branch reports a slab-out-of-bounds error in
>> ata_scsi_pass_thru.
>>
>> The error is fixed in 5.18 by commit ce70fd9a551a ("scsi: core: Remove the
>> cmd field from struct scsi_request") upstream.
>> Backporting this commit would require significant changes to the code so
>> it is bettter to use a simple fix for that particular error.
>
>This sentence is not needed in the commit message. That is a discussion to have
>when applying (or not) the patch.

It's good to have this reasoning in the commit message to, so that later
when we look at the patch and try to understand why we needed something
custom for the backport, the justification will be right there.

-- 
Thanks,
Sasha
