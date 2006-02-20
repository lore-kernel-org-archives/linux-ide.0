From: Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] libata: increase LBA48 max sectors to 65535
Date: Mon, 20 Feb 2006 08:54:24 -0500
Message-ID: <43F9CA10.8000206@pobox.com>
References: <1139754779159-git-send-email-htejun@gmail.com> <43EF8E61.5040409@pobox.com> <43EFD73D.4070207@gmail.com> <43F011DF.6020203@pobox.com> <20060215072449.GA31691@htj.dyndns.org> <20060215130725.GP4203@suse.de> <43F342E6.9060909@gmail.com> <20060215151200.GW4203@suse.de> <43F38D49.4080601@pobox.com> <43F3B3CE.5060105@pobox.com> <43F9A6A8.4020606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx3.magma.ca ([206.191.0.239]:42451 "EHLO mx3.magma.ca")
	by vger.kernel.org with ESMTP id S1030229AbWBTNyh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 08:54:37 -0500
In-Reply-To: <43F9A6A8.4020606@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>
> Indeed.  I am paranoid about controllers assuming that no more than 256 
> PRD entries will be submitted.  But I have never seen any document that 
> says PCI IDE BMDMA hardware can -only- do 256 PRD entries.  Never tested 
> it, either...

The hardware vendors I have worked with have never had any limit
on PRD count -- they'd happily keep reading through an infinite
list of PRDs if we could supply one.

A number of them did have issues with 64KB boundary crossings,
and it is generally VERY unsafe to have a single PRD "wrap"
into a fresh 64KB segment mid-stride.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
