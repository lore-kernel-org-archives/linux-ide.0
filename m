From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 3/3] ahci: implement AHCI_HFLAG_NO_FPDMA_AA
 and update NV quirks
Date: Fri, 12 Mar 2010 10:16:59 +0900
Message-ID: <4B99960B.6060902@kernel.org>
References: <4B98575C.5050508@kernel.org> <4B9857EA.5090101@kernel.org> <4B98580F.8010908@kernel.org> <4B9985E9.5010909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53059 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780Ab0CLBRK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Mar 2010 20:17:10 -0500
In-Reply-To: <4B9985E9.5010909@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, pchen@nvidia.com, kernel-bugzilla.20.drkshadow@spamgourmet.com

Hello,

On 03/12/2010 09:08 AM, Robert Hancock wrote:
> On 03/10/2010 08:40 PM, Tejun Heo wrote:
>> It turns out different generations of MCPs have differing quirks.
>>
>> * MCP 65-73 : FPDMA AA broken, lies about PMP support, forgets to
>> report NCQ
>> * MCP 77-79 : FPDMA AA broken, lies about PMP support
>> * MCP 89    : FPDMA AA broken
>>
>> Instead of turngin off FPDMA AA on all NVIDIAs, implement
>> HFLAG_NO_FPDMA_AA, define additional board IDs and apply necessary
>> quirks.
>>
>> This fixes bko#15481 and the list of quirks is verified by Peer Chen.
>>
>>    http://bugzilla.kernel.org/show_bug.cgi?id=15481
>>
>> Signed-off-by: Tejun Heo<tj@kernel.org>
>> Cc: Peer Chen<pchen@nvidia.com>
> 
> Is the FPDMA AA problem going to be fixed in whatever follows MCP89?
> This change is only safe if it will be, since a new chipset will fall
> into the generic case and it'll get turned back on.

Yeap, it would be great if NVIDIA fixes it but that said blacklisting
by default usually isn't a very good idea because it often falls
through the crack and after a while not many people remember what
happened when.  If NVIDIA doesn't fix the next revision, we'll know
soon enough.

Thanks.

-- 
tejun
