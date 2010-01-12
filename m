From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: retry link resume if necessary
Date: Tue, 12 Jan 2010 14:00:14 +0900
Message-ID: <4B4C01DE.7000001@kernel.org>
References: <4B4A8994.8030600@kernel.org> <20100111225726.GA6591@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42952 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083Ab0ALE4I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Jan 2010 23:56:08 -0500
In-Reply-To: <20100111225726.GA6591@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, fengxiangjun <fengxiangjun@neusoft.com>, Jim Faulkner <jfaulkne@ccs.neu.edu>

Hello,

On 01/12/2010 07:57 AM, Greg KH wrote:
> On Mon, Jan 11, 2010 at 11:14:44AM +0900, Tejun Heo wrote:
>> Interestingly, when SIDPR is used in ata_piix, writes to DET in
>> SControl sometimes get ignored leading to detection failure.  Update
>> sata_link_resume() such that it reads back SControl after clearing DET
>> and retry if it's not clear.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Reported-by: fengxiangjun <fengxiangjun@neusoft.com>
>> Reported-by: Jim Faulkner <jfaulkne@ccs.neu.edu>
>> Cc: stable@kernel.org
>> ---
>> Greg, although this patch should be included in -stable release in
>> time, I think it should receive some more testing in devel branch for
>> at least a couple of -rc cycles as it changes very fundamental part of
>> hardreset protocol.  Is there a protocol for delayed inclusion into
>> -stable?  If not, I'll try to remember and ping you back after some
>> time but I'm almost sure that I'm gonna forget this.  :-)
> 
> I'll drop this into my "todo-stable" queue, and ping you back on this in
> a few weeks.  Sound good?

Yeap, sounds good.

Thanks.

-- 
tejun
