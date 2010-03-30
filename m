From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream RESEND 2/2] ahci: implement AHCI_HFLAG_NO_FPDMA_AA
 and update NV quirks
Date: Tue, 30 Mar 2010 13:02:42 -0400
Message-ID: <4BB22EB2.8020900@garzik.org>
References: <4BB00337.1030302@kernel.org> <4BB00364.40701@kernel.org> <4BB10B91.7040206@garzik.org> <4BB153C0.50306@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49690 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab0C3RCq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Mar 2010 13:02:46 -0400
Received: by pva18 with SMTP id 18so2889816pva.19
        for <linux-ide@vger.kernel.org>; Tue, 30 Mar 2010 10:02:44 -0700 (PDT)
In-Reply-To: <4BB153C0.50306@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 03/29/2010 09:28 PM, Tejun Heo wrote:
> Subject: ahci: implement AHCI_HFLAG_NO_FPDMA_AA and update NV quirks
>
> It turns out different generations of MCPs have differing quirks.
>
> * MCP 65-73 : FPDMA AA broken, lies about PMP support, forgets to report NCQ
> * MCP 77-79 : FPDMA AA broken, lies about PMP support
> * MCP 89    : FPDMA AA broken
>
> Instead of turngin off FPDMA AA on all NVIDIAs, implement
> HFLAG_NO_FPDMA_AA, define additional board IDs and apply necessary
> quirks.
>
> This fixes bko#15481 and the list of quirks is verified by Peer Chen.
>
>    http://bugzilla.kernel.org/show_bug.cgi?id=15481
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Peer Chen<pchen@nvidia.com>
> ---
> Crap, that was me doing quilt add include/linux/ahci.h instead of
> drivers/ata/ahci.h and not checking diffstats afterwards.  Sorry about
> that.  Here's the working version.
>
> Thanks.

applied


