From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC] Separating out libata out of SCSI (finally)
Date: Wed, 25 Jun 2008 01:35:58 +0900
Message-ID: <4861226E.8050900@kernel.org>
References: <485B2CC6.6070201@kernel.org>	 <1213993737.3443.35.camel@localhost.localdomain>	 <485C31FE.8050408@garzik.org>	 <87f94c370806231404t13586777x7f7bee24ebe25ffc@mail.gmail.com>	 <1214255460.3310.27.camel@localhost.localdomain>	 <4860B099.2030305@panasas.com> <1214318550.3299.7.camel@localhost.localdomain> <48610BDC.6090101@kernel.org> <486115DE.20805@ij.net> <4861176E.8040008@kernel.org> <48612078.3000905@ij.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40678 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057AbYFXQgK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jun 2008 12:36:10 -0400
In-Reply-To: <48612078.3000905@ij.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Felix Miata <mrmazda@ij.net>
Cc: linux-ide@vger.kernel.org

Felix Miata wrote:
>> distro which uses libata now and in near future.  If the dynamic
>> partition thing goes well, hopefully the next major distro releases work
>> fine.
> 
> I responded as I did due to your statement "only problem I can foresee is not
> being able to specify MAJ:MIN as root device", hoping to see some elaboration
> on the statement from you. I read your statement as "don't expect to be able
> to use any partition >15 as a root device". So, in the past root=3:17 would
> have been a valid replacement for root =/dev/hda17? If so, sorry for the
> noise, as I'd never seen that type of usage, and certainly would not miss it.

Oh.. the name, say, root=/dev/sda999 should work (well, that's the plan)
but as there will be no fixed mapping between /dev/sdaN and MAJ:MIN when
N > 15, root=MAJ:MIN just isn't possible for dynamically allocated ones.
 I hope it clarified things a bit.

Thanks.

-- 
tejun
