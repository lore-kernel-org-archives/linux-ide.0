From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCHSET 04/11] merge irq-pio
Date: Tue, 16 May 2006 18:00:24 +0800
Message-ID: <4469A2B8.9020901@tw.ibm.com>
References: <11473544041507-git-send-email-htejun@gmail.com> <44665980.1020308@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:49362 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751720AbWEPKAj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 06:00:39 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4GA0cxG024253
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 06:00:38 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4GA0cr2273662
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 04:00:38 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4GA0b9a021258
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 04:00:38 -0600
In-Reply-To: <44665980.1020308@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Howdy,
>>
>> This is part of patchset series described in [T].
>>
>> This patchset contains merge of irq-pio branch.  This patchset is
>> composed of two patches - the first one is the merge and the second
>> one contains follow-up fixes.
>>
>> THIS PATCHSET IS FOR REVIEW ONLY.  Please pull from the git tree
>> described in [T] for proper credit attribution and merge history.
> 
> 
> I of course ACK this patchset.
> 
> I'm highly interested in "it works" feedback from Albert and Alan <hint
> hint>... :)
> 

Sorry for the late reply. 
I've downloaded the upstream branch. The irq-pio merge looks fine.
Also run minimal test with pata_pdc2027x/sata_via; the reset and normal read/write looks good.

Thanks for the great new features to play with. :)
Will do more test later.
--
albert

