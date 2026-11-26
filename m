Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795678175;
	b=OrL8Lj0icb5nbpUv5aHLxasaVPWfPxYckm4TOnbIGaea5kiBHS14kxH4EEtNp0avP88P
	 KfPpgBbfOcyK3ZmSVM3TMUPdsl9JLZWJIkXVkx/AMybEPu59LHWgAGjUhSvK6aTMb9Aw5
	 XIWYnnFX5iyWYHZvFVT0ukZQUNGqne5XqVhbQ/nVBX1oIikjQKu2YRxl6FuiKcZLTV8LK
	 0UnbHtFpG1AtcrM168h842IGeaZMvdIlIzdhAR4hk5rdkhTiPEnIhBvgurVUXjpMi2IS/
	 aXCDJ6YnfcljBxdS7b8nir4r/naUhlNZKWqt+G/km9E/s88Vrz1FjYNZvXTkS8TSJ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678175;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=q5FQUd3H831tNmy2z/uAabmLHNKCzBhRvpxfS9TYRb4=;
	b=p9uDlJTO3EDpCHHk5JExaxdZZRALxqSTBARMp1bkDSGEGTIo4Cgo2uBuXHXikS3EG+ih
	 1KA+tdBl39FpjWA3a4QXskl6zgKC9sGvKm7bgusYP7CupbXQULRUeql9474wQwfbJtOD6
	 JbIZaxofQPn8LSTJuvuUubFtFjaBAdx1XfhL0VZN8HeT856u6qROVPVFCxZKYUwKQz9Pi
	 TZyCySSdRFQhTAXsNoB4RdSi/Tz9ZgXqmj8suSzi/p+XvF6roAB2G44AfMK4INh8abXih
	 EegERanMgYN2Bxgegsfrs0DeiNBaTt8RJJnt5JZtGrks+HgJcpCr/PMSS0v1YGYCy5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+9bWQPx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4C606A31C;
	Thu, 26 Nov 2026 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+9bWQPx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032571F000CF;
	Thu, 26 Nov 2026 07:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795678174;
	bh=q5FQUd3H831tNmy2z/uAabmLHNKCzBhRvpxfS9TYRb4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=m+9bWQPxITDCFZXFdRuRz+KJ+590Xjp9XoEuaCDJHxMVl9j4K87vv06n/fYPK7NIL
	 FSNXgn+hoFKTQSHF+1pPdlBptTIOyCR2j+VZqme+DBr0qe+1gGf5M/c7ZTw4AUQ7L6
	 MdiQoW8C9uDSZwdPIJe2p38G/+hTRnWrG7ckNyAtbSAS0Y7lY9xL3DTH1gufXpKx3D
	 wCLozcX2BCqY9p82gr5QaLxgXSXjcB0leoAd3tgo33Nyts/vimSMbTXwkFDQSlffQH
	 gg3Pku1E97qwVfTFLGdU6O9kuWQkRpGV7pnr/vj/GGZdhG3eIrk39HedKUA8NVbWtO
	 iO0jj8qjb2pvg==
Message-ID: <d633a9d0-cfa8-4d07-bfa1-ae56de3052e4@kernel.org>
Date: Thu, 26 Nov 2026 16:29:32 +0900
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ata: sata_dwc_460ex: add missing newlines to error
 messages
From: Damien Le Moal <dlemoal@kernel.org>
To: Artem Novak <artem122novak@gmail.com>, vireshk@kernel.org,
 cassel@kernel.org, linusw@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261126051523.14431-1-artem122novak@gmail.com>
 <20261126051523.14431-4-artem122novak@gmail.com>
 <5c9b117b-6bc7-4246-aa1b-228e4e4a43cb@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <5c9b117b-6bc7-4246-aa1b-228e4e4a43cb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 16:28, Damien Le Moal wrote:
> On 11/26/26 14:15, Artem Novak wrote:
>> Terminate the error messages with newlines so that subsequent
>> kernel log messages are properly separated.
>>
>> Signed-off-by: Artem Novak <artem122novak@gmail.com>
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Oops. Retracting this.
Sashiko had a good point I think about this patch. Please address it.

-- 
Damien Le Moal
Western Digital Research
