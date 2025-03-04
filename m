Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B027CCFA;
	Tue,  4 Mar 2025 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112601; cv=none; b=ryQOO2tNn4JH+CvfJw8LmCE37jwv0DdYv5Py6cihTfHlhdmbHYMBLOwYn4ZvIJ0mvXPOgJbJvpBrEwLIz6OLVP0iC/MfRkbTszUC0Gbgk9Ch5Kbe89vYZEQVJRhIeyRe18Et4mJtmGabVPj8RURWR35GArmTxgrUeVguhjoDt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112601; c=relaxed/simple;
	bh=yqSfurqo9uz0GCjH+gfSO/8lIK5tXDomfIJ4KbPJeF0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RX5oNaMqWUiR/zRPOZS9QxY1/160ryVmjGMSSL2njSgiJlaUNStsvYVyDMtp700os2DIK45YVIF6d7cmqQC/p8ysQ7UBWb90Equg7BBIqrjzgq4QoGvVrWzPOf2XMHNnXBjVWjZSQRGEiKM887/v196supEFxkROiiKJs/IIFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dasi1DrL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dasi1DrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8166C4CEE5;
	Tue,  4 Mar 2025 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741112599;
	bh=yqSfurqo9uz0GCjH+gfSO/8lIK5tXDomfIJ4KbPJeF0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dasi1DrLByD/0irFoemo5gkRbMbNLub054uhf7FbhUymKZb759Oou7hBYnUuGON7F
	 JMyzIpHAVV1KVJoTfBUe0nOxc7aRbXwcLV92BcoDSSCNLyjGv8VnVNJsDb/Slv5pP2
	 T4LcLIB3peAls+r4aDM4IxgOJcJTdCqg7yV11q2BN864crpZK/VZg9KC3Ilwy3m/8E
	 bcA6SdJKAdiXl6O+LC9Vd4TGiBZ+y8i+sgVMBGWE63IqmqzeWqmrBD5eUtam8zg52H
	 hAfyoK69ihCNTVKp/7T07X8fczA0QXP0OPZsXI3phVc0zUjBVKNzPgumcciq6qnMEq
	 rQXrpJ3YgrLuA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Daniel Kral <d.kral@proxmox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304092030.37108-1-d.kral@proxmox.com>
References: <20250304092030.37108-1-d.kral@proxmox.com>
Subject: Re: [PATCH] ahci: add PCI ID for Marvell 88SE9215 SATA Controller
Message-Id: <174111259844.42927.10776968712314293712.b4-ty@kernel.org>
Date: Tue, 04 Mar 2025 19:23:18 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 04 Mar 2025 10:20:30 +0100, Daniel Kral wrote:
> Add support for Marvell Technology Group Ltd. 88SE9215 SATA 6 Gb/s
> controller, which is e.g. used in the DAWICONTROL DC-614e RAID bus
> controller and was not automatically recognized before.
> 
> Tested with a DAWICONTROL DC-614e RAID bus controller.
> 
> 
> [...]

Applied to libata/linux.git (for-6.15), thanks!

[1/1] ahci: add PCI ID for Marvell 88SE9215 SATA Controller
      https://git.kernel.org/libata/linux/c/885251dc

Kind regards,
Niklas

