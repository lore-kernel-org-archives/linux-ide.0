Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8254D09EE;
	Fri,  9 Oct 2026 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545881; cv=none; b=DJLCUO2TQ+jvnXVxnvcz1DW3OTLu3Ds1s203W1eMl9Zo0TrXxCKeMm424r3ihl7K/BwhWSc7WZ97Yr55jeBehR8aias+8J7cnxjHwx5vRK2ioCZqHt8VROI8b/NoOC3LhhfFaPmAVNYOuqYgJzz2sbfizq/6Oxwp4GopPYZH6/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545881; c=relaxed/simple;
	bh=bX4RnEdEHzcF9Ak1LNLvO9Q6kG2eSZgKjBPLX5BRS68=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=awkW8utRLrHHT2yp4N8Ac5IVoArkdnVpf/g+ayDZcT+mEPpUhAmHm/SpAqET0AIl2a6DeSbtO0O0EjUVsVmZlzUl7QaWiNcNXmRJh46Y9+AZtLgcHTMm+PQm31qVxhgDufg+Fh7v8YSt7A2W/iviMvZAD2HdUgdrqIR7SHUb880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+pI9+q4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+pI9+q4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162031F00893;
	Fri,  9 Oct 2026 11:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791545873;
	bh=Lz0QNNVkCBjI2roQNHHnUITOySBplOMgstYwDKqKaf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=W+pI9+q4rv4wkXxqzASs4KTKu079txcuTFO+D4QAkNKGCU0X3yJKuxQahwLLqqrF5
	 AJEZegrrAIMzqny4Tpa6Zg3F1+RWctb/7mypKYDf+5TNz8Ms9kt/tFU0zPU2mEAQYw
	 v7DnlEXy1d1ya1y4YcJ+UGuaCRav3LHEFHzNoShZhbhhK9slWwGNb+IhXRueY2qmUw
	 HyuazU360hZoLIdrNP8Fewb0SG4ttunisA5go2xf7NNjYPToH+qq8K6pXRVSRRCsgB
	 omGt587rS0765MIhteL7zM43tjgjFc8Qvczx/hJxhY7EIDRDDQBbdkwC2d+90Ya9Ip
	 SAIKEv4mNbSVA==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, Carlos Junior <cjuniorfox@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260928133040.222155-1-cjuniorfox@gmail.com>
References: <20260925193134.114566-1-cjuniorfox@gmail.com>
 <20260928133040.222155-1-cjuniorfox@gmail.com>
Subject: Re: [PATCH v3] ata: sata_mv: enable SoC SATA LED presence
 indication
Message-Id: <179154587281.2779738.1312476137771592969.b4-ty@kernel.org>
Date: Fri, 09 Oct 2026 13:37:52 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 28 Sep 2026 10:28:18 -0300, Carlos Junior wrote:
> Enable the SoC SATA LED controller in mv_soc_enable_leds().
> 
> Set the LED controller enable and device presence multiplexing bits
> in the SoC SATA host-controller register. This enables SATA device
> presence indication on boards using the SoC SATA controller.
> 
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: sata_mv: enable SoC SATA LED presence indication
      https://git.kernel.org/libata/linux/c/f658c7bd

Kind regards,
Niklas

