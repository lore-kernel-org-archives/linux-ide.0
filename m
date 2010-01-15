From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 1/2] libata: cleanup ata_sff_interrupt()
Date: Fri, 15 Jan 2010 12:33:10 +0900
Message-ID: <4B4FE1F6.4060204@kernel.org>
References: <4B4ECCCD.1040902@kernel.org> <4B4F56A0.6060606@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40856 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771Ab0AOD1l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Jan 2010 22:27:41 -0500
In-Reply-To: <4B4F56A0.6060606@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Werner <hwerner4@gmx.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On 01/15/2010 02:38 AM, Jeff Garzik wrote:
> On 01/14/2010 02:50 AM, Tejun Heo wrote:
>> host->ports[i] is never NULL if i<  host->n_ports and non-NULL return
>> from ata_qc_from_tag() guarantees that the returned qc is active.
>> Drop unnecessary tests.
>>
>> Signed-off-by: Tejun Heo<tj@kernel.org>
>> ---
>>   drivers/ata/libata-sff.c |   17 +++++++----------
>>   1 file changed, 7 insertions(+), 10 deletions(-)
> 
> This is more #upstream material, don't you think?  We are pretty deep
> into -rc at this point.

Yeap, agreed.

Thanks.

-- 
tejun
