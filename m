From: "Patrick Ale" <patrick.ale@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Sun, 18 Feb 2007 15:50:06 +0100
Message-ID: <8d158e1f0702180650s6d1a6671tc6a2d6a0ce696add@mail.gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>
	 <8d158e1f0702150052l25fb03fnf17ba315dc6f912d@mail.gmail.com>
	 <8d158e1f0702160010k2ed986ddtaccf8d2678ae1231@mail.gmail.com>
	 <45D56FE4.3090900@tw.ibm.com>
	 <8d158e1f0702160056j11ab6df1v99b4d72866f3e1b2@mail.gmail.com>
	 <45D574B1.8080109@tw.ibm.com>
	 <8d158e1f0702160148v366ce96bm8e3ff3e7c64a7198@mail.gmail.com>
	 <45D58270.4080909@tw.ibm.com>
	 <8d158e1f0702170236h51756aadh6539f5d782774764@mail.gmail.com>
	 <8d158e1f0702170829m6b57b0d3y51d69431983346d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:50879 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbXBROuH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Feb 2007 09:50:07 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1421592wxd
        for <linux-ide@vger.kernel.org>; Sun, 18 Feb 2007 06:50:07 -0800 (PST)
In-Reply-To: <8d158e1f0702170829m6b57b0d3y51d69431983346d3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On 2/17/07, Patrick Ale <patrick.ale@gmail.com> wrote:

> I can't even calculate how many terrabyte that'd be on just hde but I
> can only wish I had that amount of diskspace.

More updates;

Either my controller is totaly borked or the driver doesn't totaly
like my PCI card.
When resyncing my md0 device, which is attached to the card, it stops
at 0.4%, gives lots of DMA timeouts and hde becomes unavailable.

Now, I attached the two drives to the onboard promise controller
(which had still one bus free) and all works fine, disks gets detected
properly (now testing with the legacy IDE drivers since that is what
at least detected my disks).


Patrick
