From: Yan Seiner <yan@seiner.com>
Subject: Re: Processes dying with ENXIO or EINTR - disk related?
Date: Tue, 10 Feb 2009 17:41:22 -0800
Message-ID: <49922CC2.8020705@seiner.com>
References: <b895fb7dff47e49eee46d6bfc66b06e6.squirrel@www.datavault.us> <499229DF.50708@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from flatoutfitness.com ([66.178.130.209]:40711 "EHLO www.seiner.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbZBKBlX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Feb 2009 20:41:23 -0500
In-Reply-To: <499229DF.50708@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Yan Seiner wrote:
>   
>> Recently I've started getting system freezeups and weird segfaults with
>> EINTR (Interrupted system call) and ENXIO (No such device or address).
>>
>> These errors can be in ld, libc, and so on.  I'm stumped; the system has
>> worked fine for quite a while and just recently has developed this
>> behavior.  I can start yanking out hardware, but before I do that I wonder
>> if it is something to do with disk access.  I'm a bit stumped as to what
>> else could cause ENXIO on loading an app....  Needless to say there aren't
>> any errors at all anywhere that I can find, so I am guessing.
>>     
>
> Highly unlikely it's related to IO.
>   
I was experimenting with nouveau, an xorg driver for nvidia hardware.  
Turns out that driver left the scsi hardware in a weird state that was 
causing the segfaults.  A warm reboot wouldn't cure it; only a total 
power down and wait 30 seconds cycle did.  Machine stable since then.

At a guess something in the nouveau driver screwed up the scsi 
controller in the machine.

