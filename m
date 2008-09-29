From: Tejun Heo <htejun@gmail.com>
Subject: Re: What's the SB600 64-bit DMA problem?
Date: Mon, 29 Sep 2008 13:25:54 +0900
Message-ID: <48E058D2.7050704@gmail.com>
References: <20080920151712.10515.qmail@science.horizon.com> <da824cf30809201528o27478ae2h5894e39932622d3b@mail.gmail.com> <20080921001529.23400.qmail@science.horizon.com> <65a6ef750809231730h52f6bf47g23b33db1d2f4ca08@mail.gmail.com> <48DA0C8B.3000406@gmail.com> <B90463BC30D2E446BA423D888DC85E50C8358F@sshaexmb1.amd.com> <20080925032437.6802.qmail@science.horizon.com> <48DCEC6D.1040305@gmail.com> <20080928210422.2578.qmail@science.horizon.com> <48E0112C.7010901@gmail.com> <20080929040812.8784.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:64855 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbYI2E1U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 00:27:20 -0400
Received: by ti-out-0910.google.com with SMTP id b6so838235tic.23
        for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2008 21:27:18 -0700 (PDT)
In-Reply-To: <20080929040812.8784.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: Shane.Huang@amd.com, mdnelson8@gmail.com, linux-ide@vger.kernel.org, jgarzik@redhat.com, grundler@google.com

George Spelvin wrote:
> ATM I'm just recompiling the kernel from -rc6 to -rc7.
> 
> It's in single-user mode so I can't ssh over the boot messages, but
> they definitely included "64bit" from ahci_print_info().

Thanks for verifying.  I would love to lift the 32 restriction from
SB600 but it's been quite a rocky ride and I still can't tell what's
the determining factor.  :-(

> Speaking of anci_print_info(), sould something like the following be a good
> thing?
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 2e1a7cb..18137d2 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -2464,22 +2464,22 @@ static void ahci_print_info(struct ata_host *host)
>  		"%s\n"
>  		,
>  
> -		cap & (1 << 31) ? "64bit " : "",
> -		cap & (1 << 30) ? "ncq " : "",
> -		cap & (1 << 29) ? "sntf " : "",
> -		cap & (1 << 28) ? "ilck " : "",
> -		cap & (1 << 27) ? "stag " : "",
> -		cap & (1 << 26) ? "pm " : "",
> -		cap & (1 << 25) ? "led " : "",
> -
> -		cap & (1 << 24) ? "clo " : "",
> -		cap & (1 << 19) ? "nz " : "",
> -		cap & (1 << 18) ? "only " : "",
> -		cap & (1 << 17) ? "pmp " : "",
> -		cap & (1 << 15) ? "pio " : "",
> -		cap & (1 << 14) ? "slum " : "",
> -		cap & (1 << 13) ? "part " : "",
> -		cap & (1 << 6) ? "ems ": ""
> +		cap & HOST_CAP_64   ? "64bit " : "",
> +		cap & HOST_CAP_NCQ  ? "ncq " : "",
> +		cap & HOST_CAP_SNTF ? "sntf " : "",
> +		cap & (1 << 28)     ? "ilck " : "",
> +		cap & HOST_CAP_SSS  ? "stag " : "",
> +		cap & HOST_CAP_ALPM ? "pm " : "",
> +		cap & (1 << 25)     ? "led " : "",
> +
> +		cap & HOST_CAP_CLO  ? "clo " : "",
> +		cap & (1 << 19)     ? "nz " : "",
> +		cap & (1 << 18)     ? "only " : "",
> +		cap & HOST_CAP_PMP  ? "pmp " : "",
> +		cap & (1 << 15)     ? "pio " : "",
> +		cap & HOST_CAP_SSC  ? "slum " : "",
> +		cap & (1 << 13)     ? "part " : "",
> +		cap & HOST_CAP_EMS  ? "ems ": ""

Yeah, probably.  While at it, can you just add constants for other
bits too and send it as properly singed off patch?

Thanks.

-- 
tejun
