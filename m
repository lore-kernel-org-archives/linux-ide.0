Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F547CC69
	for <linux-ide@vger.kernel.org>; Tue,  5 May 2026 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987761; cv=none; b=JeZDlBoVPtDubKHWKniUoG+rHn7WtfQ5OWFMuq2JTjKwKIfFJkA7YLjvtXIMRs+d9aZfupTnRsUXpzmvMpHpqyDoPVpDfscdF6Vv7kok0wudWi1GCFZtJAdwdkPVeif9pd8syI5vbL/WhtXldE+kcIE1tcUsLV0suDBPTwpEkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987761; c=relaxed/simple;
	bh=/L09TX78qZKJpGwfX1+eI3584W+46T4azpME1MOV4G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmzSGTZmGy8Bx7P9CAo53dzWtO+k/+v+DUnXO1YTmEZYQC9tCqALWtXFkgpKuIxhZxCPkkPS6zH6Dx2FQF9RRg46n17bW1HiliywehS/Wu94RWaH+kPXHJIs1tq0SiYUm+aLIFfn0ztsZea0tuehN1KaFr4MPybKqwjWWlGXy84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSr93F2T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSr93F2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166FCC2BCB9;
	Tue,  5 May 2026 13:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777987760;
	bh=/L09TX78qZKJpGwfX1+eI3584W+46T4azpME1MOV4G0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NSr93F2TCcS1KIGrMDSritc98rjodCcVMglFfC8IUkjveLoqdJTnZBwcBjLwlldO1
	 R3XhoTGchZBpB76ogCVMGJfkxU0WYh8AdeBqeq0/12AzlhRJVMzGg5YWPGPJA/K0T2
	 +1xAs9mkuNkxBK6CWqrsTJvDGabajIIva8zzYjRdcuh92QbL8l00FjP9oy00dwZKpH
	 zECSzvlvSmtYRE9OHFwRGrGRsC71gDKMY9iT5u6b+jVagJlDBopEeGKO3CHhMBVtiv
	 SeHUkfwgcYFw/RZ4kcEGcMWrlPKx2rIp2Z97os1SOdr8wWcIn6SHi8YXW/fpk+7sc+
	 FTWx6HbciuB/Q==
Message-ID: <a9845705-c358-414d-afd4-3c750f328ebc@kernel.org>
Date: Tue, 5 May 2026 15:29:17 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: Move EXPORT_SYMBOL_GPL(ahci_do_softreset)
To: Bart Van Assche <bvanassche@acm.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
References: <20260505042310.909857-1-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260505042310.909857-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/05 6:23, Bart Van Assche wrote:
> From Documentation/process/coding-style.rst:
> 
> ----------------------------------------------------------------------------
> In source files, separate functions with one blank line.  If the function is
> exported, the **EXPORT** macro for it should follow immediately after the
> closing function brace line.
> ----------------------------------------------------------------------------
> 
> Hence, move EXPORT_SYMBOL_GPL(ahci_do_softreset) to just below the
> definition of the ahci_do_softreset() function.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
