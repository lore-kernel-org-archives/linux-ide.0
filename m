From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] HPA support: Revised patch
Date: Thu, 05 Apr 2007 16:30:08 -0400
Message-ID: <46155C50.8000003@garzik.org>
References: <20070405141352.12fddb6e@the-village.bc.nu>	<20070405192421.GB5131@lug-owl.de> <20070405211804.1f64e515@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1767300AbXDEUax@vger.kernel.org>
In-Reply-To: <20070405211804.1f64e515@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kyle@canonical.com
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
>>> +static int ata_ignore_hpa = 0;
>>> +module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
>>> +MODULE_PARM_DESC(ignore_hpa, "Ignore HPA (0=off 1=on)");
>>> +
>>>  static int ata_probe_timeout = ATA_TMOUT_INTERNAL / HZ;
>>>  module_param(ata_probe_timeout, int, 0444);
>>>  MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
>> For ignore_hpa, it would be nice to not go through inverse logic and
>> fix the help text a bit (0=honor HPA, 1=ignore HPA).
> 
> Umm.. how about  "preserve_hpa" ?

I think he meant fix the help text?

Regardless, it should be "ignore_hpa" as you have it now, though I feel 
the help text requires additional human brain parsing, and could be more 
clear.

	Jeff
