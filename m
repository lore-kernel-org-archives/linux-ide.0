Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD9A145356;
	Wed, 26 Jun 2024 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383639; cv=none; b=i8cGEdp6OxVW9Y+YITrf2QW4dbZBFAFaG8cK8Uvc9EXmXClGYVWIhfQY67GpNw7LuIb1q6XpIH58oqXKfYu8HUMttVDeKCtBRZUunzTTwxwNuX3MwQay8D/SC+Wq47LgiJEzDw9qqiuYk+afM4s03e4M64X8xuDeEpJ9zfbZ0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383639; c=relaxed/simple;
	bh=A1fbrsc4G6VW/VC5BKNGhzYjVhYGRA5r3KnXL6YUYgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jX3p5y1XhDHdH/p9JoEz4NocP3PgF2MNownvO0h7A8yxGLA92TGVp5PdqF2AsfOnC06UPawHUmXt3FdMpG/n7jY/C7WHhM1BmHEKSUXqj4z06eEcjf1OZOzmlDMDm4p+1H2xRMjBldHJqfb8dOCN2Dqry32pYMBN+CN9QcW1s9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL+B4qxo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL+B4qxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE718C2BD10;
	Wed, 26 Jun 2024 06:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719383639;
	bh=A1fbrsc4G6VW/VC5BKNGhzYjVhYGRA5r3KnXL6YUYgg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hL+B4qxoU8i7uy27RJC6VFmwTf/6o/tPdLEp46I44BTX09m8RsNOMPpNnQXD5u9M7
	 uGS4vaU+9qlU4zitmx+fXIzIPVV4lmipdA7ZfjYCWhELZtg+IY+K+ziGr3jvwjwkqa
	 jzJgom1OasEUnDZHVMjnbg2uWOoy8FqeZcl90HVvKyyRNcfC01csWgU6ybh4dHMc3B
	 iDpYN1VlmvsbYIvFcd9V90y/x9ESx6U3V0BsJYTVpJG0OyjIDxVy6lKK8cC1v5Cm2o
	 shjLrysQ2cFJUi7Vvjk4D23T9ovdVty+GVhUfq149FRwrlaJA8uDGS1AyywUXZpfuM
	 d/V3lUyjFGmdw==
Message-ID: <7b66ba3a-d84a-4e81-9a06-986b9286a298@kernel.org>
Date: Wed, 26 Jun 2024 15:33:57 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] ata: libata: Set ATA_QCFLAG_RTF_FILLED in
 fill_result_tf()
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jason Yan <yanaijie@huawei.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-6-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240624221211.2593736-6-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/24 07:12, Igor Pylypiv wrote:
> ATA_QCFLAG_RTF_FILLED is not specific to ahci and can be used generally
> to check if qc->result_tf contains valid data.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

