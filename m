From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/11] libata-eh: implement ata_ering
Date: Mon, 15 May 2006 23:25:45 +0900
Message-ID: <44688F69.8030002@gmail.com>
References: <11473536871340-git-send-email-htejun@gmail.com>	 <44665AAB.7000806@pobox.com> <44666D98.1000503@gmail.com>	 <44668249.9000004@pobox.com> <446685D1.4030607@gmail.com>	 <446688C8.6020001@pobox.com> <1147700193.26686.7.camel@localhost.localdomain> <44688991.8010407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:7723 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964943AbWEOO0L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 10:26:11 -0400
Received: by nz-out-0102.google.com with SMTP id 12so913nzp
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 07:26:01 -0700 (PDT)
In-Reply-To: <44688991.8010407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Alan Cox wrote:
>> On Sad, 2006-05-13 at 21:32 -0400, Jeff Garzik wrote:
>>> I would just declare that all erings have 32 entries, and revisit the 
>>> issue if/when pain appears.  Hardcode 32, and make things easy.
>> Do we even need the ering. If you classify the error when it occurs it
>> seems all you need is a couple of 32bit words and to set bits and
>> shift ?
>>
> 
> Hmmm.. yeah, that sounds good.  Jeff, what do you think?
> 

I was too quick to response.  ering keeps track of timestamps of each
error and the criteria for speeding down is something like "3 class 1
errors during last 15mins", so bitmaps doesn't cut it.

-- 
tejun
