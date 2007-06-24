From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: hsm violation
Date: Sun, 24 Jun 2007 13:42:01 -0600
Message-ID: <467EC909.9040006@shaw.ca>
References: <fa.sspu6LOivd/touNtS2IsMKPqHa0@ifi.uio.no>
 <fa.19XJG1Asdp1zwcWLxolIH6F+5lY@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:65235 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbXFXTmI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Jun 2007 15:42:08 -0400
In-reply-to: <fa.19XJG1Asdp1zwcWLxolIH6F+5lY@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: enricoss@tiscali.it, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

Andrew Morton wrote:
> On Sun, 24 Jun 2007 14:32:22 +0200 Enrico Sardi <enricoss@tiscali.it> wrote:
>> [   61.176000] ata1.00: exception Emask 0x2 SAct 0x2 SErr 0x0 action 0x2 
>> frozen
>> [   61.176000] ata1.00: (spurious completions during NCQ issue=0x0 
>> SAct=0x2 FIS=005040a1:00000004)

..

> 
> It's not obvious (to me) whether this is a driver bug, a hardware bug,
> expected-normal-behaviour or what - those diagnostics (which we get to
> see distressingly frequently) are pretty obscure.

The spurious completions during NCQ error is indicating that the drive 
has indicated it's completed NCQ command tags which weren't outstanding. 
  It's normally a result of a bad NCQ implementation on the drive. 
Technically we can live with it, but it's rather dangerous (if it 
indicates completions for non-outstanding commands, how do we know it 
doesn't indicate completions for actually outstanding commands that 
aren't actually completed yet..)

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

