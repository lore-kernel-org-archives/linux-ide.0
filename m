From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Question regarding FUA state
Date: Thu, 23 Jul 2009 00:06:38 -0600
Message-ID: <4A67FDEE.2090700@gmail.com>
References: <4A676332.6080205@ziu.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:17313 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbZGWGE1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jul 2009 02:04:27 -0400
Received: by an-out-0708.google.com with SMTP id d40so932361and.1
        for <linux-ide@vger.kernel.org>; Wed, 22 Jul 2009 23:04:27 -0700 (PDT)
In-Reply-To: <4A676332.6080205@ziu.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Soltys <soltys@ziu.info>
Cc: linux-ide@vger.kernel.org

On 07/22/2009 01:06 PM, Michal Soltys wrote:
> What is the current state of fua ?
>
> While peeking over older (mainly 2007ish) threads, there was some
> discussion about it - whenever it should or shouldn't be enabled by
> default, automatic blacklisting for certain controllers (some SiI 3xxx,
> others ...).
>
> http://marc.info/?l=git-commits-head&m=114110310308542&w=2
> http://marc.info/?t=117125096400001&r=2&w=2
> http://marc.info/?t=117193493900004&r=1&w=2
> http://marc.info/?t=118243369000005&r=1&w=2
>
> Current state is "disabled by default", but simple libata module
> parameter can enable it. How safe is that these days, and if enabled,
> will problematic chipsets be blacklisted automtically ? (I didn't find
> anything in the sources suggesting it happens, but I didn't look too
> thoroughly either).
>
> How do the following chipsets handle it:
>
> - ICH8R and newer ones
> - ATI's SB700/SB800 ones
> - JMB36x
> - which (if any) SiI chipsets are ok

AFAIK the only chipset that is known to have any problems are the SiI 
311x, specifically with non-NCQ FUA writes (well, this chipset doesn't 
do NCQ anyway). In its case it seems to be because that chipset 
interprets the ATA command code in order to figure out what protocol is 
being used and it doesn't seem to know about the WRITE DMA FUA opcode. 
Looking at the docs it appears that the driver could work around this by 
issuing some vendor-specific commands to set the protocol for that 
command, but that code isn't currently in place.

Anything AHCI shouldn't care as the controller is not supposed to be 
interpreting the command code. It's possible that other SFF-type SATA 
controllers could have issues if they don't know about the FUA opcode.
