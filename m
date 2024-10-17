Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4CD42056;
	Thu, 17 Oct 2024 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152846; cv=none; b=P3TaSCMl+NluVDdVXzOb24GS8eHpVRSKatCsvy8Pj6te9p/4ybHqW1inGcwAJT+9eLAWu/9grK0ar76WZaP0JQd2NRRTDiv4Zg7bXh/YghHvufNrJipNAfrfwCyxwdVIbZEJZGzvqxldrNCmT8mFF9k23T0C7cZp2LWF59mBSlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152846; c=relaxed/simple;
	bh=ywpVm27+czUQ/XiBx4Yv7/2u6IeNZKkzIs2yfAWIf7E=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hFYLXN9aLODNk/TzvUgLmNlYKO67mrwb5nHVxwIXCC0M5LWO5dt0ZMwzDmqNSEDybIUmF3qQTJgsH1LIot2mS6ogg4TD6MYwoBb5MAf3eFLzIddVpVlUZG9+7NYEYvbjZ1wKW05coHz6cLHpTyszAn27Nzo0bO+VfCG6mQ/cx34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8+XuQ1W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8+XuQ1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC08DC4CEC7;
	Thu, 17 Oct 2024 08:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729152845;
	bh=ywpVm27+czUQ/XiBx4Yv7/2u6IeNZKkzIs2yfAWIf7E=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=c8+XuQ1W1YxiiR5kvfUbDoiQZByLdZy3MJZD6XbutA2dOiKBFAIFehBKA6oil2bLx
	 uyk6Qhr467GW6ZMogKVOE8qI8OQOCjXcpUItT9ShmxUXV47a8tbNciTLJrdPLYifqz
	 QrxhZbceUD4lgMq4J7Oibv5HvZdjkaFz2Im2fVXfRCy2bm3vzd3vmmhaZFYKs/ZXQy
	 RhO2QyqKsWss/ljrW5I54I3MgdJsZsRPijpvXkFujkDioCiVv3Emy+ehlCFLkXDL04
	 dLJKmjze3LPXgJ8LOaMi8kqP8F4Uh/ipZrw/xtbMn/gApzkCC59DJT3vCanm1wOknu
	 k53+4krYw9ZJA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241016131845.898632-1-andriy.shevchenko@linux.intel.com>
References: <20241016131845.898632-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ata: libata-scsi: Refactor scsi_6_lba_len()
 with use of get_unaligned_be24()
Message-Id: <172915284468.3923532.8343177921415762814.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 10:14:04 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 16 Oct 2024 16:18:44 +0300, Andy Shevchenko wrote:
> Refactor scsi_6_lba_len() with use of get_unaligned_be24() to make it
> consistent with other similar helper implementations.
> 
> 

Applied to libata/linux.git (for-6.13), thanks!

[1/1] ata: libata-scsi: Refactor scsi_6_lba_len() with use of get_unaligned_be24()
      https://git.kernel.org/libata/linux/c/08b64eee

Kind regards,
Niklas

