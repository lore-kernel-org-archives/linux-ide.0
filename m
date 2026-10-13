Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CD0253340
	for <linux-ide@vger.kernel.org>; Tue, 13 Oct 2026 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883506; cv=none; b=Wb1Nmhl74fYcik+vCLgShOSo3jDqbgbRn+y9dHKVbkldq/pQ2rBCQxCEavQTamcVyt2j/luz/tMCJWo7R5PlrnyrRcU+0y1SdhQwuhLI5lLO94cxlhu9pAyvtKJSEVoNjao2i/9b4C+675mZ5tmbgK3IiK4VgRpuG3xl04a/a+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883506; c=relaxed/simple;
	bh=xJxLysjXDkSmfuDrEMKZmgAGvfK4XDYV22ZzOKIEFuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMXC8MfHicgk8qxLl0wzk7gFaN2xrDuN3rf06GPrEiaIPxzYOEHbuizX0vexUANRD6b6uoQL94GmwzJwn1nQw+S7p6dh8RjjQpvcjX2SeSnEQ2LohAcPo6csyAX9wKlrZ9FLHpRkI6MwYCTXYsiTGjgJjIulSakxoNcVN6L+RYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKuR6gA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKuR6gA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856FF1F000FF;
	Tue, 13 Oct 2026 09:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791883505;
	bh=BPdPc8y1uTTq2ndk4mQochBuVJ6SP4Up5ImdaYg3Fso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RKuR6gA6qG3J32VGax8TwOaT+szd6iWgJdWhglUC49+D2nRcoY5sA62MlSdqrte3n
	 CNCspWyoTYTNKpdEE/GBDTi1uByz2fPNau4pIoUC7+FYgc7ydKw7rkVmQUCigTPL8m
	 77eTlv82owX6TlCBxflj02k+CXDxOybH5xid/fvQZZdLT7KQEw7YfG6eqSJbj40Xf2
	 rh4lDq+sUdSXEbQ7+slsw+85IfCOd65Ro99T8tzuTSnvV3Q6ifmzADhTVFomShfOYV
	 LyCe6eA1crkNPVhHn72SP0EtTodMpkBzEI7g1fr6/7n3HfDP0TfG2xxn0ntdaYr8ez
	 xWo8CREuTBiwg==
Message-ID: <e02a0823-87ef-48dc-9ef7-447213159824@kernel.org>
Date: Tue, 13 Oct 2026 11:25:02 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libata: Fix wrong HPA horkage
To: Niklas Cassel <cassel@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>
Cc: linux-ide@vger.kernel.org
References: <20261013042146.76467-1-jnyb.de@gmail.com>
 <as3dvdomgdOl5bBI@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <as3dvdomgdOl5bBI@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/13 9:29, Niklas Cassel wrote:
> On Tue, Oct 13, 2026 at 07:21:46AM +0300, Ioannis Barkas wrote:
>>  Code wrongly filters disks by their serial numbers
>>
>> Fixes: 16c55b038033 (\libata: implement BROKEN_HPA horkage and apply it to affected drives")
> 
> This should have been V2, as you have already send a patch for this.
> 
> Like we commented on your V1:
> https://lore.kernel.org/linux-ide/40630ece-de85-48a5-8683-93be32e5d644@kernel.org/
> 
> The Fixes tag is corrupted, there should be no backslash.

Also please fix the patch title prefix. It should be:

ata: libata-core: Fix wrong HPA horkage

And the title could be more explicit as to what is "wrong".


-- 
Damien Le Moal
Western Digital Research
