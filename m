From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: CF Card Adapter White List Candidate
Date: Tue, 04 Jan 2011 22:19:17 -0600
Message-ID: <4D23F145.10902@gmail.com>
References: <499061.38397.qm@web112020.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44927 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab1AEETU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2011 23:19:20 -0500
Received: by iwn9 with SMTP id 9so14903543iwn.19
        for <linux-ide@vger.kernel.org>; Tue, 04 Jan 2011 20:19:19 -0800 (PST)
In-Reply-To: <499061.38397.qm@web112020.mail.gq1.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Denchfield <td_denchfield@yahoo.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On 01/04/2011 04:18 PM, Tom Denchfield wrote:
> Tejun,
>
> Using your first recommendation in your 01/04/2010 email, I added libata.force=80c to the Ubuntu v10.10 Live CD (Live-CD) kernel command line, and this succeeded in getting Linux to configure my CompactFlash card as UDMA/66, as opposed to the UDMA/33 it had been using.  The attached dmesg_libata_force_80c.txt (dmesg) file shows the details of doing a warm boot with the LiveCD on my desktop computer that did not have Ubuntu installed on it.
>
> As you further recommended, in an attempt to get the SD-CF-IDE-DI IDE to CF Adapter that holds my CF card white listed, I am submitting the attached libata_force_80c_CF_card_adapter_whitelist_candidate_information.txt file that has the output from executing four terminal commands to hopefully supply enough information to get it whitelisted.
>
> Although I expect that my RV280 Radeon 9200 Pro video card is too old to expend much effort on, it would be nice to also get it whitelisted so that future newbie Linux users who do not know about using the radeon.modeset=0 parameter on the kernel command line will not be looking at a black screen with a blinking cursor when they attempt to use a LiveCD for troubleshooting, or whatever.
>
> I purposely did not include the URL of one of the Internet sites that sells the adapter in this email in case this is a no no.
>
> If you or someone else needs more information in order to get the CF card adapter whitelisted, they can send me an email with further instructions.
>
> Tejun, I am not sure that I will have either the time or the interest to learn the intricacies of editing http://www.thinkwiki.org/wiki/Compact_Flash_boot_drive to add libata.force=80c to this site in lieu of force_cbl=80: so that fewer people will be asking you questions.  I have a ThinkPad without a HDD plus a laptop adapter that will hold my CF card, but my Think Pad is a lot older than the ones discussed on Compact_Flash_boot_drive.  In addition, I did not see any recent updates to this Internet page, but maybe I can find someone to email who will update this page.
>
> Tejun, thank you very much for helping me.

Is there actually any way to identify the adapter automatically? AFAIK, 
these CF-IDE adapters are just passive circuitry and there's no way to 
identify them through software.
