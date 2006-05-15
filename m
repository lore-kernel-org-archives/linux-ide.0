From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/11] libata-eh: implement ata_ering
Date: Tue, 16 May 2006 00:19:22 +0900
Message-ID: <44689BFA.2020705@gmail.com>
References: <11473536871340-git-send-email-htejun@gmail.com>	 <44665AAB.7000806@pobox.com> <44666D98.1000503@gmail.com>	 <44668249.9000004@pobox.com> <446685D1.4030607@gmail.com>	 <446688C8.6020001@pobox.com>	 <1147700193.26686.7.camel@localhost.localdomain>	 <44688991.8010407@gmail.com>  <44688F69.8030002@gmail.com>	 <1147704657.26686.49.camel@localhost.localdomain>	 <446896D0.7060309@gmail.com> <1147706380.26686.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:61219 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964978AbWEOPT3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 11:19:29 -0400
Received: by wr-out-0506.google.com with SMTP id i32so874572wra
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 08:19:28 -0700 (PDT)
In-Reply-To: <1147706380.26686.59.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Alan Cox wrote:
>> little bit more complex (it has more moving parts) and it would be
>> difficult to define/tune speed down or any other error handling (say,
>> turning off NCQ) criteria.  But, I might be planning too much.
> 
> The log problem is that you can get 32 errors very fast (doesn't take
> much with multiple outstanding commands)

The current EH implementation records one error per EH run.  It just
combines all failed commands and record it as single entry.  As each EH
run usually takes at least several seconds, 32 slots should give several
minutes worth of history even if things are pretty bad.

> so you have to choose which
> info to throw away - the history or the detail in the commands 

Yeap.  And I also agree that ering is pretty inefficient way to spend
512 bytes of memory.

-- 
tejun
