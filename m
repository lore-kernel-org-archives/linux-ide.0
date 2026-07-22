Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D76C26F2B0;
	Wed, 22 Jul 2026 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679089; cv=none; b=Ws0pGuijR6Pw8iehb62MbGb+p3vTtUtYH+LDSdBuYvObMJPoOgTsgidBKBRnlj2Fkhyf7/5bFpDYV5xbwaW+IcnGmVA/rRoxVlFyxXeouXRW+7Z5xFMAOp/DZNNuNWTI6MAerHoXmoOutNcvOYu0V3iKrG/S6wHJWpfD5ZIyb3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679089; c=relaxed/simple;
	bh=M72rOZu4V53rKSec819L1WC9IlUQAJ2xCoc6cr6M7MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdT/ApzUxxERxmfTm4o+rhGw/+qYRaxNndWBq5vrsAYG99Q6gJX+LsSltZ9MvlRWgKWnD2EGa1xwxMiA2WrFNT0lt41PiRmuMO1xmrxjsFlPIi6MHTUxEmRa0qUFuRgfmGqDgPdjBa+vU2u29NCapf25drOfdEtIO3nVotCdZ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGbPofaX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGbPofaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28991F000E9;
	Wed, 22 Jul 2026 00:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784679088;
	bh=fBnLEI+hbp3dOwbUqwlJflZXMW1gRCkOeD40Rer9GrE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bGbPofaXWIk9s992DYmGZdfK0ms8LIvvbCxMFk9VksZ2y7W+y9/LmFvhrXMlKLoGL
	 QXRmx5yMDEGzkKpLbXf8KIYy1Z1ZadcZ8tkPOhkestwZ3P5WqXyZ2YP6hj9DJWSDJB
	 m8bA/e6TuJV0vFeZNpl7GdTGn28TOxsJteWMcW6aQB4LZO2nrXTAlzFrfnWwzcM7Wz
	 /NSuq82fIn6OYF2npkbcQkTobTn/yX8aT8RtNkdfarlOYlhCJ1WzLczV8UUlt62yq8
	 gGKb7GLFpSKVJd9Pi4P5zHFzRA7dL29koOUqfghTIUc8AyzjxkhwqyhxLa6sn0OYr+
	 PejN1nXWSQ/jQ==
Message-ID: <5c5cfb61-320e-4edf-9789-c072e74e31df@kernel.org>
Date: Wed, 22 Jul 2026 09:11:16 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] libata: WD Green 480GB (firmware 42059100) disconnects
 unless booted with libata.force=nolpm
To: Ronald Garcia Vazquez <ronaldgarciavazquez@gmail.com>,
 linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <CAGiKK17Fg4SgS+y0GzD3new44QzD_yPZU5V3ZeHdUr9mFnfn1Q@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAGiKK17Fg4SgS+y0GzD3new44QzD_yPZU5V3ZeHdUr9mFnfn1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 00:33, Ronald Garcia Vazquez wrote:
> [BUG] libata: WD Green 480GB (firmware 42059100) disconnects unless booted with
> libata.force=nolpm

Not a bug, but most likely yet another device with broken LPM. There are plenty
already.
Please share the output of "hdparm -I" and a dmesg after boot so that we can
check and prepare a quirk patch to apply nolpm permanently for this device.


-- 
Damien Le Moal
Western Digital Research
