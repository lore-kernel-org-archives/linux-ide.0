Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E720967E;
	Tue, 18 Mar 2025 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295648; cv=none; b=TMZpWyIydkZkRcLUIUdQePBJouoUfqUcaDZnl9ZW+A+6Zt7N50xKzH1CnKbf3Kcoa80UONUWWqZoIhI951krU++RDgaTYN3+uG2i34eoRQP6NDdmIFMc+Bbq8ozFZziwnPkCLXdc9fWULAT5vTiTB13HeO+mDlyUJgeBKOu+Tuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295648; c=relaxed/simple;
	bh=SSa1m9L33kjPcKtiIXG6xCneGSovTtn8WOFeg6y3sWg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZgfIJROAkiJSTThpN8zfSy1FEUiSw6BvJv3bwnjbGWXym5bTJs7R74Cy1CHkGT66p6WxTtYO1Hdkh6R6XLl5xbHdDyxttg/EmoepVeAvu11JkLOIa8uTVrPaf6vCA+67NoGZ7hj+/foY2s8+nu3dTBdbzeXFv9jgqCQw66kReh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcxPDd6H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcxPDd6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77FEC4CEDD;
	Tue, 18 Mar 2025 11:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742295647;
	bh=SSa1m9L33kjPcKtiIXG6xCneGSovTtn8WOFeg6y3sWg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HcxPDd6H86uoYCA1xj6Qi/ROzNfXRs8d5lPyfdh+Huvr0l0NL8y+vIXG/bVPkpO4L
	 dpOkwvpTuVrsaRJ8mSu/u5LeoGai1ZM+c0slqbElhWQ3kcZjhBZZ+ZQwPpfBwQSHN8
	 oB7fETK5Ufe+IsMOnBRtUjjrW9Nznzbc3PF4HvBNdhFHTiLLZQS+XIwGPBP5mu35wb
	 znLKkw1zIxjaTon+nbOOSwvpPXG883JLtZnsxnZS3/DDfer8dDkRc8frZYbBfEVGis
	 4stNO583M1BkatHixfTIdQq9g0U3H2+fyvRPyn+Ez+juDk1yFSZcxjO5LSjhW7OwzJ
	 7yhPWAIMNWhkw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-ide@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, 
 Xuerui Wang <kernel@xen0n.name>, Daniel Kral <d.kral@proxmox.com>, 
 linux-kernel@vger.kernel.org, Yuli Wang <wangyuli@uniontech.com>, 
 Jie Fan <fanjie@uniontech.com>, Erpeng Xu <xuerpeng@uniontech.com>
In-Reply-To: <20250318104314.2160526-1-chenhuacai@loongson.cn>
References: <20250318104314.2160526-1-chenhuacai@loongson.cn>
Subject: Re: [PATCH V4] ahci: Marvell 88SE9215 controllers prefer DMA for
 ATAPI
Message-Id: <174229564547.1892572.8787195454245116821.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 12:00:45 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 18 Mar 2025 18:43:14 +0800, Huacai Chen wrote:
> We use CD/DVD drives under Marvell 88SE9215 SATA controller on many
> Loongson-based machines. We found its PIO doesn't work well, and on the
> opposite its DMA seems work very well.
> 
> We don't know the detail of the 88SE9215 SATA controller, but we have
> tested different CD/DVD drives and they all have problems under 88SE9215
> (but they all work well under an Intel SATA controller). So, we consider
> this problem is bound to 88SE9215 SATA controller rather than bound to
> CD/DVD drives.
> 
> [...]

Applied to libata/linux.git (for-6.15), thanks!

[1/1] ahci: Marvell 88SE9215 controllers prefer DMA for ATAPI
      https://git.kernel.org/libata/linux/c/0507c777

Kind regards,
Niklas

