Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C7259CB2;
	Thu, 28 Aug 2025 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756356155; cv=none; b=E6Y/xA7aXQjICnJtjg0QPfzztXqWIiAvn4iqUry9i5oMHev6vK8iTOlFuiXH6Y0C05llCx2Me5dCgXKhCJNuDw69Om7evc6DlRdGMe5SQFXgb341GdZ6To001jQcp9Oq3lNh/oHXwCZcghPXeiG1BGGzPG6u5kqt/UAdZfBO8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756356155; c=relaxed/simple;
	bh=RzhXG7YA5z20uKbJqDcRU3nx+33tlO97T91rTjUp+x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PwCpv6lL9z09tb7el2bbCSa+30KJmglvhVKfaTs8FoXM4UaOBfOtHbf7fCT/kgvOWIQ0jTA7IZbXzf3BKhLQkAEJcMx7Wsriun09hfbn82Quuqcd0sKyBwHcKyPOEY6ohgOfdsStthcWzQOLaCBa92YuECrE8Od5/cM/SB8oZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgQls4KD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgQls4KD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4DBC4CEEB;
	Thu, 28 Aug 2025 04:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756356154;
	bh=RzhXG7YA5z20uKbJqDcRU3nx+33tlO97T91rTjUp+x8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tgQls4KDTN+0law2NP0E0muRR8U9sti57JybbIYuSP2iajDnlDAFNhOMkhb57YsuO
	 EUG7KXrwxxnodGePIqCixUypu2Auu5rSYWCsxnVPWLKRIVS/vx7VmtKAtybkB7EBJ+
	 dt5Z+wtPPhcnoykl3VTCHUoix0clmeMAZoZBVlhvSKHVl8L4VS7dZL69oh2i+1d7Au
	 RjCWo55Rs39mU8/tw54DMwNF8mA0aofMfSpffyrMGPoOTR28KBg/tt7zqc1IJiifTh
	 rl6Om1dUvjdwNivwyNf7HbHv7tx/Na6eFLm0kIHN8oDPHohv+lIHO/mmVKF7Iy5alD
	 e5h9nTSJDcVqA==
Message-ID: <06706ded-9eb2-4a0c-ba11-b35b5c05dd4d@kernel.org>
Date: Thu, 28 Aug 2025 13:39:42 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci_xgene: Use int type for 'rc' to store error
 codes
To: Qianfeng Rong <rongqianfeng@vivo.com>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250826075418.196069-1-rongqianfeng@vivo.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250826075418.196069-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/25 4:54 PM, Qianfeng Rong wrote:
> Use int instead of u32 for the 'rc' variable in xgene_ahci_softreset()
> to store negative error codes returned by ahci_do_softreset().
> 
> In xgene_ahci_pmp_softreset(), remove the redundant 'rc' variable and
> directly return the result of the ahci_do_softreset() call instead.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Applied to for-6.17-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
