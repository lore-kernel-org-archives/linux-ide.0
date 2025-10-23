Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F154296BD6;
	Thu, 23 Oct 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222671; cv=none; b=apPL/q3B60DJOjQIg26CMh+cu+jMpbXIEzRf5zP/YzqFCvuv9aBSYOCFYnj5prwD36z4kl7I1ugSFrKzm/i2I+sHL7/kAv910ifR9ryLZlgw9JOQeQClrv1yvrdleucPSGtfG6kstaYwB3qvueUxvYevEVhHWCFsh/yH8TgjQ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222671; c=relaxed/simple;
	bh=PmhpuCjhCUNycDhDy5waYlo+6XThmo72eN6GQh6zcpc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XBJZTRe69ZMRv8S+UNXxLo3nN4MS70bgRVMVD5UYAJbSVMD3SOWV985Z1NKcFTQ5aJ/RBNbo1Dvbi2gSU2JH4Htigxu/icSgvIjw9kBwgn5nmDHhxI67RkWJ649umYZLKfKYzSRULmNVwWIehpZ8Coy3Udh+VfXiI0jyIhES+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsrcpLNr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsrcpLNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBDCC4CEE7;
	Thu, 23 Oct 2025 12:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761222670;
	bh=PmhpuCjhCUNycDhDy5waYlo+6XThmo72eN6GQh6zcpc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VsrcpLNruf2Fj5SE6/IT+viY+qViAjEyM2xXVNXjNNcTBynv1lyg/tedPkeFx9DWS
	 Rbe6ZwU4rZUl7kS290lGPerLRfXNKusBItLXhxmpLFqk+uqtPR62d/4dlZ1w4JaUgl
	 J9a0jdRtYJxYWKVwR7P1MgR+MhI7xTW4A/k+BtnC2sHIAjREuSVURrwc9hFNBw7s4w
	 WnWsMyHrojD76ARWxtxv9mSJoTwR9W0d1hUj9iQZIrhr/64C+E+wyLaw9tPGB2zVqs
	 5Vp53tpYkf2xddm8aAqdU6LtFbaPA+y1Ju7tvqBiFq2pkrn5mWQN4+RR6n7bLcJZdw
	 DW3SNwLYf2J8w==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Serge Semin <fancer.lancer@gmail.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251022230422.423230-1-robh@kernel.org>
References: <20251022230422.423230-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: ata: snps,dwc-ahci: Allow 'iommus'
 property
Message-Id: <176122266879.892391.6316731839247267203.b4-ty@kernel.org>
Date: Thu, 23 Oct 2025 14:31:08 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 22 Oct 2025 18:04:21 -0500, Rob Herring (Arm) wrote:
> The AMD Seattle DWC AHCI is behind an IOMMU and has 1-3 entries, so add
> the 'iommus' property. There's not a specific compatible, so we can't
> limit it to Seattle.
> 
> 

Applied to libata/linux.git (for-6.19), thanks!

[1/1] dt-bindings: ata: snps,dwc-ahci: Allow 'iommus' property
      https://git.kernel.org/libata/linux/c/095d495c

Kind regards,
Niklas

