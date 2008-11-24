From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] ata: Remove inline attribute from ata_sff_host_intr()
Date: Mon, 24 Nov 2008 09:21:20 -0800
Message-ID: <492AE290.8020207@caviumnetworks.com>
References: <49260327.8050408@caviumnetworks.com> <492A39A7.4080703@kernel.org> <492A3EB2.8070504@shaw.ca> <492A404D.1010107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:58069 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbYKXRVn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 12:21:43 -0500
In-Reply-To: <492A404D.1010107@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockr@shaw.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Robert Hancock wrote:
>> Tejun Heo wrote:
>>> David Daney wrote:
>>>> ata: Remove inline attribute from ata_sff_host_intr()
>>>>
>>>> ata_sff_host_intr is a public function, it should not be declared
>>>> inline.
>>> Why not?
>>>
>> Well, it's a bit unusual to have a non-static inline (an exported symbol
>> no less) in a C file.. how could any callers outside the file ever
>> actually inline it? Aside from that it seems a bit big for inlining..
> 
> The goal there is to inline ata_sff_host_intr() into ata_sff_interrupt()
> and then export a separate copy to other users as ata_sff_interrupt() is
> very hot.  Looking at the disassembly, gcc is doing what it's told to
> do, so the inline actually is doing something useful there.
> 

Have you actually profiled it both ways?

I was assuming that the function used to be 'static inline' and that the 
inline was some sort of typo left over from when static might have been 
removed.

In any event, do with it what you wish, it just looked weird to me.

David Daney
