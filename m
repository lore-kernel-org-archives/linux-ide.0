Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8799234165B;
	Thu, 28 May 2026 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951365; cv=none; b=TBxg87cxwSgmEsENf/egWtGhDiduiIT/xUdmGaoakXlnTROw++5NtoUThMIjot6+CBfYY4GpW30VFNYaKfZGWOLj/ziM+VlttO3d/lJV6ocm8KDS33fm8o/ZR2CQhonOn+1FQnvAbgoaLyE2Zb5FHfWdr7ZKP13+oWb8wbx69fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951365; c=relaxed/simple;
	bh=uJ+HQ7V/+C+cAOdydUF71Yg25Z6rrh7G0LHSYcD8hD8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vCIHGZLVXmzuNJHxW485vi58JLmwYQsvqNWJPbkKof8FeW/u9iXqp1VwUMBXRNQHHBc477/cwog3c5kR1YoHmVIVPfguXQxqvFkziJWUZtb83pS9LF5CsCiYCN5IHd6nsXxh4O5cPn0buOqTws5CYXFNuJTjh+MQwih0LZaDrrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkvtuPyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkvtuPyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131991F000E9;
	Thu, 28 May 2026 06:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779951364;
	bh=z1J8bjUamiyHx6Gc6jo+FiUg6o/Mmg1AvsR94h+1eIs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gkvtuPyK/o2RYALDch06etjKOr1yRf8WGwcucB79gwdKVAk0uX2wHkTD5c2ZBJT2j
	 jewCxizVeTBuMPUgCf1AJkxZqU6WIdwPXYrfQ+/17Tf2mHdTwBtGbt3VPH6j+nqTCs
	 tWzLBQC4k3/d66mQW60xbH5hm/8FHTgqvMOOtRWHofSl0fbVGyLWBDO52pA6cNju5z
	 PKb4kVl+m4Drqm5AIEan1Oy8ef1EL1tFce6ot2qcba3XiFHixOFn5bHY37JJjkjIrH
	 aSI2989F9xLQSjQEkbb80ic5tx4Q/WOAcJOKHTUL4+YIoBNXiqatN3a1xyxJ4EWzMF
	 5KdlN6dFuhU8A==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, kensanya@163.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 TanZheng <tanzheng@kylinos.cn>
In-Reply-To: <20260528060050.743599-1-kensanya@163.com>
References: <20260528060050.743599-1-kensanya@163.com>
Subject: Re: [PATCH v2] ata: ahci: use hweight_long() to count port_map
 bits
Message-Id: <177995136280.288718.5597174085504112495.b4-ty@b4>
Date: Thu, 28 May 2026 08:56:02 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 28 May 2026 14:00:50 +0800, kensanya@163.com wrote:
> Replace the open loop used to calculate the number of set bits
> in the port mapping with the `hweight_long()` function, which
> simplifies the code without altering its functionality.

Applied to libata/linux.git (for-next), thanks!

[1/1] ata: ahci: use hweight_long() to count port_map bits
      https://git.kernel.org/libata/linux/c/b7ed008e

Kind regards,
Niklas

