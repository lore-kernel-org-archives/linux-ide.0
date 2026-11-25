Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604431;
	b=OH8N7yzPfIqmebeNCHawciH4U64ivnjFv5Yci4sU4/pZPRGz6Y9AGyeMZqKSxOednmOi
	 F8jVf/ptTJp4r6ddD0XdOqTGG58y4UXf9nzXP3nuLCgLbID3P+S0L2CjVbnFstzWfRrPg
	 iFEPAc4j39WQBcZaA99QTcM9yREF77V8Pv2cO6OzTbtu4RPTtx1UUZMHRO6CIdfu+kkwm
	 Z/1UFzwgfVnnCq2zLhqu6LzkTQmi4Aa47UiwdYg/Ir4jITN1q5tCIjFmmhu/7Po87PRTG
	 +xF/u2VIRUhy7648CkaJ8oBL9ga5I9r4v5+/F59NgByG8BGtWMknZatXCYpXn2LIEuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604431;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2ANnb016hMJh6qTFRYYIrUt6Een3ux4YwmZrDiFyqtQ=;
	b=F4+oC/lRRtEq8F0aVAo8p9c/r5x9ZCoMxJavSTUZc+Uaw3YjWl/hzixpwVtQ28E3UOvn
	 myxqpW1FmI93h5spZdcev/i3rhvC4fAMIls0cQRywgMA222+fG/pA7zqFohhzAK8u5lxv
	 cMRStK3pLvjT/1kuzzD4CX7GNf6qd5pwh+aMQafbPO0DH1xwbENbtyWZ146x6Y8mrmrWJ
	 TsHEz/wGTXWzA0d65OIDp7fQ/ZsdgbxOOcXE6h6fosKx1V1DPjoQwLkBFAzWMUvtdl4+/
	 fHXw6DKqk57XcI5BD+r88bCROvNMLidtllJV73S+xHFfT+VRzNcB9+7NDsceCdMDCZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l9FKE/ar";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E67606A335;
	Wed, 25 Nov 2026 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l9FKE/ar
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE301F000EF;
	Wed, 25 Nov 2026 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795604431;
	bh=2ANnb016hMJh6qTFRYYIrUt6Een3ux4YwmZrDiFyqtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l9FKE/arL63gUupbjkNXJJKo1Js7K7UNY+HIzsDwm/8gBs+h3D655aXU2wmfve6NM
	 0lEP3OCYgsr6dmFy5uo+C1ONY8FUJCuPUqRdlS9YrmvQTYDtDu/kFwYFfjK+0fNRwO
	 Myf/sxku9fzNEwb3sSPOUp0DES8XRiwRZxJhwoIlwdptDtLAmZfYeAzifrkApC6xY8
	 woxzsMgZDBwVn1YkVX0FIj3U1PYmeXeAQRfovYmXUE0EHjAukK8a1caqiDs87z3r8j
	 v48zaFLzEgwTMQtBUq2ksJvhzwu/f8eWqVpb0lpIY6VNZxyiAICluFJEvNlLzAUsqn
	 Y3AAklTis7trQ==
Date: Wed, 25 Nov 2026 12:00:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Pe3k <pe3cek@gmail.com>
Cc: iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: iommu/vt-d: data corruption, AHCI gets IOVAs inside its RMRR (HP
 Gen8)
Message-ID: <awa_ys0XSt9UwAZE@ryzen>
References: <CAGvcwsDdKSZe0reeuT0eQabaSbM6+KAfwFimxiqhvKrjD2nQeg@mail.gmail.com>
 <awX_cNOqtTjAP33a@ryzen>
 <CAGvcwsDwi9vNcCLxdBz-Arx=5i-fFvqxP+QbRKrx7hK4yqmvRg@mail.gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGvcwsDwi9vNcCLxdBz-Arx=5i-fFvqxP+QbRKrx7hK4yqmvRg@mail.gmail.com>

On Wed, Nov 25, 2026 at 11:01:17AM +0100, Pe3k wrote:
> bugzilla 221713 looks like the same bug. The ML10 v2 in comment 15 shows
> "DMA PTE for vPFN 0xf1f81 already set (to f1f81003 ...)", which is inside
> the same HP RMRR (0xf1f7e000-0xf1f94fff) that I see on 6.12, and its 7.x
> symptom is the same "Emask 0x40 (internal error)". Their bisect of the 7.x
> symptom points to d373449d8e97 ("iommu/vt-d: Use the generic iommu page
> table"), but the RMRR overlap is there long before that (they saw the
> PTE error back to 6.0, and I see it on 6.12). So my guess is that
> d373449d8e97 only changed how the overlap shows up.
> 
> The H97 thread looks different to me. There the faults are "non-zero
> reserved fields in PTE" at 0xff4xxxxx, outside any RMRR, and they depend
> on the request size.
> 
> sp_off: on this machine the only DRHD reports no superpage support
> (cap c9008020660262, SLLPS = 0), so I would not expect it to change
> anything. I tested it anyway:
> 
> 7.3.4 with intel_iommu=on,sp_off: no change. It still has 0 DMAR errors
> and 221 failed commands with "Emask 0x40 (internal error)" (121 READ
> FPDMA QUEUED, 100 WRITE FPDMA QUEUED). 3 of 6 copies lost 8 MiB each
> (zeros), and the iommu:map trace again shows 21 maps with
> iova=0xf1f7e000 size=0 from iommu_dma_map_sg.

You mentioned that 6.12.118, 7.3.4 and 7.4-rc4 is all bad.
Is there any kernel version where you did not need iommu=pt for a reliable
system without corruption?

This seems like either an Intel IOMMU bug or a HP ProLiant MicroServer Gen8
specific bug to me. Hopefully someone more knowledgeable in those areas will
chime in.


Kind regards,
Niklas
