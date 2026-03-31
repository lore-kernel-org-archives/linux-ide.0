Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C2F1A680F
	for <linux-ide@vger.kernel.org>; Tue, 31 Mar 2026 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920922; cv=none; b=YoSFe9wuYW58QsaY8Si3+faeQRyF/gZAypBPPHCR1c33ouOb3dTecsadreXcpVmdZ83WPD/KdkA+jo7GUrqtlUxauJn01GqgXJiUiPq8LLmn7hkYAt+YvyMQ46B+9IodxNiEyNuckbq3UUQGvxMzw0KeDgFwmf/4hFZnDJ+ywwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920922; c=relaxed/simple;
	bh=ZiLZEo39XARzojjtamhx8USVihYDlkVHxnJGEwQOSkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwBKaF8WGkq+4teOPswzwcjD5AczKOz/YmbwjvMf3/cKKdNBvGTgfG0h8sxpnsDb7112WRiFGfFo0BQBmoIsAYTnshvQ2PW4Hip9yWEqBphu24SqvhKNivt9bdOmfJUWNNJW4wf9fDi/4421Ppp70E05fsmEYeN2bMTD3lNbPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR7VWamQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR7VWamQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AD5C4CEF7;
	Tue, 31 Mar 2026 01:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774920922;
	bh=ZiLZEo39XARzojjtamhx8USVihYDlkVHxnJGEwQOSkg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bR7VWamQPBHUw1eZUsXVd3TiEmw+xF3UYmbjykPqRDnul7/bGEpbLE1FpS4PiqlMj
	 IRdEt741g6mYDWVyA7boVMiaZSGtCFZUgQhM6xN1+zz+BiPO8d3Nc5+ylqFR3SmivK
	 v6W0sChRbkWIne05oM+e2VKCHppmozUI//un+0jD3iRLmrU6xtE7mnX2eUogf0kzh3
	 cH4wVIbf3r/saEFCpdedg6n4FN6dGs5hoXLCwnKXnAyC5NrooIHU8z6Zgme4bCwJbC
	 lT0Idf25BiQG9Ryhm6Nj1tVywYruFpH4TPSrG9m76+rIVUOQkCVHR6XlqWdvzyHBYI
	 LB+AGuVMu+qkg==
Message-ID: <d1916d58-6bba-44fa-943e-a8f879619586@kernel.org>
Date: Tue, 31 Mar 2026 10:29:23 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ata: libata-transport: inline
 ata_attach|release_transport
To: Heiner Kallweit <hkallweit1@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
 <f9d372b0-cd10-46b2-821f-80c4c29c8992@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <f9d372b0-cd10-46b2-821f-80c4c29c8992@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 12:18 AM, Heiner Kallweit wrote:
> Both functions can be merged into libata_transport_init() and
> libata_transport_exit() respectively, thus simplifying the code.

That is not really simplifying anything but rather removing somewhat
unnecessary helper functions that are being called once only. So let's just say
that here.

Other than this, looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
