From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Regressions in sata_nv regarding STANDYBY IMMEDIATE.
Date: Sat, 28 Apr 2012 00:30:46 -0600
Message-ID: <4F9B8E96.1010802@gmail.com>
References: <1335337953.2409.17.camel@donpedro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54056 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261Ab2D1Gat (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Apr 2012 02:30:49 -0400
Received: by iadi9 with SMTP id i9so1901968iad.19
        for <linux-ide@vger.kernel.org>; Fri, 27 Apr 2012 23:30:48 -0700 (PDT)
In-Reply-To: <1335337953.2409.17.camel@donpedro>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: donpedro@tdcadsl.dk
Cc: linux-ide@vger.kernel.org

On 04/25/2012 01:12 AM, Peter Dons Tychsen wrote:
> Hello,
>
> Recent kernels broke suspend/hibernate completely on one of my setups
> after updating to more recent kernels (3.3). It used to work perfectly
> and the machine was hardly ever powered completely off (standby).
> (older M2N-E ASUS motherboard with nvidia MC55 controller).
>
> The symptoms where that the system would hang entering hibernate. The
> only complaint from the system was that command STANDBY_IMMEDIATE had
> failed.
>
> At first i assumed that the disk (an older WD Green disk) was dying, and
> replaced the disk with a cheap Seagate disk. However, this turned out
> not to be the case.
>
> Looking through the ATA code i found that STANDBY had been replaced with
> STANDBY_IMMEDIATE as it was supposed to be more compliant. Replacing it
> with the old STANDBY made the standby procedure work again.

I'm not aware of this being changed recently. If it's this commit you're 
referring to, it was back in 2007:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=78981a7c6c34bddbb90da72cf6ce10953e84aad8

What was the last kernel that was known to work OK?

>
> Now the question is: The STANDBY and STANDBY_IMMEDIATE commands are for
> the disk. Why does it specifically break for disks on MCP55 and not on
> other chipsets? Does it make sense?

Not really, but these NVIDIA SATA controllers (especially the pre-AHCI 
ones like this) are finicky beasts.

>
> FWIW both disks seem to suspend fine on the same controller using an
> other O/S.
>
> Later i also discovered that the new disk actually made things worse.
> Using the hack suspend worked again for the old disk. The new disk could
> now suspend but would mostly get stuck getting out of suspend as it
> would seem that the system caused it to stop responding all together
> requiring a hard reboot.
>
> Any ideas?
>
> Thanks,
>
> /pedro
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

