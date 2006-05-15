From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/11] libata-eh: implement ata_ering
Date: Mon, 15 May 2006 23:00:49 +0900
Message-ID: <44688991.8010407@gmail.com>
References: <11473536871340-git-send-email-htejun@gmail.com>	 <44665AAB.7000806@pobox.com> <44666D98.1000503@gmail.com>	 <44668249.9000004@pobox.com> <446685D1.4030607@gmail.com>	 <446688C8.6020001@pobox.com> <1147700193.26686.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.203]:40158 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964916AbWEOOBA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 10:01:00 -0400
Received: by nz-out-0102.google.com with SMTP id 18so101810nzp
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 07:01:00 -0700 (PDT)
In-Reply-To: <1147700193.26686.7.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Sad, 2006-05-13 at 21:32 -0400, Jeff Garzik wrote:
>> I would just declare that all erings have 32 entries, and revisit the 
>> issue if/when pain appears.  Hardcode 32, and make things easy.
> 
> Do we even need the ering. If you classify the error when it occurs it
> seems all you need is a couple of 32bit words and to set bits and
> shift ?
> 

Hmmm.. yeah, that sounds good.  Jeff, what do you think?

-- 
tejun
