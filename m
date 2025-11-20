Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B331030C62F;
	Thu, 20 Nov 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640973; cv=none; b=W64g2en0d6O3Y8q5hthyO0g45gFNbC9MKWjcBuI3ydeIGwa6Vl3yVC6CXz/aICVDDqYDKdwBHkdb3g9LHooluH/03eGm+eApFaQYDwrsTvn1FXGcfurOyCPmJsUAUyP2Zx3AnHJPidJZvxwtWQQO3xMlTfLTaS5KluAalW87tw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640973; c=relaxed/simple;
	bh=TbB8C/nXTcBdA1LIVbIxQn31U7+wGWg8doD7RYqHeDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nbqvRU1wN/WqpRXwlzgafQOvt5OfCTTp+3GME4+qZQD3ny7uO7Dp6tksgW2P2fdwIKOZr/Du++9EIifpDAmz6RosahE0kcniF0N0vxN509nao7gQXpXwLWrA1OkIEYDQT3akVhOLnos/C9sUNDFxUruBQ/pb5swIpEK1UgnyAFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3WSXiLD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3WSXiLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0976C4CEF1;
	Thu, 20 Nov 2025 12:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763640972;
	bh=TbB8C/nXTcBdA1LIVbIxQn31U7+wGWg8doD7RYqHeDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z3WSXiLD4UpjEfMpcp6BfQVVsUdQ4vibxgXh04iSLUq2bU1rLVj3HNIJZ5SmCJ6mB
	 y1w3GUEEcYzWqixeWOxMLUnMxkjU7Q7XkZ7+E5qIGL7lNRetq2ce+MdaxzfMokCfnI
	 BZUMLtRQxDDwBN1qYCOQqhXN4l+shera0O0Vp6vFUZu/gShSGRO2h6aq1GkmhHvET3
	 QEXceYy7BQYtThjJ0LTy0oLU1koCAQ6hJF/1QXlh7/TizVsaKFjSCoMOUHyzU1IfG8
	 yVENY2s2wIL11AYTViShq+gbD6PFC2mm79BETVwK5mV1SOyY2ylmwBsQ48HxVRFn0r
	 ELie67+AJBcyg==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, martin.petersen@oracle.com, 
 Yihang Li <liyihang9@h-partners.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 liuyonglong@huawei.com
In-Reply-To: <20251120035023.1256818-1-liyihang9@h-partners.com>
References: <20251120035023.1256818-1-liyihang9@h-partners.com>
Subject: Re: [PATCH] ata: libata-scsi: Add missing scsi_device_put() in
 ata_scsi_dev_rescan()
Message-Id: <176364097070.2427861.3665803899639564663.b4-ty@kernel.org>
Date: Thu, 20 Nov 2025 13:16:10 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 20 Nov 2025 11:50:23 +0800, Yihang Li wrote:
> Call scsi_device_put() in ata_scsi_dev_rescan() if the device or its
> queue are not running.
> 
> 

Applied to libata/linux.git (for-6.18-fixes), thanks!

[1/1] ata: libata-scsi: Add missing scsi_device_put() in ata_scsi_dev_rescan()
      https://git.kernel.org/libata/linux/c/b32cc17d

Kind regards,
Niklas

