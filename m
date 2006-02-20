From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: increase LBA48 max sectors to 65535
Date: Mon, 20 Feb 2006 06:23:20 -0500
Message-ID: <43F9A6A8.4020606@pobox.com>
References: <1139754779159-git-send-email-htejun@gmail.com> <43EF8E61.5040409@pobox.com> <43EFD73D.4070207@gmail.com> <43F011DF.6020203@pobox.com> <20060215072449.GA31691@htj.dyndns.org> <20060215130725.GP4203@suse.de> <43F342E6.9060909@gmail.com> <20060215151200.GW4203@suse.de> <43F38D49.4080601@pobox.com> <43F3B3CE.5060105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:60115 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932569AbWBTLXl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 06:23:41 -0500
In-Reply-To: <43F3B3CE.5060105@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>> As an aside, I wonder if the PRD limit is unnecessarily low.  I don't 
>> remember seeing anything that claimed we were limited to 256 s/g 
>> entries in the old IDE docs?

> Well, originally I wrote ide-dma.c with a 256 PRD limit,
> because that corresponds to the absolute worst case of
> only one sector per PRD.  The pre-LBA48 protocol cannot
> read/write more than that with a single command.
> 
> But nowadays..


Indeed.  I am paranoid about controllers assuming that no more than 256 
PRD entries will be submitted.  But I have never seen any document that 
says PCI IDE BMDMA hardware can -only- do 256 PRD entries.  Never tested 
it, either...

	Jeff


