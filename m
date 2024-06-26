Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D4514F9E1;
	Wed, 26 Jun 2024 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383404; cv=none; b=S8kbn1GhLragZGTKtHK1FLA73LHVbi1JOJyyn7Bh69FqOiuh5hiFkpk/o515Yi9mto73XRS9oV9z/XVDi4sQqwAedWyQHtK/it6x1xhgXVkOs2y/FQbGpcLQ8Lw+DbKsL9z2GcwooLpa4cPF42gDP5cHnJBa49eOjaRUIG7DRf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383404; c=relaxed/simple;
	bh=dvgDkdPHodRwg0TIWQrdE392ygtaoeAKkgzVuhFP1E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ue1Q4nd/n0cWUVNJ+OQJ6sNtwJsNeBPSbAAYOyGVoUaGGUfwDeq62gZoXou22M1l6osN7Uahrxt5aS95ll/9z/JFjN6FHmIJZCUCDwEhxUgmFgO9EZuwyT92/AttlEkwYfjYvtVRJjd5MUnRNYnJ7Gcm2LCoUU+2dRmkPfTlrmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqe4UGW5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqe4UGW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D87CC2BD10;
	Wed, 26 Jun 2024 06:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719383404;
	bh=dvgDkdPHodRwg0TIWQrdE392ygtaoeAKkgzVuhFP1E4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tqe4UGW5gyO9GswQscVZOxWrAuPW9NTD5fnqGWt08kWf8R3yvF2fA7eMUmecanRLn
	 Abk6R52/kAdgHtBoCZ2B1titl4uo9ptKj/rj6FRSg8qkXW8n5zgccV3SG76N+RO9kx
	 eIZ4Z9EiCLlTI36I9Y37nsbUtw4qvCt3Fs5YozJbwZcDqjKxg9sKy+Mc0gqUDMOI0A
	 w0nwUybVgJOxKX8yQ4bIXvTuwqZr4GyBf+OjO6+oAN7NRkkRhski/5uGTNgqJExUi8
	 fBNe/5KgP/uG1cBwJs4rGLcusUNo4U6HZUwhEkIptVYg8vHCg+sej5UHJeDgrYkpmO
	 y5uzrPIBgNVww==
Message-ID: <df6de015-556c-4581-b447-d3901852613a@kernel.org>
Date: Wed, 26 Jun 2024 15:30:02 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] ata: libata-scsi: Remove redundant sense_buffer
 memsets
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jason Yan <yanaijie@huawei.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-4-ipylypiv@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240624221211.2593736-4-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/24 07:12, Igor Pylypiv wrote:
> SCSI layer clears sense_buffer in scsi_queue_rq() so there is no need for
> libata to clear it again.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

