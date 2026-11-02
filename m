Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793615831;
	b=lMzhsPtLibOsN9v5MvibQSipFVRw+WIyCDDHkxFDZ8QQxokh+GISETPDuuzwNEL6z9VA
	 S7KeF3BnJFGDk8+IGSirO8Xay7WAKNC4S9CvCx0iFDPsr4CyJJorZwsIxjOHkWP0/fvG5
	 /9FOQMhPWNLQFsOtAkdSvwokORk6jEfgYCbbqAIFr10CaobINiDDAA3PqXp79ff7Wu7tl
	 WYc3wf4RwiczCMuhN26BimbWMwoGoNWv+5m6XU7zOcwMabBWbyHle53GWTEHAKCvUTnQB
	 O/Oz70axq5wUG0Am+VURnC7ZJ22unCDv/JZbpSu2lTRM8E3X3IlNtQBvGSErv8FQnTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615831;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=gwaL41LwtiFIKV3Ez0ETu4oWSklrJRjCTtvrAeLv5Cs=;
	b=xSIfrdxAKtAs0vDhALyKWPObLOxxA7DQAurbK5DQ3VJkWEpMnhd+9EP0cYQwC7qu1F4E
	 FIyzstDc2CZOLWUjlXd9lXoAzo53KIM2bipUV0A6QHQ3c1V6X31Fbepxrj4yE2r16HJgm
	 NJldM1xnIpylt/bkyn+/acAZDrcntgxV4iQlF93wkUj8Zhn/ee9CHWqAJqmh0dXzsjmsT
	 gh1yaRLKD7P8qkbr9S0bXrrXXemZcfYbapZq2oNPd6+qAZeVmUHOSQRARK5F0Uc8hwIBj
	 CSwVy1mzwvFUjgRH4IE9jGds0FdHpWkO/C3Ct5IOQeGtzwrQYpgimi7/rQPPb8OctRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQKUOG3F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234FD606A327;
	Mon,  2 Nov 2026 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQKUOG3F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4E21F0093A;
	Mon,  2 Nov 2026 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793615830;
	bh=gwaL41LwtiFIKV3Ez0ETu4oWSklrJRjCTtvrAeLv5Cs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cQKUOG3F9TXwOfU/OY7ib6lGOtFn0t9xErsdd/0shFGfZ4FoIszitqHshwAoEr2Fr
	 3MB/exSCvcxNDCAFbSj/2jVbWOHcPYxR/zmO1YgbdVltNl5PWlV4NtsyZo+J3zE/Bv
	 MU3KgoVC0uH5HqUnFpVG+QqPzoMSu4zdZY9TpjFd783+jqjpLnOvBLFVNIICC4Op2K
	 Tn9P18L5o/sP9d6Z/GuZwiDhE3enyzFpOIPBTzhdixInd7lCF+wT8NuGZy3wTG5ohO
	 0jrig5REGhcbpyNcY+Q2qOIel7p14eY+/WLyW9u/elEqhJET7Bwki5Pqb5ywDTxv/V
	 EhpzBUykxSj2w==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Igor Pylypiv <ipylypiv@google.com>
Cc: John Garry <john.garry@linux.dev>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261029184445.1615717-1-ipylypiv@google.com>
References: <20261029184445.1615717-1-ipylypiv@google.com>
Subject: Re: [PATCH] ata: libata-sata: allow re-enabling NCQ with the same
 queue_depth
Message-Id: <179361582895.1214002.12853176964658405598.b4-ty@kernel.org>
Date: Mon, 02 Nov 2026 11:37:08 +0100
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Thu, 29 Oct 2026 11:44:45 -0700, Igor Pylypiv wrote:
> When ata_eh_speed_down() disables NCQ due to excessive errors, it sets
> ATA_DFLAG_NCQ_OFF without changing sdev->queue_depth. Userspace can
> re-enable NCQ by writing a queue depth > 1 to the sysfs queue_depth
> attribute, which invokes ata_change_queue_depth() to clear
> ATA_DFLAG_NCQ_OFF.
> 
> However, ata_change_queue_depth() returns early if the requested
> queue_depth is equal to sdev->queue_depth before clearing
> ATA_DFLAG_NCQ_OFF. As a result, writing a different queue depth > 1
> re-enables NCQ, whereas writing the current sdev->queue_depth value
> leaves ATA_DFLAG_NCQ_OFF set.
> 
> [...]

Applied to libata/linux.git (for-7.4-fixes), thanks!

[1/1] ata: libata-sata: allow re-enabling NCQ with the same queue_depth
      https://git.kernel.org/libata/linux/c/d7c5cc8c

Kind regards,
Niklas

