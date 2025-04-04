Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC11F4CAC;
	Fri,  4 Apr 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743767832; cv=none; b=UlyaCYWx/w4UpPrUmgWUhkbZHMgLalNlI0XRKWbXXvrU+KvospncAS8HhSrcimsij4TUuhxOlc7qlzI89KezC9SF80gR8axzckyXRzhP60pk7MaqVBRBE7K9mpv0QyBOzhOXXqB/v3HtK09HFzD+d5Pxn88nUpmPzW77Id7QLp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743767832; c=relaxed/simple;
	bh=BRsxHxbdXO9H4hrIDr4a0Voxf96eev/u4BqcAGG2K5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaMcBRxEu0jDHMGP2WJKV5le8oj70Gp0o1EkUPGnLdpU5KU89w1UogPVjZ1gEri2QXdp6/Afq83OSIqAiY9Qdc0ZRcsJikJhvh/gvIIE2d+LHG3j+7ILiqwxygjX6+y06kqkVuXIoW4SctwEhXgV1djLIbg1e0ry5Nm5q2d1SD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWSu+Lx6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWSu+Lx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF885C4CEEA;
	Fri,  4 Apr 2025 11:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743767830;
	bh=BRsxHxbdXO9H4hrIDr4a0Voxf96eev/u4BqcAGG2K5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWSu+Lx6GPaJdh4AJTHhi9cjShMzC6EzTgtSESExuJfOiuYrc1SzVdIzKQPoOemJH
	 Q+PfcjgwA8nHIW2oh1da+X8oqsOn1IyFW0phgGUcQrYLBDYMawonOCGXqUCQABW4P9
	 IPMxQfPjb8SaFiRDBPOGOHoqtL3ef4DUnNov4a1VZ8ACIavJftUFwkwxr5TmHkdSxL
	 nNhveGcA2Qfhmh0sHFzIz++mox+X6JinHWHIQlZ37q8C3l7WABFLe0yillZYXMdsXd
	 rv0w3qTucadosK0EFb4B5qLgkg20An4C6m2KnxfF0icKVVIqNjPOQReJQz+UinjlVW
	 H+bbLx5F2t79Q==
Date: Fri, 4 Apr 2025 13:57:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-scsi: Set INFORMATION sense data field
 consistently
Message-ID: <Z-_JExGDyO9pVTON@ryzen>
References: <20250403212924.306782-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403212924.306782-1-ipylypiv@google.com>

Hello Igor,


I'm missing the bigger picture here.

Are we violating the spec? If so, please reference a specific
section in the specs.

From SPC-7:
"""
The contents of the INFORMATION field are device type or command specific
and are defined in a command standard. See 4.4.4 for device server
requirements regarding how values are returned in the INFORMATION field.
"""

Looking at SBC-5, "4.18.1 Error reporting overview":

"""
If a command attempts to access or reference an invalid LBA, then the device
server shall report the first invalid LBA (e.g., lowest numbered LBA) in the
INFORMATION field of the sense data (see SPC-6). If a recovered read error is
reported, then the device server shall report the last LBA (e.g., highest
numbered LBA) on which a recovered read error occurred for the command in the
INFORMATION field of the sense data.
"""

Since we are generating this, it makes me thing that perhaps we should not
set the INFORMATION field unconditionally? I guess it makes sense for e.g.
REQ_OP_READ/READ_OP_WRITE commands, but probably does not make sense for e.g.
REQ_OP_FLUSH commands?


On Thu, Apr 03, 2025 at 02:29:24PM -0700, Igor Pylypiv wrote:
> The INFORMATION field is not set when sense data is obtained using
> ata_eh_request_sense(). Move the ata_scsi_set_sense_information() call
> to ata_scsi_qc_complete() to consistently set the INFORMATION field
> regardless of the way how the sense data is obtained.

As you know, we also have successful commands with sense data
(CDL policy 0xD), see ata_eh_get_success_sense().

These commands will either fetch sense data using
ata_eh_get_ncq_success_sense() or using ata_eh_get_non_ncq_success_sense()
(the latter function will fetch sense data using ata_eh_request_sense()).

Regardless of the path taken, these commands will also end up in
ata_scsi_qc_complete(), so perhaps it is not enough for your patch to
modify ata_scsi_qc_complete() to simply set the INFORMATION field for
commands with ATA_ERR bit set (is_error) ? Perhaps you should also
consider commands with sense data (have_sense), but without is_error set?


> 
> This call should be limited to regular commands only, as the INFORMATION
> field is populated with different data for ATA PASS-THROUGH commands.

I do agree that for ATA PASS-THROUGH commands with fixed format sense,
the INFORMATION field is already defined by SAT.

However, what about ATA PASS-THROUGH commands with descriptor format sense?

ATA Status Return sense data descriptor, which is used by ATA PASS-THROUGH
commands has descriptor type 09h.

Information sense data descriptor has descriptor type 00h.
(See 4.4.2.2 Information sense data descriptor in SPC-7.)

Is it perhaps possible for a command to have both descriptors?

After reading SPC-7, "Table 30 – DESCRIPTOR TYPE field"

I would say that is appears that you usually just have one descriptor,
so I would say let's continue only having the ATA Status Return sense
data descriptor for ATA PASS-THOUGH commands.


Kind regards,
Niklas
