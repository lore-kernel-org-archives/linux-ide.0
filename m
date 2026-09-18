Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93053AAF73;
	Fri, 18 Sep 2026 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718334; cv=none; b=hqVYQtvc+VltVfKkD/2pG9tBVOFZtHGSxe/yrd8mbtMvR9MmvuWSAkkLqH0oh/oW+8h8kVrsXyX6GqQQAeDEYxgDzH0gspezOa74wgL718Y6CG83Wh1Kr4MgHFenZHoKEtcHP7WEhuxzT7mWrBd38VEo0lX5tI/FhL0As0L4HJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718334; c=relaxed/simple;
	bh=Igi7RpX3s8wpqS9V7Oma50tXPZG3sw54e/gHfnUH758=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j7FQq2fZpGKtoGZ72hpNiF2+Wh39luZD9rwMTlHPheSRmdEnAVUnL/Byf26bhuM78fSCZ3M7N14XIzrttYuDh6mwbX2nfKJ44+JlL0fyl2ekq3tkc4Cs9cUJboEdz1S8XvDvfRuK3Ye5ED3K40E/kOgZIvlMbfUFIOAMwE7DYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7/mHyhK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7/mHyhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77691F000FF;
	Fri, 18 Sep 2026 07:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789718333;
	bh=Q3ejOphYYSM4uRMQTnR6thuWZgw43ZOsLUV0/ktNv/4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Q7/mHyhKPmSZAqH1lDxRJ2/aUdYXR7gvS/edPZvkAsQ0HO/Pt8DfLcJaQ2eb9yzhm
	 umze3neepb5H3HwzOgHskPuiaYvPIJZpHJncpcW31cHoxC5d2FFtG+V7SYqnWPGw8J
	 45/PAv07gncuzjC24PEW8K3G8izpp6/X0d1/VtEWRGUjXbsfCA9dRh+TTVeSMF8mdc
	 CwQGlro2RQf0ElwnQhjSKQM0B38C8wqq728Iqn84mSTfsq07WbNP/HUxCgeDWJScXd
	 fNKumu4tCd1PSYtJbE53/5s4qUDXwEcOLTMsjT7Rj8bnlQa48J5KYWoENpEIwwsugf
	 U40Mgn+wj2WNA==
From: Niklas Cassel <cassel@kernel.org>
To: Viresh Kumar <vireshk@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260917190315.1188379-1-Frank.Li@oss.nxp.com>
References: <20260917190315.1188379-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH 1/1] ata: pata_arasan_cf: use standard DMA engine API
Message-Id: <178971833153.1764044.3036607269875886410.b4-ty@kernel.org>
Date: Fri, 18 Sep 2026 09:58:51 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Thu, 17 Sep 2026 15:03:14 -0400, Frank.Li@oss.nxp.com wrote:
> DMA engine consumers must not call the channel's callback function pointers
> directly. Use the standard dmaengine wrapper APIs instead.
> 
> 

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: pata_arasan_cf: use standard DMA engine API
      https://git.kernel.org/libata/linux/c/a51e0770

Kind regards,
Niklas

