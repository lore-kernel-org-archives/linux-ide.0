From: Daniel Walker <danielwa@cisco.com>
Subject: Re: [PATCH 1/2] drivers: pata_octeon_cf : Switch IO mode depending on
 model number
Date: Fri, 8 Jan 2016 12:11:47 -0800
Message-ID: <56901803.209@cisco.com>
References: <1452230332-14926-1-git-send-email-danielwa@cisco.com>
 <20160108153049.GN1898@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:8379 "EHLO
	rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbcAHULu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jan 2016 15:11:50 -0500
In-Reply-To: <20160108153049.GN1898@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Anil Veliyankara Madam <aveliyan@cisco.com>, xe-kernel@external.cisco.com, Shikha Jain <shikjain@cisco.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Chris Hall (hall)" <hall@cisco.com>

On 01/08/2016 07:30 AM, Tejun Heo wrote:
> Hello, Daniel.
>
> On Thu, Jan 07, 2016 at 09:18:51PM -0800, Daniel Walker wrote:
>> From: Anil Veliyankara Madam <aveliyan@cisco.com>
>>
>> Since viking flash has a problem in the MWDMA mode which causes data
>> corruption, this patch allows the driver to detect the model number
>> and switch the IO mode to PIO6 if it's a viking flash.
> Hmmm... is this specific to pata_octeon_cf or should it apply to the
> device regardless of the controller in use?
>
>

It's not specific to pata_octeon_cf , it should be applied to the device 
regardless of controller. Is there a better place to put this to cover all ?

Daniel
