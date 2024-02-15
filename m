Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080741E4AE
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2024 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036498; cv=none; b=TSdqb78HqVXIOA2AzEVqhQNcymvd69dBU3vu3RCYb/IDDU6CeA473PbsorVB0OwhhGJ7/DaHvb0uTxN3c3QVMdaDBZ0XEJN2Pl0yUZW7ADYotjQZjU1UMlLI2QpzfYcEXlLxSHmuW4U5OPqHw+Vm4kG4QmPdm6ZFZ1hCkmNyzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036498; c=relaxed/simple;
	bh=riFT2YKUMAYv3ekgkLRSZtcU58kzTFzfAWYRIENzgBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ugIM5y5/P9KqqCRHNUAU9TOErJu1ZIknq1QkaS0OETY0VyjY8fpSAukIONlYWSljJ4mFL4D9qvT7Z4B0c6/Io3qQeZE15d6O+G7YfntO72EasR+IxyEcJHPA2y7AvGepX+uE0Bhi3bfM6J4VuRmP9D7aZOp2vK+NA1pNN3rMASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlH1S/0l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlH1S/0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4E5C433F1;
	Thu, 15 Feb 2024 22:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708036497;
	bh=riFT2YKUMAYv3ekgkLRSZtcU58kzTFzfAWYRIENzgBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YlH1S/0lJSS1tw4L2afkJoHJDXtwgPDioBppPQwF5ZEmn1OGck0mCk9n1Q5TQN/1J
	 VupomMikxQMftEuVSM1n40R9msQt/7YFs+cc88fEnzg4t1PHAtJ4zV1J+jSxieooNu
	 RFSzzEUfHXu/a2kvtA1yZAShVjt57FE/qoV8gy15kP2g+kpXN8e/KaYP4/b+TrBxHo
	 HL0WzihyBv79AZ5nqwoRBulEE4MrHjUUWPJEnHeK/EWDlC0gfLbNp5Qcg33dKyIiL6
	 kpcErn3WrfpouNKRANe6FZAxHvBn0ub6Zf5WQeNPOUcrrLUTGJ8DgdYUFcDCX9mSuT
	 YAmoUgyVcSDjA==
Message-ID: <22931923-c0dc-43dc-8fc9-c6d7ee6f4252@kernel.org>
Date: Fri, 16 Feb 2024 07:34:55 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] ahci: clean up ahci_broken_devslp quirk
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org
References: <20240214130015.952685-1-cassel@kernel.org>
 <20240214130015.952685-3-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240214130015.952685-3-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/24 22:00, Niklas Cassel wrote:
> Most quirks are applied using a specific board type board_ahci_no*
> (e.g. board_ahci_nomsi, board_ahci_noncq), which then sets a flag
> representing the specific quirk.
> 
> ahci_pci_tbl (which is the table of all supported PCI devices), then
> uses that board type for the PCI vendor and device IDs which need to
> be quirked.
> 
> The ahci_broken_devslp quirk is not implemented in this standard way.
> 
> Modify the ahci_broken_devslp quirk to be implemented like the other
> quirks. This way, we will not have the same PCI device and vendor ID
> scattered over ahci.c. It will simply be defined in a single location.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

