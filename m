From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC] ata/core: don't enable the interrupt while activating the
 host
Date: Wed, 07 Apr 2010 06:56:10 +0900
Message-ID: <4BBBADFA.10903@kernel.org>
References: <20100311220417.GA16022@Chamillionaire.breakpoint.cc> <4BAAAEA1.9040906@kernel.org> <20100325220421.GA1051@Chamillionaire.breakpoint.cc> <4BABF7CE.6060908@kernel.org> <20100406094535.GA30917@Chamillionaire.breakpoint.cc> <4BBB0641.3040500@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48017 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754662Ab0DFVw5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Apr 2010 17:52:57 -0400
In-Reply-To: <4BBB0641.3040500@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, linux-ide@vger.kernel.org

On 04/06/2010 07:00 PM, Sergei Shtylyov wrote:
>> ata_sff_check_status() does not report ATA_DRQ set so I don't know why
>> the interrupt is comming.
> 
>   Perhaps the drive incorrectly triggers interrupt on setting the nIEN
> bit -- some drives are known to do this; there is a blacklist of such
> drives in the IDE core so that it avoids setting nIEN bit for them.

Arghh.... that stinks.  Maybe we should port the list over?  What is
the ATA device in question here?

-- 
tejun
