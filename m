Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA823506E;
	Mon, 14 Jul 2025 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477903; cv=none; b=AvDNmVtcP/cphXLy3Nmoy5G3/qnj6T2FVxsvZA0Mumf+VG6VG4g/KeaEtHMAeGVdWmqThyAMbuyfqGzOZluo5zU2LrYWoej3qSznoi+u9eB9OhGjrrsrCIwlv4aoET5S3XAbL6g4bnd/48AargUc+iwegyUKjaXH6IB/PcCJssA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477903; c=relaxed/simple;
	bh=NKXaOKo2AgS4yU21xtY04l5Dv95iMndWjDu3zIwvr5M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qaTwnb03GAi8lpN7gMzOkz4M5QnGu/PoDxOwxroE+XMhC2p+q4CoHCE0lOmMVj/aHRTmJ2rnPP6sD93jumJm1vB72tNZSVl2duvSSaITZer0h1Qqc6GDnwSD/NTANoa6wQmv16knHpn+hQsjPr0cbQ72UNmvknrWs4PV8XVTXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdGW2GFY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdGW2GFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78577C4CEED;
	Mon, 14 Jul 2025 07:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752477903;
	bh=NKXaOKo2AgS4yU21xtY04l5Dv95iMndWjDu3zIwvr5M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jdGW2GFYZrbBrZ7IxBf6Fhw+iyIIghkw2XQvB9FQ4doKlSXJsWRWDThG0GW79wdDI
	 AU8dGJ05uKUufO1V12uZ5hRxV6LN1KqcJz7RYLKgFgxRPou50YiuH13SrthdgYZTOD
	 g47QGID7PPX6LFcfzLdzc2Z9/6usXZDWkTXO6Sxp2Wq5oKn+No5PkFJZRZpFBBzKma
	 BfjAphRFKLXJzC9wRDF5oJvo9VFK0lD9PdAJ0NHHF20NXVrZ9EAUIgz80tIVwnbNR/
	 j8QhKH0jl76Fz1os7CuvoCik+GrZP4FN3fi1dohcIaCD6Gps6O0g3nJ1lFilkCN1XJ
	 vZd6kYl7r5Itg==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20250711113650.1475307-1-andriy.shevchenko@linux.intel.com>
References: <20250711113650.1475307-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] pata_rdc: Use registered definition for the RDC
 vendor
Message-Id: <175247790222.1994830.10965267044601590862.b4-ty@kernel.org>
Date: Mon, 14 Jul 2025 09:25:02 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 11 Jul 2025 14:36:50 +0300, Andy Shevchenko wrote:
> Convert to PCI_VDEVICE() and use registered definition for RDC vendor
> from pci_ids.h.
> 
> 

Applied to libata/linux.git (for-6.17), thanks!

[1/1] pata_rdc: Use registered definition for the RDC vendor
      https://git.kernel.org/libata/linux/c/148fbaf5

Kind regards,
Niklas

