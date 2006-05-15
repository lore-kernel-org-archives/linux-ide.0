From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/11] libata-eh: implement ata_ering
Date: Mon, 15 May 2006 14:22:03 -0400
Message-ID: <4468C6CB.5090504@pobox.com>
References: <11473536871340-git-send-email-htejun@gmail.com>	 <44665AAB.7000806@pobox.com> <44666D98.1000503@gmail.com>	 <44668249.9000004@pobox.com> <446685D1.4030607@gmail.com>	 <446688C8.6020001@pobox.com>	 <1147700193.26686.7.camel@localhost.localdomain>	 <44688991.8010407@gmail.com>  <44688F69.8030002@gmail.com>	 <1147704657.26686.49.camel@localhost.localdomain>	 <446896D0.7060309@gmail.com> <1147706380.26686.59.camel@localhost.localdomain> <44689BFA.2020705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53188 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965100AbWEOSWN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 14:22:13 -0400
In-Reply-To: <44689BFA.2020705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Alan Cox wrote:
>>> little bit more complex (it has more moving parts) and it would be
>>> difficult to define/tune speed down or any other error handling (say,
>>> turning off NCQ) criteria.  But, I might be planning too much.
>> The log problem is that you can get 32 errors very fast (doesn't take
>> much with multiple outstanding commands)
> 
> The current EH implementation records one error per EH run.  It just
> combines all failed commands and record it as single entry.  As each EH
> run usually takes at least several seconds, 32 slots should give several
> minutes worth of history even if things are pretty bad.
> 
>> so you have to choose which
>> info to throw away - the history or the detail in the commands 
> 
> Yeap.  And I also agree that ering is pretty inefficient way to spend
> 512 bytes of memory.

Overall its not a huge issue.  As long as we aren't constantly
allocating and freeing that 512 bytes...

	Jeff



