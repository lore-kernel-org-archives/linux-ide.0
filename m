From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Port Multiplier access with Sil 3124
Date: Wed, 11 Feb 2009 22:16:32 -0600
Message-ID: <4993A2A0.7020606@gmail.com>
References: <498F42B6.8030607@tlinx.org>	 <87f94c370902090635h2fc3e604n990bdd70be9c48cd@mail.gmail.com>	 <4990AC91.8010104@tlinx.org> <87f94c370902091501h96ecb8dp7acac1fa80a82d8a@mail.gmail.com> <4990C70E.1010707@garzik.org> <4990D349.4050408@tlinx.org> <49923356.6050405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:42844 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbZBLEQh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Feb 2009 23:16:37 -0500
Received: by yw-out-2324.google.com with SMTP id 5so293038ywh.1
        for <linux-ide@vger.kernel.org>; Wed, 11 Feb 2009 20:16:35 -0800 (PST)
In-Reply-To: <49923356.6050405@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Linda Walsh <lkml@tlinx.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Tejun Heo wrote:
> Linda Walsh wrote:
>>     I also had a triple Seagate drive failure within 2 months,
>> two of them within a week -- and I did lose *backups* of my primary
>> drives!
> 
> My test disks go through a lot of unusual workloads which often
> include frequent emergency head unloads with immediately following
> spin up and Seagate has been the sturdiest for quite some time now.
> It's sad to hear that they're degressing.  :-(

It seems like most of the problems have been firmware and not 
mechanical, but a coworker did have a Seagate 7200.11 disk recently 
start getting SMART errors, which doesn't seem like any of the usual 
firmware symptoms that have been reported.

Went with a WD Caviar Black for a recent drive purchase instead.. 
hopefully Seagate will get their act together for the next models.
