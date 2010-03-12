From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH #upstream-fixes 3/3] ahci: implement AHCI_HFLAG_NO_FPDMA_AA
 and update NV quirks
Date: Thu, 11 Mar 2010 18:08:09 -0600
Message-ID: <4B9985E9.5010909@gmail.com>
References: <4B98575C.5050508@kernel.org> <4B9857EA.5090101@kernel.org> <4B98580F.8010908@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43969 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab0CLAIM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Mar 2010 19:08:12 -0500
Received: by pwi1 with SMTP id 1so344107pwi.19
        for <linux-ide@vger.kernel.org>; Thu, 11 Mar 2010 16:08:11 -0800 (PST)
In-Reply-To: <4B98580F.8010908@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, pchen@nvidia.com, kernel-bugzilla.20.drkshadow@spamgourmet.com

On 03/10/2010 08:40 PM, Tejun Heo wrote:
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

Is the FPDMA AA problem going to be fixed in whatever follows MCP89? 
This change is only safe if it will be, since a new chipset will fall 
into the generic case and it'll get turned back on.
