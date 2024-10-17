Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A378168BE;
	Thu, 17 Oct 2024 00:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729125174; cv=none; b=Oa45lB8+KU+4n1uIEcFIoZKQjqFAn1uJSEXhjm7Brn5cjwd3yeMkMzK4F5b1fmY7V39A8DRCrwxJvJ50bvfJHhyaMydrIIMgN9VNbHl4ARn9xnzm/yY9xvIEiEjvBwgDhWFJKvKDTT085JQydUztjGGUxTV8eyJd/pz5BKgtVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729125174; c=relaxed/simple;
	bh=Xn/lfNOB5CJcKFnlnJ2galW8yMDfxvqUwdmAzO2TVpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AcdPwlpu1IwsSa2KnUo9FrfrZl9zX0pBteojQ+aJdXQljmN1W7+KSU5dKSqtk/1AIZfZT2VzEGnCz8N4yQbW/Qehl9tKPbwCHJvdTq+imog/UkTcWUzjsMS7K8Vys66ZUHwmY5KAOFDQnYlasPnaU+OaVnazIPksXbJ4svv0wtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln/i7zlG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln/i7zlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337FAC4CEC5;
	Thu, 17 Oct 2024 00:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729125173;
	bh=Xn/lfNOB5CJcKFnlnJ2galW8yMDfxvqUwdmAzO2TVpo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ln/i7zlGjoFZ143dK1GKxjB2MlW6XccLYImbRTcl8HjhqT0XSu6z0nyUPVS2wene3
	 wcrw4mm5PZccqmFG6iv2V5flzQUrVHw7nJ4okRRYkmQALn1vc9Kg4X0fyUpvyahIIc
	 HxV+5fvclC8/jtD7IlJIE7u5IduKziTDNgeIV30W18Ac9+CwT4v9hY3Uy3VHdmyX8x
	 uNfEjD5C0BZ9aEN0J/LV+R/Awig4AAATXIM1hkqI7fUBUtdhwYy5bFkpY7cHZOSPMe
	 Qtk2PXzwhd9MK3evbWC3dhn4j0w1LtrKdT+9qprqXYkYyW5AvdWbR4azfHO4yiYtIe
	 onNgiUYQkCt+w==
Message-ID: <12e4ea05-7a76-4bd0-bb86-1d71a94140e6@kernel.org>
Date: Thu, 17 Oct 2024 09:32:51 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ata: libata-scsi: Refactor scsi_6_lba_len() with
 use of get_unaligned_be24()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241016131845.898632-1-andriy.shevchenko@linux.intel.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241016131845.898632-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/24 22:18, Andy Shevchenko wrote:
> Refactor scsi_6_lba_len() with use of get_unaligned_be24() to make it
> consistent with other similar helper implementations.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
