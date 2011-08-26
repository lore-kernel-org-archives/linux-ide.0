From: Tejun Heo <tj@kernel.org>
Subject: Re: Port Multiplier vendor mismatch '0x1095' != '0x101'
Date: Fri, 26 Aug 2011 08:58:15 +0200
Message-ID: <20110826065815.GB2632@htj.dyndns.org>
References: <20110826064050.GD17614@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64310 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab1HZG6U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Aug 2011 02:58:20 -0400
Received: by bke11 with SMTP id 11so2295554bke.19
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2011 23:58:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110826064050.GD17614@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc MERLIN <marc@merlins.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, mlord@pobox.com

Hello,

On Thu, Aug 25, 2011 at 11:40:50PM -0700, Marc MERLIN wrote:
> ata11.15: hard resetting link
> ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata11.15: Port Multiplier vendor mismatch '0x1095' != '0x101'
> ata11.15: PMP revalidation failed (errno=-19)
> ata11.15: hard resetting link
> ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata11.15: Port Multiplier vendor mismatch '0x1095' != '0x101'
> ata11.15: PMP revalidation failed (errno=-19)
> ata11.15: limiting SATA link speed to 1.5 Gbps
> ata11.15: hard resetting link
> ata11.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata11.15: Port Multiplier vendor mismatch '0x1095' != '0x101'
> ata11.15: PMP revalidation failed (errno=-19)
> ata11.15: failed to recover PMP after 5 tries, giving up
> ata11.15: Port Multiplier detaching
> ata11.00: disabled
> ata11.01: disabled
> ata11.02: disabled
> ata11.03: disabled
> ata11.04: disabled
> ata11.00: disabled
> ata11: hard resetting link
> ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata11.15: Port Multiplier <unknown>, 0x0101:0x9669 r1, 1 ports, feat 0x96690101/0x96690101

Either the controller or port multiplier (more likely the controller)
got completely confused.  It's basically reporting random garbage for
the identification data for the port multiplier.  I don't know what
went on there but probably the controller needed a strong kick in the
butt to come back into sane state.  Anyways, there isn't much the port
multiplier layer can do if the controller is reporting garbage for
data read from PMP.

Mark, have you seen anything like this?  Could it be that the
controller goes out of proper configuration after certain condition
and needs to be reset/reconfigured?

Thanks.

-- 
tejun
