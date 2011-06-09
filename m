From: Tim Small <tim@seoss.co.uk>
Subject: Re: WRITE DMA EXT failures with JM20330 based sata2ide
Date: Thu, 09 Jun 2011 20:38:25 +0100
Message-ID: <4DF12131.1070507@seoss.co.uk>
References: <isj7ql$4fh$1@dough.gmane.org> <BANLkTimuGOGxJgKJsxUc6ACzEcZwgQuTWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay0.allsecurenet.com ([109.169.27.60]:50933 "EHLO
	relay0.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685Ab1FITi3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jun 2011 15:38:29 -0400
In-Reply-To: <BANLkTimuGOGxJgKJsxUc6ACzEcZwgQuTWw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Cc: linux-ide@vger.kernel.org

On 09/06/11 15:31, Tejun Heo wrote:
> Hello,
>
> On Mon, Jun 6, 2011 at 8:51 PM, Manuel Reimer
> <Manuel.Spam@nurfuerspam.de> wrote:
>   
>> I've converted a 1,5TB SATA drive to IDE to run it on a UDMA100 IDE
>> controller.
>>     
> You're having a genuine transmission problem and I think
> fixing the underlying hardware issue would be the better choice than
> mucking with EH behaviors.
>   

FWIW, I've played with three different makes and models of SATA<->PATA
bridges at one time or another, and only one of them actually worked
reliably with hard drives - all seemed to be OK with optical drives, but
I assume that was down to their lower transmission speeds / throughput.

If you have any PCI or PCIe slots available, then you may be better off
buying a cheap add-in SATA controller instead (e.g. Silicon Image 3132,
or second-hand 3124, or Marvell 88SExxxx).

Cheers,

Tim.

-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.  
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

