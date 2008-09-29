From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA disk detect problem with silicon image 3132
Date: Mon, 29 Sep 2008 13:28:37 +0900
Message-ID: <48E05975.1030608@gmail.com>
References: <788014650809241914h46b153e0w6d88c2a1c8c65df3@mail.gmail.com>	 <48E032BA.10907@gmail.com>	 <788014650809282052q98e7b5bmd7b3bcf9ab9b4bf5@mail.gmail.com>	 <48E05184.9060706@gmail.com> <788014650809282112v56fe33b8gc5a0bbd2abe809a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:62475 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbYI2EaC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 00:30:02 -0400
Received: by ti-out-0910.google.com with SMTP id b6so838863tic.23
        for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2008 21:30:01 -0700 (PDT)
In-Reply-To: <788014650809282112v56fe33b8gc5a0bbd2abe809a7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: khchen@synology.com
Cc: linux-ide@vger.kernel.org

KueiHuan Chen wrote:
> Eh,  my 6145 using AHCI, not sata_mv. And it has the AHCI_HFLAG_NO_MSI
> flag. Is there any possible ?

Eh... right, 6145 is ahci.  Anyways, yeah, given that pci-e line
interrupts are emulated too, it's quite unlikely that IRQ delivery
gets broken only for sil24 but well I've seen weirder problems and the
failing log definitely looks like IRQ delivery problem.  Does irqpoll
help?

-- 
tejun
