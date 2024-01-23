Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391415D907
	for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2024 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010775; cv=none; b=Cz0agAVu6hCytOzpCg50beCuf6D77+5gEjZykShblC3gp3ugP5TgHlfj51N0MI4QuJ4pQYpoH6sabbdijYKEANMXNQXkgiw4nX6/hia0U5DMZ1WfEEH6y9tdS2lW41q6u4is94WwzIJPU+Y1/YPSFOXK9s1qlijPw0+Iiwlw2lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010775; c=relaxed/simple;
	bh=Qkzg1uFAGM8CXcOb+Pi03EOAO7m3tw8PpvAi/cL/+9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZSLbeGPyEbKkHUKlJza0LWVYKrUoGwHnZKfWexvk36ac9qersnXpo7jnuOixbeMJdSfxEY7eGnlNG1fkFnLaudh7q1jM1580vCeZL1sm8Qdye6IuiSfrLndCmLHb04w73KPfnQjHwJa5g/eB6EoABNwS+v3Dps4jvuUsDm+dqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVRGt0SA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVRGt0SA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E49EC433F1;
	Tue, 23 Jan 2024 11:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706010774;
	bh=Qkzg1uFAGM8CXcOb+Pi03EOAO7m3tw8PpvAi/cL/+9A=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=YVRGt0SAs1qN7cC+CYJsYuQCkMAfrS+Z+kDqO9vQKKvMsgqljjxuiEx4fbdxNpzfz
	 2C9q6AlDxsel0tMf0/5PBK53l1jWEbYJ53m/zYezICPRvpcdxPzVVMHaKVdv7auNYB
	 qW0ixhpY5yDE7uEr3Sb+enMAn2N20k4zfUXWyUrVoyNcEw1LXeXQ76ss9O8GoyfyFS
	 ln4zliapj9QQHVjvGWlquGPgHUoGjJGw2D4kBm3u2CemxV5Lkso0/hDJDEPuN3P1j/
	 YG4Iy6+uqs8Wtmqe+2vsUl7YCsK4odVp38m1DWFJebK4JMQ/o3BQnE5Q2BZB3FBzzH
	 +AN7JMqgkMJAw==
Message-ID: <a72daedd-48c4-4eaf-9a77-a34679636a8c@kernel.org>
Date: Tue, 23 Jan 2024 20:52:54 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Aw: Re: [PATCH 0/2] Power management fixes
Content-Language: en-US
To: Dieter Mummenschanz <dmummenschanz@web.de>, linux-ide@vger.kernel.org
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <DU0P251MB082515FC8FE77424231B475CF4682@DU0P251MB0825.EURP251.PROD.OUTLOOK.COM>
 <345be856-8959-4148-bcae-00b3fbcd0d08@kernel.org>
 <trinity-0be6e8a8-e6d3-4d60-be0d-59592a9edd65-1706010022623@3c-app-webde-bap10>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <trinity-0be6e8a8-e6d3-4d60-be0d-59592a9edd65-1706010022623@3c-app-webde-bap10>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 20:40, Dieter Mummenschanz wrote:
> Damien,
> sorry for getting back to you so late. So is this patch series just a revert or 
> is it something new? Can I patch and test against 6.8-rc or should I use 6.7? 
> Anyway I need at least a couple of days since I'm very busy ATM.

Yes, the second patch is essentially a revert. If you can test with 6.8-rc1 it
would be great.

Thanks.

-- 
Damien Le Moal
Western Digital Research

