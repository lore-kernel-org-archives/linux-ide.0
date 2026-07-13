Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F2038D69D;
	Mon, 13 Jul 2026 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928788; cv=none; b=Dpj/JE5YuTHo0vLnJRGTW+5ZhZ8iKR20N01TgbzK2JH6PZ5OIsGBIVh7S6dRs2V3NbZbtjfKXtTKE0+oawR413UQgqXsXPyVZtlOWQipjQvwODw4OfCdWrqc/p+elpAA/krIkrRj6ZlG3AUv+gBynC/9TKoyq4NcHgYj7PdrCqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928788; c=relaxed/simple;
	bh=g8eutdcy5dmuzYTTkuKIPHa6f2Ed6oeDMAEryz+KBN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h78LGMewJ6+ZkOJtLsHs+J7z57NTpIHWexLUBlOklSkNTFBV/2hZ8IoiwiGXqc/9+HbLILVj0HfnexeC8Tkm3XXEj+2OCg6R8W7uCJrHN1Hu4NMR3EO8EsqTDBkEZLwcGsZKmceOgaYJb8maOKoPrz3hO93o3Bi+Jo8Z8UBKT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXzE0Tqv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXzE0Tqv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3535E1F00A3D;
	Mon, 13 Jul 2026 07:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783928786;
	bh=dp4E5VrlD2wPEJ1gz3WZskBG/bC7c6flrvRHnTX3bWs=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=eXzE0Tqvd8Thl1oEPQVCsVTTLorHtjQP6iPljUU1j6eQYqaJqEhZU/GDB5rMlB3ux
	 kKe/PXkyiFJLf09O9cFuOGEZHL5RwjQnBxWorKo7Y0VBbb8O3bZcBPwGbkch6fFEXq
	 X3Kcv05SXA8YefVzLI2EpO8Wi6DmqPFz7zBC8/H/YnCo5Ec39PElhczjulsMs1ZgS9
	 mb7ADauFK2eZpfsRjSd7/BhQKhLR+jJY6VtONJX8G5+8yGw4lmy90YnOPTSW9ipeHQ
	 gP5cUoXBdfsWArWtxpCVkvNVCUgcEA2JU/NSeNcLc6dJC1Uoe7OqzlXdVHViLfzh4+
	 iQCwEuxCQBLIA==
Message-ID: <5eb759ba-8d76-4ea2-89d0-0f167b01f535@kernel.org>
Date: Mon, 13 Jul 2026 16:46:15 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Remove redundant dev_err()
To: Pan Chuang <panchuang@vivo.com>, Niklas Cassel <cassel@kernel.org>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260710110247.426444-1-panchuang@vivo.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260710110247.426444-1-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 20:02, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Applied to for-7.3 with some corrections to the commit title and message.
Thanks!

-- 
Damien Le Moal
Western Digital Research
