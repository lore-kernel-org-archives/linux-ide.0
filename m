Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86F10A3E
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294985; cv=none; b=tnoyRVaoglmWPh9wIPdc/QLt6zzPYXseWICVUYNB/P3KziUDj/de4FtSD0frYT/SqMAAMFiHMeHzNcQvbBex4iR9d61goHelc4YiKl31kGjMbY1NQQdiHnStoXxQzVXvh0DKXO1m+7untiS/Y8Yibd8T4WnXk+lFUE0VxkphnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294985; c=relaxed/simple;
	bh=CcJcnIDtWw+vLmFLlBzLdqzb6PQXGoDo1J0viXcdU0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXOzwmTEgH+jNofSaNpq6RB8qCMoaYgY6kG/qYczSwAgufWnu6b1pcPU7bKmwxeO9Zz8XWGFRuYF3JLDX9yVqbtkmd/BOxvtKS2Oa7mXKSJ8fMFtw3KQCk2sYnRyjNN/tLQFvkWwKUfp9Yi1/T7huXY8jdk1XHAKQmMtcJTE/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAAwE4VQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAAwE4VQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F24C4CEE3;
	Mon, 30 Jun 2025 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751294984;
	bh=CcJcnIDtWw+vLmFLlBzLdqzb6PQXGoDo1J0viXcdU0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAAwE4VQb2POLZuw+7dOVhKqN0y7fIYxGDd+faP0YFyx9WRVZpfOIWtjrb4FJE/8B
	 sQwqelK1Ipsp2zyhhgBPbkKbQeF7yVsN+x+ndyrc73JjIsj+f63LQhxxbdYzMD3q9a
	 SYWhUcfGGhJciDj77iCk8+43LjVAv03jNQRWEZp2kkBEnXGqgUjwRhGoNe0xRI7lMD
	 kVComZAmV1YDNDDNSmfmzjhVtclm8DpRdaRsXRdxmx06LnmarwnjWMeoYzZWbNCqwU
	 YJK/kijrQSqLCHvQYjQjYJOuqiuzKCDPXaHfZ8PVFHIBKgNmPCmJFeDy0VQr+td7QN
	 NH9gTSJmUMqrA==
Date: Mon, 30 Jun 2025 16:49:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 05/10] ata: libata-sata: Disallow changing LPM state if
 not supported
Message-ID: <aGKkBQz1WPdkogmD@ryzen>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-6-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630062637.258329-6-dlemoal@kernel.org>

On Mon, Jun 30, 2025 at 03:26:32PM +0900, Damien Le Moal wrote:
> Modify ata_scsi_lpm_store() to return an error if a user attempts to set
> a link power management policy for a port that does not support LPM,
> that is, ports flagged with ATA_FLAG_NO_LPM.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
