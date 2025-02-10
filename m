Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578E1DE896
	for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2025 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184941; cv=none; b=pIU23tlQm7P5tA1H+XdokQk5F31g0HuAUQTkVEjJ3aI44AaKkxIH1qA1Z4oe3u4pRjHQpY5lwjW1+h+OTE6HUZjofoKgQf7wcAyGpqoKPWf6GFoUtEFxZ3M1rOLsO4+SF6pCY4J/GUYQH2wJHv4RWi0e8lp4z+3Rp38X0Q5Jl3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184941; c=relaxed/simple;
	bh=i3DTD4sctXaiZmr4uckXSsxm+pRZkt9g8Kb+PeTUCag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cxNEVh3vbrqdfsypuBDnv4APIAipSGQj25uaYGX6zoYPDYjwtYN+k8jn8trX4YAVL+b5rfJCOazhpDb7D+P/Rmt/X239DQUJlzN5TtRWQdKVhgw7RLbNj/3mEPjoyjlhmBQhP+eqeO15KGzI4J0jAAZPcZauE9eXonkNRkwOeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNBczPlT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNBczPlT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C632C4CEE6;
	Mon, 10 Feb 2025 10:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739184940;
	bh=i3DTD4sctXaiZmr4uckXSsxm+pRZkt9g8Kb+PeTUCag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fNBczPlTyErarIdNMFGmEB8Rd5+wsm2GUR5tvQzt7OXjOIz9AQYREd9KPxkB6/fiY
	 taA7f/symXRT2kbt3CuYlYkMLBmbkrgELu0zMKB+jTkzi93wzSlgVPYoUcrz3RChvC
	 i8RdYpq8EOUgQtRmePu0IvDPqZR7a2rCEaYz+jQVmK0dl6awhfh23SKRDMELFpMVUq
	 H/kG2jj1bZPPb7D0f0f7zzQN+Q31v9j85Y17OOoOOrW17ZtcYS29wIGj6MYiCKNsZx
	 Mjjknc1RII1jAx8em38FG6i0fpK5+UeFWnJEh7sZ6Ovq2ZOXbUWn/C8C7M6/R9zrtq
	 J251VqodWBKIA==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>, 
 Josua Mayer <josua@solid-run.com>
In-Reply-To: <20250207232915.1439174-1-dlemoal@kernel.org>
References: <20250207232915.1439174-1-dlemoal@kernel.org>
Subject: Re: [PATCH v2] ata: libahci_platform: Do not set mask_port_map
 when not needed
Message-Id: <173918493985.2578640.12685608031355933376.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 11:55:39 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sat, 08 Feb 2025 08:29:15 +0900, Damien Le Moal wrote:
> Commit 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive
> port numbers") modified ahci_platform_get_resources() to allow
> identifying the ports of a controller that are defined as child nodes of
> the controller node in order to support non-consecutive port numbers (as
> defined by the platform device tree).
> 
> However, this commit also erroneously sets bit 0 of
> hpriv->mask_port_map when the platform devices tree does not define port
> child nodes, to match the fact that the temporary default number of
> ports used in that case is 1 (which is also consistent with the fact
> that only index 0 of hpriv->phys[] is initialized with the call to
> ahci_platform_get_phy(). But doing so causes ahci_platform_init_host()
> to initialize and probe only the first port, even if this function
> determines that the controller has in fact multiple ports using the
> capability register of the controller (through a call to
> ahci_nr_ports()). This can be seen with the ahci_mvebu driver (Armada
> 385 SoC) with the second port declared as "dummy":
> 
> [...]

Applied to libata/linux.git (for-6.14), thanks!

[1/1] ata: libahci_platform: Do not set mask_port_map when not needed
      https://git.kernel.org/libata/linux/c/2c202e6c

Kind regards,
Niklas

