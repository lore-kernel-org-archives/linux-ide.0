From: Tejun Heo <tj@kernel.org>
Subject: Re: ARM: Fix kernel panic caused by unaligned access in sata_sil24
Date: Fri, 04 Jun 2010 15:22:47 +0200
Message-ID: <4C08FE27.1050109@kernel.org>
References: <000301cb03e2$bf0020e0$3d0062a0$@tuckley@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60343 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755888Ab0FDNW5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Jun 2010 09:22:57 -0400
In-Reply-To: <000301cb03e2$bf0020e0$3d0062a0$@tuckley@arm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Colin Tuckley <colin.tuckley@arm.com>
Cc: linux-ide@vger.kernel.org, Catalin Marinas <Catalin.Marinas@arm.com>, Robin Randhawa <Robin.Randhawa@arm.com>

On 06/04/2010 02:37 PM, Colin Tuckley wrote:
> From: Colin Tuckley <colin.tuckley@arm.com>
> 
> Subject: ARM: Fix kernel panic caused by unaligned access in sata_sil24
> 
> The sata_sil24 driver has six 16-bit registers that are initialised with
> 32-bit writes. This cause a kernel panic on ARM due to the unaligned
> accesses which result.
> 
> This patch changes the accesses to the correct 16-bit ones.
> 
> Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
