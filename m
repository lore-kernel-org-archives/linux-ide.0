From: Tejun Heo <htejun@gmail.com>
Subject: Re: CF Card Adapter White List Candidate
Date: Wed, 5 Jan 2011 03:51:28 -0800
Message-ID: <20110105115128.GA7778@mtj.dyndns.org>
References: <499061.38397.qm@web112020.mail.gq1.yahoo.com>
 <4D23F145.10902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44250 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab1AELvg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2011 06:51:36 -0500
Received: by yxt3 with SMTP id 3so5965738yxt.19
        for <linux-ide@vger.kernel.org>; Wed, 05 Jan 2011 03:51:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D23F145.10902@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tom Denchfield <td_denchfield@yahoo.com>, linux-ide@vger.kernel.org

Hello,

On Tue, Jan 04, 2011 at 10:19:17PM -0600, Robert Hancock wrote:
> On 01/04/2011 04:18 PM, Tom Denchfield wrote:
>> As you further recommended, in an attempt to get the SD-CF-IDE-DI
>> IDE to CF Adapter that holds my CF card white listed, I am
>> submitting the attached
>> libata_force_80c_CF_card_adapter_whitelist_candidate_information.txt
>> file that has the output from executing four terminal commands to
>> hopefully supply enough information to get it whitelisted.

Thanks.

>> Although I expect that my RV280 Radeon 9200 Pro video card is too
>> old to expend much effort on, it would be nice to also get it
>> whitelisted so that future newbie Linux users who do not know about
>> using the radeon.modeset=0 parameter on the kernel command line
>> will not be looking at a black screen with a blinking cursor when
>> they attempt to use a LiveCD for troubleshooting, or whatever.
>>
>> I purposely did not include the URL of one of the Internet sites
>> that sells the adapter in this email in case this is a no no.

I don't think that's a no no unless the intention is commercial.

>> Tejun, I am not sure that I will have either the time or the
>> interest to learn the intricacies of editing
>> http://www.thinkwiki.org/wiki/Compact_Flash_boot_drive to add
>> libata.force=80c to this site in lieu of force_cbl=80: so that
>> fewer people will be asking you questions.  I have a ThinkPad
>> without a HDD plus a laptop adapter that will hold my CF card, but
>> my Think Pad is a lot older than the ones discussed on
>> Compact_Flash_boot_drive.  In addition, I did not see any recent
>> updates to this Internet page, but maybe I can find someone to
>> email who will update this page.

Yeah, just ping someone.

> Is there actually any way to identify the adapter automatically?
> AFAIK, these CF-IDE adapters are just passive circuitry and there's
> no way to identify them through software.

Hmmm... I was thinking this was somehing integrated to the machine (so
the dmidecode), in which case we can combine dmi + pci function # +
port # to whitelist the device, which we already do for some type of
quirks.  If it's a plug in device, we obviously can't identify it.
Tom, is the CF slot integrated to the machine or is it something you
put into the PCMCIA slot?

Thanks.

-- 
tejun
