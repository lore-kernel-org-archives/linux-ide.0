Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851B331A57;
	Fri, 27 Mar 2026 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625320; cv=none; b=nkvP2xecM9eelMESimVP3O9Pon1/+wD9Z25YvIu8ne4BfrY0iYz8l5lm9QchN880wqB62Cei9oq7EwlzPs8rki8JxCtfHMZxaWXGLEFEZvEVyMHTejeAAlgwTSPa9bKNhOC0soOAayFpfZ6TrENjhL1XX/zhrF8GKuyJdkL82bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625320; c=relaxed/simple;
	bh=+/XGVCJXcPD9xEpQvROa1Jb4qYooQBw26W5dVFBPhF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0EYwI1vBp5z1W5RArYoWVLncsKlZM9inWcd1rDqDwAiEEYaYUlyfi609qv/mFr8aVRevSUEDn8FxdzK5A/OMZrwZ1FIiKjJndflnnTgdO7m7Wijnuu/O78rEKCL7ic1xqVD2nWlhKsiQW7OAGrRhAXyRv9KiiktEx0xoIAV2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRZgKnlB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRZgKnlB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDFFC19423;
	Fri, 27 Mar 2026 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774625320;
	bh=+/XGVCJXcPD9xEpQvROa1Jb4qYooQBw26W5dVFBPhF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iRZgKnlB1tYKDqJpMWE2T3wb6qbuBdLz1Mpj1jRGqYAXSZrBYERUAGfxW6oy1hjrh
	 BZnPw5gn1BnOQ3CiTyJT0M3jfXusxZJrYisW/odCbqw34GxJseEbK7MAUgL6WylqXA
	 eHvkppopzCgvFME3nDG+crl2tzPoVS1AE6l9sfAZJYjhpoowIzutkCAS4EbX9W++m7
	 BRdUWthDa+nfjSsi6HXu0RHafE72fl5LASCk1XHy5uNh9Iq0MI/BeNX1Y5TC5cETKD
	 5UaOjU0ShH21bLTEEjtNgZ1/onpty9rPN124qj7yyzCpoSLSX2wGLdlO5M8cTOV7/e
	 CzOYyXEbB3qCw==
Message-ID: <0de1315d-e655-4c89-be7f-e74275bf6583@kernel.org>
Date: Fri, 27 Mar 2026 08:28:33 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libahci_platform: remove kcalloc
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260327025043.7565-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260327025043.7565-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/03/26 19:50, Rosen Penev wrote:
> Use a flexible array member with struct_size to combine the allocations.
> 
> Added __counted_by support for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Looks OK. But the commit title is not great. Let's change that to something like:

ata: libahci_platform: use flex array for platform PHYs

That is more descriptive of the change.


-- 
Damien Le Moal
Western Digital Research
