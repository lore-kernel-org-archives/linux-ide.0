From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: Addresses in PxCLB and PxCLBU
Date: Wed, 8 Jul 2015 13:44:25 +0300
Message-ID: <559CFF09.2040300@cogentembedded.com>
References: <559B11FD.2040800@micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34157 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756953AbbGHKo3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jul 2015 06:44:29 -0400
Received: by lbnk3 with SMTP id k3so53490911lbn.1
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2015 03:44:27 -0700 (PDT)
In-Reply-To: <559B11FD.2040800@micron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Andy Falanga (afalanga)" <afalanga@micron.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello.

On 7/7/2015 2:41 AM, Andy Falanga (afalanga) wrote:

> I'm working with the registers in an AHCI controller.  The memory
> address contained in PxCLB and PxCLBU (if 64-bit addressing is
> supported): what kind of address are they?

    Apparently, physical. The hardware only operates on the physical addresses.

> Currently, when I get the
> address and place it into a pointer of struct ahci_cmd_hdr and try to
> dereference, my VM locks and then reboots.  What am I doing incorrectly?

    You can't de-reference physical addresses.

> Basically, I have this:

> void __iomem * pbase = ahci_port_base((struct ata_port*));

    Can't parse this.

> struct ahci_cmd_hdr *cmd_hdr = NULL;

> cmd_hdr = (struct ahci_cmd_hdr*)(u64)
>      ((u64)(*(temp + PORT_LST_ADDR_HI)) << 32 | *temp);

   temp?

> pr_info("cmd_hdr is %p\n", cmd_hdr);
> pr_info("cmd_hdr->opts is %d\n", cmd_hdr->opts);  /* opts is __le32 */

> At the last line above my VM hangs and reboots.  The memory address is
> something like 0x0000000037900000.  This address makes me think that I
> simply can't dereference it but I'm quite new to this and I don't know
> what I should do.  I'd appreciate any help even if that's a pointer (no
> pun intended) to a more appropriate forum.

    The corresponding virtual address seems to be contained in 
ahci_port_priv::cmd_slot.

> Thanks,
> Andy

WBR, Sergei

