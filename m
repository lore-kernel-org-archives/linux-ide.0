Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B9F3E5EEB
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873610; cv=none; b=Zbkpp7j8XtDb8QOL5/U3Il53XDpKAS2gtQVDHpoik0G9AqYM6YOS6xdqoHge2h0N63D+MBQdXvake87dN6ANNtLqrPI60umv3gyBBHmR44NIjvNjrcLON1tba0gwVkk9FCZuPYpJomqOCxkx2skndZLC78a3Nb1gxsOVOrM3pko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873610; c=relaxed/simple;
	bh=zgKqI7KZARDsZTvoHB3tZuWM2fJMKVJxwbGocXZP334=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=diW+AAsEoXnye92dePywoZ8+0hZMizgKAwdMZmxlpJpTuRk0/taGueju2gYX1hfNx/UQPRb1U0xYZ6Mmzftk1B0gi/+Qwk7F5bFK60qxPHQ6TmUQSNQLQVQI5pH/yYVLJa6ekFbioV9jd7ZnDeuH7YMIDXxtOKUKalGADSb8rWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C90P1ZSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C90P1ZSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1DE1F000E9;
	Wed, 27 May 2026 09:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779873608;
	bh=enK2rB8fc+jvubPIWX8m1FORXpA9N/7pnNGUL8OXorA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=C90P1ZStwF5Nd2sh9FrO4nQGw/AIbfN815V0DQjGXj+ihQhKfxmkRydzcLp3UoeNX
	 JhJRNaGrG9Nru+kzTmrFXeouii5MS5iMIpBkUC0b2MdJpuYTMkr5s0Z5mjR8eU46Ed
	 dudo5we3vj8qGLCrQ2hJwb2vZuiR8K7vp/f5gnD0Na47Xmq1eQz7WZt0jdO4e8bFbC
	 0Y4r8yn0D2z2h7xIc8LMVZLzYI6eXAdxmgrU8EPgLaHUxN4Zn3g61q+vOpHQkit3BN
	 4V4oOD/gkCworjEsl8P2eGsfGvu+swr0uQgzLtCJ3+Xfh2DFD9EZ7cA/8v3vy24Mfz
	 V1AK7HbSpAKuQ==
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
 Marco Elver <elver@google.com>
In-Reply-To: <20260521173347.2079560-1-bvanassche@acm.org>
References: <20260521173347.2079560-1-bvanassche@acm.org>
Subject: Re: (subset) [PATCH v2 0/9] ata: libata-core: Enable context
 analysis
Message-Id: <177987360731.213219.9853747215937352347.b4-ty@b4>
Date: Wed, 27 May 2026 11:20:07 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 21 May 2026 10:33:28 -0700, Bart Van Assche wrote:
> This patch series enables context analysis for the ATA subsystem. Please
> consider this patch series for the next merge window.
> 
> Thanks,
> 
> Bart.
> 
> [...]

Applied to libata/linux.git (for-next), thanks!

[1/9] ata: libata: Fix ata_exec_internal()
      https://git.kernel.org/libata/linux/c/6e0ce123

Kind regards,
Niklas

