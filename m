From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFC,PATCHSET] Managed device resources
Date: Mon, 08 Jan 2007 13:07:03 +0900
Message-ID: <45A1C367.5040005@gmail.com>
References: <1167146313307-git-send-email-htejun@gmail.com> <20070104221916.GI28445@suse.de> <459D7F23.7010807@garzik.org> <20070104223247.GA29274@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:9419 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030480AbXAHEHK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jan 2007 23:07:10 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7903043wxd
        for <linux-ide@vger.kernel.org>; Sun, 07 Jan 2007 20:07:10 -0800 (PST)
In-Reply-To: <20070104223247.GA29274@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Greg KH wrote:
> On Thu, Jan 04, 2007 at 05:26:43PM -0500, Jeff Garzik wrote:
>> Greg KH wrote:
>>> Hm, but I guess without the follow-up patches for libata, it will not
>>> really get tested much.  Jeff, if I accept this, what's your feelings of
>>> letting libata be the "test bed" for it?
>>
>> It would be easiest for me to merge this through my 
>> libata-dev.git#upstream tree.  That will auto-propagate it to -mm, and 
>> ensure that both base and libata bits are sent in one batch.
>>
>> Just shout if you see NAK-able bits...
>>
>> Work for you?
> 
> That works for me.

Great, I'll push it through Jeff.

> The only question I have is on the EXPORT_SYMBOL() stuff for the new
> driver/base/ functions.  Tejun, traditionally the driver core has all
> exported symbols marked with EXPORT_SYMBOL_GPL().  So, any objection to
> marking the new ones (becides the "mirror" functions) in this manner?

Okay, will do so.

Thanks.

-- 
tejun
