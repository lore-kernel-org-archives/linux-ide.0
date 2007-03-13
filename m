From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 03/12] libata: separate out ata_host_alloc() and ata_host_attach()
Date: Tue, 13 Mar 2007 15:06:02 +0900
Message-ID: <45F63F4A.9090607@gmail.com>
References: <11734389353424-git-send-email-htejun@gmail.com> <45F5D35C.6000408@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:22538 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbXCMGGJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 02:06:09 -0400
Received: by ug-out-1314.google.com with SMTP id 44so145936uga
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 23:06:08 -0700 (PDT)
In-Reply-To: <45F5D35C.6000408@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: brking@linux.vnet.ibm.com
Cc: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Hello, Brian.

Brian King wrote:
> Tejun Heo wrote:
>> * ipr is now the only user of ata_host_init().  Either kill it by
>>   converting ipr to use ata_host_alloc() and friends or rename and
>>   move it to libata-scsi.c
> 
> One of the problems with converting ipr to use ata_host_alloc and
> friends is that it then forces ipr to tell libata how many "SATA ports"
> are possible. On SAS, this number can't really be calculated, since
> the maximum number of SATA devices which can possibly be cabled to a
> SAS adapter, particularly with SAS expanders, is a very large number
> and is not practical for how this is being used in the current
> implementation. My guess is that aic94xx will have similar issues/concerns.

I dunno much about SAS integration, so I intentionally left it alone, so
this patchset shouldn't change behavior from SAS's point of view.
Making host->ports dynamic isn't difficult at all.  We can just separate
out the ports[] array and make it rcu and supply a few access helpers so
that we can adjust its size dynamically.

Association to SCSI host is done via pointer now even for native ATA
case, so this should be easier for SAS.  What I'm worried about is how
EH gets invoked.  libata depends on EH to do a lot of things including
probing, requesting sense data, etc.  How should this work?  SAS
attached libata port shares EH with the SAS SCSI host, right?  How can
we connect SAS EH with libata EH and would it be okay for libata EH hold
the SCSI EH (thus holding all command execution on the host) to handle
ATA exceptions?

Thanks.

-- 
tejun
