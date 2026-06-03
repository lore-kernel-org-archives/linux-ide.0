Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9237C0F9;
	Wed,  3 Jun 2026 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478046; cv=none; b=s6+nhylBxt5WPn8d3R2YTp3Wou92WXSPmewasEDbcahM5MoYcJWEMdBDuleB2whrcHs8N/POF1vcIwUO8c96rRGtGPhfC+EMok67xqURztzQXZzZ5FUREhqKdaVoedHvZXGi8YuKhVHkRZK31aBSX96xQZLSR+/vI0h2Lm+bmSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478046; c=relaxed/simple;
	bh=2pMDCiCPgWmEKPiowc9207Lp3LTysdgKO2ag3zPS7T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsAnuXpKn7E8xrYikIi/xddUCSTN42ic43CVy49h33Y0jByW0u16Zbe48dh06YiuadzGFrurC8H0DsepCrjESlMTxsIWaKCw55YLkU5U0tUYR8MNuljtvmfOZB3TykesJT0nwYUWUwJWIeiIrdgtJDObuqb6PbZpPGQEN5S8pwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr1T6eW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr1T6eW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F841F00893;
	Wed,  3 Jun 2026 09:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780478045;
	bh=8Wj1wagwuvsZGEuJ+c7RIKht8eXk712kgGE8CcGwD+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vr1T6eW7okthuoFfuHt+i69qXdl+VpmxXsDyEUEWr068oGK1Zxl1imC+rWNRwgJB9
	 C0+KcQRoJ9z0kZWNBbqhrJK6vmQhdu6CygLU9dljjFg33AavVK92/urdC9AnVGRiql
	 OeV2x+UzdsyFtTaQ9/pOZuQgsUXS3UyrvWntB8fgaKAnnIm0SKn+XV15h8S69U8YVM
	 +rOFDRXT1l1fDMAp/qnqeD+vMSappbTHCyXzH1d+ncZNkoDGLNtaGETetqs8OYy17p
	 yNc/W4yDIMHbJFD8FjbXanv9rm350cbA0T59+UBTJmRKODUJmxn65JQ2ZbY5Eh4ekp
	 39kYnFoffjWug==
Date: Wed, 3 Jun 2026 11:14:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Han Gao <rabenda.cn@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Michael Orlitzky <michael@orlitzky.com>, sophgo@lists.linux.dev,
	Inochi Amaoto <inochiama@outlook.com>, Han Gao <gaohan@iscas.ac.cn>,
	zhengjingkun@iscas.ac.cn, linux-ide@vger.kernel.org,
	dlemoal@kernel.org
Subject: Re: SG2042 SATA (DMA?) issues
Message-ID: <ah_wWLBK5OqBCFH1@ryzen>
References: <ahu57vcS0oOFmCI9@mertle>
 <ahxOMJqJTqKfY9SI@mertle>
 <MA5PR01MB125002F8416D3FC82656A5262FE152@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
 <ahzs8MSmNU7_vsIT@mertle>
 <MA5PR01MB12500AE1ED1AD25C00C4BA706FE152@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
 <ah0rA-c34RLkHWYt@mertle>
 <MA5PR01MB1250071E879EDEC8ED3A29813FE152@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
 <CAAT7Ki_=jGo1jbSBWmr-dQHT2pFovL2LAjcW0SN9F0Xm-uLkRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAT7Ki_=jGo1jbSBWmr-dQHT2pFovL2LAjcW0SN9F0Xm-uLkRg@mail.gmail.com>

Hello Han,

On Tue, Jun 02, 2026 at 08:19:32PM +0800, Han Gao wrote:
> Hi, Michael
> 
> Based on the new firmware with DMA coherence, we tested the following cases.
> 
> Test method:
> mkfs.btrfs /dev/sda1
> mount /dev/sda1 /mnt
> f3write -e 128 /mnt
> sync
> f3read /mnt
> 
> case1:
> 2042pcie - asm2824 - jmb585: failed, csum failed.
> case2:
> 2042pcie - amd b650 bridge(prom 21) - asm1062: pass.
> case3:
> 2042pcie - asm2824 - amd b650 bridge(prom 21) - asm1062: pass
> case4:
> 2042pcie - asm2824 - jmb585 + kernel parameter libata.force=noncq: pass
> 
> Based on the test results of the above four cases,
> the problem is suspected to lie in the JMB585 chip itself.

+linux-ide

Original thread:
https://lore.kernel.org/sophgo/ahu57vcS0oOFmCI9@mertle/


I interpret this as, before you added 'dma-coherent' to your PCIe controller
device tree node:

Sophgo SG2042 PCIe + ASM2824 + JMB585
worked fine, without any libata.force=noncq kernel parameter which disables NCQ.


After adding 'dma-coherent' to your PCIe controller device tree node:
Sophgo SG2042 PCIe + ASM2824 + JMB585
no longer works fine, and you need to disable NCQ to not get filesystem
corruption.


If this was a problem with the JMB585 chip, why did it work fine to run with NCQ
enabled before you did firmware changes + added 'dma-coherent' to your PCIe
controller device tree node?

Disabling NCQ will significantly reduce the drive performance.


Kind regards,
Niklas
