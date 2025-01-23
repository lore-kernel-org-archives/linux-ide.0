Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80430157A67
	for <linux-ide@vger.kernel.org>; Thu, 23 Jan 2025 05:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737608886; cv=none; b=XpocFyGJUIiSFT2vvdr/8f7gN2rWLDHCt1faqAnCIezdRUJrl46G1WRw8Bq+9vJxE7UkeEAlGOicHXPzqnHRNEfrbnIdaNiYtzgtWvX1hMtRzg8Bd3eHX8yi4gXkudAy/HR5S1fxPHRiKJkRnePgYtWtY9+6cFF9Ib7OPkfwAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737608886; c=relaxed/simple;
	bh=c0CncUAm5s4ZCdU5x/d2eVrv8aBK2Ufx9wLCadvqNdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPEid0p7X7F49sFpBhsDeahETf4mwnCmoc9PAZX6NCDDvVVrdHLsvhk9yTrH76/iKwxneLBYaFTNC8nnfcWU75BSj+pSPciqbJwKHGPNNh4n/qSTaM5Jx3+GRl0kHXb5x9+EKIqko5q1+LXUTqoUX6BKq28/kYU9jv0G+lcJf6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=eOlci8+m; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="eOlci8+m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:Content-ID:Content-Description;
	bh=c0CncUAm5s4ZCdU5x/d2eVrv8aBK2Ufx9wLCadvqNdE=; b=eOlci8+mMPOQmo9GK/4Y2YJSbV
	/79TiWKgDgNOxR1KNFy0stKXuyZAtaIC0F3aQYRm3WBBjWbwVY8aGiUutI5osjYKZhFbtZ2fPEpE1
	Jx1DJG6Z+JtbGG7I43L/yahph631eSpkuvDH8taZtokBE2BI5XtxDX9a/9zrDh+AiA/MsAQI/jSZM
	Qn7R+mdRdediBAy55CamqYfQps/DA6r5TtKnXvsIfW7SK+KYaMOuVhispF1WdYE4KHYhJUDQZBK1Q
	U/9jOGPG5FokDkCvNM/5+7rmn+X3HVckMl+CydpkS/nLDLv580rdxVZyJ1PYbU0ipm8sfcKHtNB1y
	cY2Rkrsg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.94.2)
	(envelope-from <daniel@debian.org>)
	id 1tapRb-008EFv-Cd; Thu, 23 Jan 2025 05:07:55 +0000
Message-ID: <46364367-a4b9-40b0-ba67-fbe54b37fc5c@debian.org>
Date: Thu, 23 Jan 2025 06:07:54 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: daniel@debian.org
Subject: Re: [PATCH] Disabling link power-management on Samsung SSD 870 QVO
 drives to make them work.
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <a421afd8-d841-4d3c-bfe9-9dee707bb319@debian.org>
 <Z45NEMKVAsxKvafa@ryzen> <ac64a484-022c-42a0-95bc-1520333b1536@debian.org>
 <14ead38d-9a43-4b14-ac7f-7b0410b9cdfb@kernel.org>
Content-Language: en-US
From: Daniel Baumann <daniel@debian.org>
In-Reply-To: <14ead38d-9a43-4b14-ac7f-7b0410b9cdfb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Debian-User: daniel

On 1/23/25 05:21, Damien Le Moal wrote:
> For reference for future patches:

sorry, I wasn't aware.
I'll make sure of it for next time, thank you for the help.

Regards,
Daniel
