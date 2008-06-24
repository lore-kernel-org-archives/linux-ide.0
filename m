From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC] Separating out libata out of SCSI (finally)
Date: Wed, 25 Jun 2008 00:49:02 +0900
Message-ID: <4861176E.8040008@kernel.org>
References: <485B2CC6.6070201@kernel.org>	 <1213993737.3443.35.camel@localhost.localdomain>	 <485C31FE.8050408@garzik.org>	 <87f94c370806231404t13586777x7f7bee24ebe25ffc@mail.gmail.com>	 <1214255460.3310.27.camel@localhost.localdomain>	 <4860B099.2030305@panasas.com> <1214318550.3299.7.camel@localhost.localdomain> <48610BDC.6090101@kernel.org> <486115DE.20805@ij.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52088 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559AbYFXPtQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jun 2008 11:49:16 -0400
In-Reply-To: <486115DE.20805@ij.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Felix Miata <mrmazda@ij.net>
Cc: linux-ide@vger.kernel.org

Felix Miata wrote:
> On 2008/06/24 23:59 (GMT+0900) Tejun Heo apparently typed:
> 
>> I'm currently working on a scheme where partitions above gd->minors get
>> allocated dynamic MAJ:MIN.  It looks like it can be done mostly in block
>> layer proper.  The only problem I can foresee is not being able to
>> specify MAJ:MIN as root device but that shouldn't be a major problem.
>> I'll report back when I make more progress.
> 
> Please correct me if I'm wrong, but on the following, would it not
> be a major problem booting, without deleting any existing or moving
> any existing, with only a few more upgrade cycles to replace what's
> there installed now with current and near future distros?

I'm not sure what you mean.  If you switch to libata now, you'll only be
able to see 15 partitions, so, yes, you'll have problem updating to a
distro which uses libata now and in near future.  If the dynamic
partition thing goes well, hopefully the next major distro releases work
fine.

-- 
tejun
