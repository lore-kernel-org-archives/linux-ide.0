From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ATA errors corrupt other I/O & set / readonly
Date: Sat, 19 May 2012 17:28:26 -0600
Message-ID: <4FB82C9A.9020508@gmail.com>
References: <4FA0F76E.3050509@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57037 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754903Ab2ESX23 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 May 2012 19:28:29 -0400
Received: by obbtb18 with SMTP id tb18so5956115obb.19
        for <linux-ide@vger.kernel.org>; Sat, 19 May 2012 16:28:29 -0700 (PDT)
In-Reply-To: <4FA0F76E.3050509@earthlink.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Felix Miata <mrmazda@earthlink.net>
Cc: linux-ide@vger.kernel.org

On 05/02/2012 02:59 AM, Felix Miata wrote:
> Two weeks ago on recommendation of downstream bug owner I filed
> https://bugzilla.kernel.org/show_bug.cgi?id=43128 expecting to see some
> kind of non-delayed reaction from someone either in the bug or here, and
> am quite disappointed that nothing has yet happened. Is the bug's owner
> sick, on holiday, or at a convention?
>
> I originally resisted filing because I believe that actual problem is
> the device's and not kernel or drivers. Yet, that it is possible for any
> such device failure to cause system corruption doesn't seem right
> either. So, can someone please comment on the likelihood that this bug
> can or will be fixed? I would like someone to respond here or in the bug
> before proceeding to try again to convince the manufacturer its product
> is defective and get a refund instead of yet another replacement of a
> defective product with another defective product.
>
> Once I return it for refund I will no longer be able to follow up on the
> bugs I filed, yet I need a working device that doesn't require I figure
> out a correct cmdline workaround for every one of the several systems it
> ever needs to be connected to.
>
> Please, what should I do?

It's hard to follow the discussion in the openSUSE bug report. I'm not 
sure if there was any dmesg posted from the case where other IO was 
being interfered with by the problems with the external device. In AHCI 
mode that really shouldn't happen, but in IDE mode on Intel controllers 
it may be more possible because of the PATA emulation that's effectively 
being done by the controller.

It's not possible to put in a blacklist entry for a specific SATA 
enclosure because they're essentially a passive device and there's no 
way to identify them through software (unless they have a custom ID 
string like the WD MyBook drives). If it only works properly at 1.5 Gbps 
then a module/boot parameter may be the best solution.
