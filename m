Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5626770E2;
	Thu, 17 Oct 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169488; cv=none; b=GoAK7VppSebn9z2TmCoD4gDz3lvvNaOFb4smG9H2VyKUANhbX7GlyMEsp+7iFjzaoJHKxzHqomcUuBPlmIS5/n8MXd7o21vCLxJihjIY/gRon1NYhEHT1nCUQm5UIktquaJR2qeetSdo5EEBLE+jbRNPMBw6P0DMJyulOalTiVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169488; c=relaxed/simple;
	bh=5j15eT918xydVxHdlScuM8Z8O1RXoSCieKuyjdyfJhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfX8+U/POzT+mQxKEcwh+n6wNHr7qi6294R+mVlqlXJuBB/KSqW01Hu2KM6sHrVA+7A40088DhQ8RWTPADHN0zvu4B2LDuI0wFk554fm+cbuRO5NPmu9TCcehslhhuLDxHBOI5runAAEvESzzKHBFQzIirX9lgDCAq5dBBpjpv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC8oarjH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC8oarjH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8B7C4CEC3;
	Thu, 17 Oct 2024 12:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729169487;
	bh=5j15eT918xydVxHdlScuM8Z8O1RXoSCieKuyjdyfJhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LC8oarjHlSAF5pidioTEz8bPBwH15OVtGZKJXtxJ95e3svqFYRi99yxVF/A8zkL5y
	 DjEEcdVyKfl501O+clX8U8go8BtRfxD4WhFIm8g3NU/ABRdzFi6+21IMEnB5IlfDtQ
	 oi+vSqPM/cMFPcCpe1DUy3UqoxALq7pcnaFNEHSkXqFnKjgId5RmGd05Wv3ZlkmMbH
	 Qc6Kh3a0wHqlQNa2iCJ+tvD9IC/z+WR4bbOUmghaHKP+jACoq6Yt33nW4b3wGU192q
	 ZC4FBPEDnkLi0rTQhAVKBdKtKuhMyrcvSXgCeQxKHL+rO/PotoV6iJ7FvWFvVqlCIe
	 M+uqlEKscUoVg==
Date: Thu, 17 Oct 2024 14:51:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [RFC PATCH v1 34/57] sata_sil24: Remove PAGE_SIZE compile-time
 constant assumption
Message-ID: <ZxEISOhaqRvHlc3U@ryzen.lan>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-34-ryan.roberts@arm.com>
 <ZxDUZMDf2Xfz2tvi@ryzen.lan>
 <7aa84080-6845-496a-a394-30d334632298@arm.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aa84080-6845-496a-a394-30d334632298@arm.com>

On Thu, Oct 17, 2024 at 01:42:22PM +0100, Ryan Roberts wrote:
> On 17/10/2024 10:09, Niklas Cassel wrote:

(snip)

> > As you might know, there is an effort to annotate all flexible array
> > members with their run-time size information, see commit:
> > dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
> 
> I'm vaguely aware of it. But as I understand it, __counted_by() nominates
> another member in the struct which keeps the count? In this case, there is no
> such member, it's size is implicit based on the value of PAGE_SIZE. So I'm not
> sure if it's practical to use it here?

Neither am I :)

Perhaps some of the flexible array member experts like
Kees Cook or Gustavo A. R. Silva could help us out here.

Would it make sense to add another struct member and simply initialize
it to PAGE_SIZE, in order to be able to use the __counted_by macro?


> 
> > 
> > I haven't looked at the DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST macro, but since
> 
> DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST(), when doing a boot-time page size build,
> defers the initialization of the global variable to kernel init time, when
> PAGE_SIZE is known. Because SIL24_MAX_SGE is defined in terms of PAGE_SIZE, this
> deferral is required.
> 
> > sge[] now becomes a flexible array member, I think it would be nice if it
> > would be possible to somehow use the __counted_by macro.
> > 
