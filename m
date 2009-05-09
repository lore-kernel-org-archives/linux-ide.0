From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: fix suspend/resume for ATA SEMB devices
Date: Sun, 10 May 2009 00:48:26 +0900
Message-ID: <4A05A5CA.7070307@gmail.com>
References: <20090426143836.GA3643@liondog.tnic> <49F4DFA9.6040805@gmail.com> <20090509151348.GA25760@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:1176 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbZEIPsb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 May 2009 11:48:31 -0400
In-Reply-To: <20090509151348.GA25760@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Borislav Petkov wrote:
> On Mon, Apr 27, 2009 at 07:26:49AM +0900, Tejun Heo wrote:
>> Borislav Petkov wrote:
>>> due to a class mismatch in ata_dev_revalidate(). Fix it by adding the
>>> ATA_DEV_SEMB device class to the check.
>>>
>>> CC: Tejun Heo <htejun@gmail.com>
>>> CC: Jeff Garzik <jeff@garzik.org>
>>> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
>> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Hi Jeff,
> 
> any chance this can make it into 2.6.30?
> 

Jeff, this one should go into 2.6.30.  Without it, revalidation always
fails for ATA devices w/ SEMB signature which means any error
condition or suspend/resume will end up detaching and reattaching the
device.

Thanks.

-- 
tejun
