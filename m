From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22] Add LED trigger to libata core
Date: Mon, 19 Mar 2007 21:14:14 +0900
Message-ID: <45FE7E96.4050808@gmail.com>
References: <20070318170605.3751D5B80F1@ganymede.vroon.org>	<45FE14BD.5090701@gmail.com> <20070319124616.2fb7494b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:6666 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbXCSMOV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 08:14:21 -0400
Received: by nz-out-0506.google.com with SMTP id s1so611550nze
        for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 05:14:21 -0700 (PDT)
In-Reply-To: <20070319124616.2fb7494b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tony Vroon <chainsaw@gentoo.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mon, 19 Mar 2007 13:42:37 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Tony Vroon wrote:
>>> This duplicates the IDE core LED trigger in the libata core.
>>> I plan to use this by allowing PMU LED control on G5 towers. My test platform 
>>> is a PowerMac 7,3 (Dual G5 2.0GHz, June 2004) with a K2 (sata_svw) controller.
>> I think this fits better in libata-core.c::ata_qc_issue().  Can you move
>> it to there?
> 
> Gak. I'd rather it stayed out of ata_qc_issue() which is a critical path
> for performance.

The original place is in the critical path too.  It's just at the outer 
function which eventually calls ata_qc_issue() (the mapping is almost 
one to one).

> Our command issu is already too heavy and not all
> controllers have queueing to absorb that. How many controllers actually
> need this hook and can we not have ata_qc_issue_with_led() helpers for
> them ?

Our issue path is somewhat expensive due to SCSI -> ATA translation but 
I don't think it really matters on any modern cpu.  It can definitely 
hurt on embedded tho.  :-(

-- 
tejun
