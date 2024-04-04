Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CEC8F7D
	for <linux-ide@vger.kernel.org>; Thu,  4 Apr 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224277; cv=none; b=Rlq40J1W/JIrWiUqbmLqOouxYTEbALpEcxKusEKJhbixy7aOL2eAl5lBmSoDc1Y5pOIYjV97FUCR0B19f8DEXRi4Al0sU/BUfo4BVEI9eK5cMH33sofh9vQ9OT0ddzjNmQR8MrBL/9z7UUpWLeBAP0zAFhj4fLAAl1O61hTb86E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224277; c=relaxed/simple;
	bh=trdOpF0eV4LAyvSfOQhPU89Mn5gnk0bAwY91a6gTKZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2HYd2DZGSx0TOlwxh8QeUWHTIxvS8UWO61N69Dx/MHyjgCJJpxZHwMWwxK/nwC6QTDZJu/lNtn3sXDtzLkMAoCJYE0SumK0RFsxW7DYGSK+ETPI1Ku6a7sR2Bvvb7EBpI+wla7wuOPXxiRWv+wtLJ+owrBBqrPYly+JU25CwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HR66Lflh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HR66Lflh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E049C433F1;
	Thu,  4 Apr 2024 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712224276;
	bh=trdOpF0eV4LAyvSfOQhPU89Mn5gnk0bAwY91a6gTKZs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HR66Lflhgyy5XQETP8LNx3amjxFCtCJ3JUO1LBRophycTZuThj3CX1nibZ4gyWtqk
	 zpEYFAMVztLM7tRUfTth+TUjCU2xurDcE2RRXV5e6vu49V/cS6M2r2t+qYfRqBFhyc
	 5KGPt7qGWfHav1JP0iKdT9JRy9/HJLi3CuPdTTKL8o2kzFY5UG6z06D8vJbMMjD7Cy
	 imziefTfehby+1ir9fpdzZ020jr1pcBgYHWV9JxxaI+VJt5mOIu3vfUac/pV+IuWrQ
	 pe6a05QbC7xMFHdWKyGjClL821IILz0Mmx9A+UPnu7eNBQchBNo1O3Hj+qDwp1CXhO
	 HBMAFFH74GrSg==
Message-ID: <21694429-e65c-4f4d-a770-cd450d5ce7e8@kernel.org>
Date: Thu, 4 Apr 2024 18:51:13 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ASMedia PMP inquiry
To: Conrad Kostecki <conikost@gentoo.org>, Niklas Cassel <cassel@kernel.org>,
 Szuying Chen <chensiying21@gmail.com>
Cc: linux-ide@vger.kernel.org, Jesse1_Chang@asmedia.com.tw,
 Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
 cryptearth@googlemail.com, temnota.am@gmail.com, hdegoede@redhat.com,
 jnyb.de@gmail.com
References: <20240319091322.10909-1-Chloe_Chen@asmedia.com.tw>
 <ZflnYu5W5WnnzDio@ryzen>
 <emd6ef2021-5996-41a5-97d9-9864d65bb534@e6a850b0.com>
 <07b6a6d4-a9b1-468f-916f-1d4e6b1f92e5@kernel.org>
 <em1188b33c-20bf-4a1b-87a4-626abdf11c3d@acf693bc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <em1188b33c-20bf-4a1b-87a4-626abdf11c3d@acf693bc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 03:31, Conrad Kostecki wrote:
> Hello Damien,
> 
> Am 22.03.2024 01:00:02, "Damien Le Moal" <dlemoal@kernel.org> schrieb:
> 
>> Yes. I will add a libata.force parameter to do that so that setups that do not
>> use PMPs can avoid long boot times due to probing the broken "virtual ports".
>> Will post a patch next week for that.
> any news for the patch?

I just sent one, you are on cc.
If you could test, that would be great. Thanks.


-- 
Damien Le Moal
Western Digital Research

