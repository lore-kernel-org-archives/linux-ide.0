Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C051C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 16 Nov 2021 01:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D7161265
	for <linux-ide@archiver.kernel.org>; Tue, 16 Nov 2021 01:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbhKPBrZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 Nov 2021 20:47:25 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45365 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381647AbhKPBnz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 Nov 2021 20:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637026859; x=1668562859;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=74U7sCw7uhiln2XIYRMB7D8EWN7aCKM++/zV+qcqiFo=;
  b=bE/q/XAdQ1LLwT7Q4+FUdJ7gXJn8CXoJg8lLsPRZKZotjuuHJV8hS5f5
   K3Zs9cS1v68Mu5WsGVdbprG1W64DghKyNv7EeAX8XCu4fR08g0MlDJBmi
   3w5k917ZC9nOY+QE2CGhM2Rimk4LLnQkhtnBGLvYwJqTm9+r4GMLF/y9d
   uzQ6KcwoJcz+ode5XckXTGTT+DoS6aeebgqCR35Pl6hqohAxxQKkVDhVm
   6MliTVMTiDXgS3PR4MOJbVM2QlrFpfMri8PsQiJ6F3OamKLiLsS1kUv/O
   Bi7l8djAXfNBpyp2b4mQeVKcCtto55JA5VEctuD507qod2VGkcXsf825Y
   w==;
X-IronPort-AV: E=Sophos;i="5.87,237,1631548800"; 
   d="scan'208";a="289622730"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2021 09:40:58 +0800
IronPort-SDR: 1mb4YWCusoehG5Swko2IMZ1dgwBM1p0cGFRYGb6FjIOd6TX9cLMoNEoX+wl5BWwIWRPeu7KfQd
 0STiq19HZ0MP6NBFGQhOWcGItJ6k6fNFZV1HXjKCi0F5+W/PeI/cgUGS9UCw4qyr1DHPoB1Ubh
 5N/CsNY0DgtpyoHTnBipVUpSPXyhLtKpf7OYbyY1+kr4hMZRw2HKoLVColLXhpiZSKKWwU6nQt
 S4uWMP1C9FDDPDWeOmX38kH9pqLlbBeU4OUfO+wJ2uzK/r3D/Z27uKVVG5rtFBT1/YWylBgyJO
 AijcW66T00g9CIguSl3GAamn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 17:16:02 -0800
IronPort-SDR: LyeCGbeebUAVUpNYL92n3lJQ4qwgAphg6/jVp+8WmghZZyWqU0xtZb6HAP7KFbUjKnJv+HXHof
 le+eiGQJxB8/eJqL+fbIaPZVit+o9vZ77m+hoqJFG/uOEw3em+mOi/bG5J/Gf+ENAjxhrKUvpQ
 PE4REHD1SPOebE1/XUFycXOjjbwwGB6UOlRnxb1lm+42grgbh4oMJId5JrmLujS6rXKQw5uQAM
 0tLEMrsFmJjQ5W/kAMHYEDoF46dr43Tlyhxz8dKfDobije0XWO5KBHn5wfRj1qtItLFNVPMI5+
 DHk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 17:40:58 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HtTKk1t31z1RtVm
        for <linux-ide@vger.kernel.org>; Mon, 15 Nov 2021 17:40:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637026857; x=1639618858; bh=74U7sCw7uhiln2XIYRMB7D8EWN7aCKM++/z
        V+qcqiFo=; b=BDMehfiT68SClFKn+Yn23nSnT50M8hLoivF53V2FCRTINdGlHIT
        0SqcPVYCvhT/sk8Q0zMDqeIOZ4oUdtpAvuqXIXB2GXHc8RfQOzjdYczseKOQa4qS
        a3Gy4nrV+2+f8Kgpa89zV4oPmyiXi8ADF+c/7Sp7A1Rcdsc7b1qhT90TTQQj9Q2g
        aZItcw1MgDhhpKeUrqBDFEgbyc21Q0oRzvLkVp8cYWyRF6ynODIo+PBLkTqDuwLa
        c++CJvwfoWsmusEekrMqFnqF9ZgLt+tWT75D/xIM2wwtThRsmh+mPs1+SucOkqzz
        p3g1p7tM1BE5fV/NeeQwWm8nE1dL3kAjG1Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0I8UKRUXxqiz for <linux-ide@vger.kernel.org>;
        Mon, 15 Nov 2021 17:40:57 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HtTKh6xFrz1RtVl;
        Mon, 15 Nov 2021 17:40:56 -0800 (PST)
Message-ID: <3d514759-a7d4-533f-63ec-1aa682f50f5d@opensource.wdc.com>
Date:   Tue, 16 Nov 2021 10:40:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH 2/2] ata: Adjust behavior when StorageD3Enable _DSD is set
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
References: <20211112201539.17377-1-mario.limonciello@amd.com>
 <20211112201539.17377-2-mario.limonciello@amd.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211112201539.17377-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/11/13 5:15, Mario Limonciello wrote:
> The StorageD3Enable _DSD is used for the vendor to indicate that the disk
> should be opted into or out of a different behavior based upon the platform
> design.
> 
> For AMD's Renoir and Green Sardine platforms it's important that any
> attached SATA storage has transitioned into DevSlp when s2idle is used.
> 
> If the disk is left in active/partial/slumber, then the system is not able
> to resume properly.
> 
> When the StorageD3Enable _DSD is detected, check the system is using s2idle
> and DevSlp is enabled and if so explicitly wait long enough for the disk to
> enter DevSlp.
> 
> Cc: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214091
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/ata/libahci.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 28430c093a7f..15c293da30ca 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2322,6 +2322,18 @@ int ahci_port_resume(struct ata_port *ap)
>  }
>  EXPORT_SYMBOL_GPL(ahci_port_resume);
>  
> +static void ahci_handle_s2idle(struct ata_port *ap)
> +{
> +	void __iomem *port_mmio = ahci_port_base(ap);
> +	u32 devslp;
> +
> +	if (pm_suspend_via_firmware())
> +		return;
> +	devslp = readl(port_mmio + PORT_DEVSLP);
> +	if ((devslp & PORT_DEVSLP_ADSE))
> +		ata_msleep(ap, devslp_idle_timeout);
> +}

This generates a warning at compilation if CONFIG_PM is not enabled. This
function must be under the #ifdef CONFIG_PM below.
I can fix this up, or you can resend a v2 if you prefer.

> +
>  #ifdef CONFIG_PM
>  static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
>  {
> @@ -2336,6 +2348,9 @@ static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
>  		ata_port_freeze(ap);
>  	}
>  
> +	if (acpi_storage_d3(ap->host->dev))
> +		ahci_handle_s2idle(ap);
> +
>  	ahci_rpm_put_port(ap);
>  	return rc;
>  }
> 


-- 
Damien Le Moal
Western Digital Research
