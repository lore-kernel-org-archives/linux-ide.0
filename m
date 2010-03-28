From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [Patch 1/1 v2] pata_via: HDD of VT6410/6415/6330 cannot be detected
 issue
Date: Sun, 28 Mar 2010 00:53:53 -0400
Message-ID: <4BAEE0E1.5030306@garzik.org>
References: <9E058EE846170743AF7338FE064CB5AB38B477@exchtp04.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9E058EE846170743AF7338FE064CB5AB38B477@exchtp04.taipei.via.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: JosephChan@via.com.tw
Cc: linux-ide@vger.kernel.org, stable@kernel.org, linux-kernel@vger.kernel.org, sshtylyov@mvista.com, tj@kernel.org
List-Id: linux-ide@vger.kernel.org

On 03/25/2010 08:51 AM, JosephChan@via.com.tw wrote:
> When using VT6410/6415/6330 chips on some VIA's platforms, the HDD connects to VT6410/6415/6330 cannot be detected.
> It is because the driver detects wrong via_isa_bridge ID, and then cause the this issue happen.
> This patch will fix this problem.
>
>
> Signed-off-by: Joseph Chan<josephchan@via.com.tw>
>
> --- a/drivers/ata/pata_via.c	2010-03-16 06:00:01.000000000 -0400
> +++ b/drivers/ata/pata_via.c	2010-03-25 08:47:15.000000000 -0400
> @@ -576,6 +576,10 @@
>   			u8 rev = isa->revision;
>   			pci_dev_put(isa);
>
> +			if ((id->device == 0x0415 || id->device == 0x3164)&&
> +			      (config->id != id->device))
> +				continue;
> +

applied
