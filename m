From: Tejun Heo <tj@kernel.org>
Subject: Re: Processes dying with ENXIO or EINTR - disk related?
Date: Wed, 11 Feb 2009 11:13:17 +0900
Message-ID: <4992343D.1040504@kernel.org>
References: <b895fb7dff47e49eee46d6bfc66b06e6.squirrel@www.datavault.us> <499229DF.50708@kernel.org> <49922CC2.8020705@seiner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58081 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952AbZBKCNI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Feb 2009 21:13:08 -0500
In-Reply-To: <49922CC2.8020705@seiner.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yan Seiner <yan@seiner.com>
Cc: linux-ide@vger.kernel.org

Yan Seiner wrote:
>> Highly unlikely it's related to IO.
>>   
> I was experimenting with nouveau, an xorg driver for nvidia hardware. 
> Turns out that driver left the scsi hardware in a weird state that was
> causing the segfaults.  A warm reboot wouldn't cure it; only a total
> power down and wait 30 seconds cycle did.  Machine stable since then.
> 
> At a guess something in the nouveau driver screwed up the scsi
> controller in the machine.

That's a scary story.  :-(

-- 
tejun
