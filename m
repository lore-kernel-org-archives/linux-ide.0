From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
     fails: libata issue
Date: Sun, 28 May 2006 06:41:45 +0900
Message-ID: <4478C799.8000207@gmail.com>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <4478C39A.9060302@garzik.org> <20060527213333.GA32007@suse.de> <4478C5FE.1090306@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:19299 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964967AbWE0Vl6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 May 2006 17:41:58 -0400
Received: by py-out-1112.google.com with SMTP id e30so191822pya
        for <linux-ide@vger.kernel.org>; Sat, 27 May 2006 14:41:58 -0700 (PDT)
In-Reply-To: <4478C5FE.1090306@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Jens Axboe wrote:
>> On Sat, May 27 2006, Jeff Garzik wrote:
>>>> +    msleep(500);
>>>>     pci_set_power_state(pdev, PCI_D0);
>>>>     pci_restore_state(pdev);
>>>>     pci_enable_device(pdev);
>>> Does it work if you move msleep() below pci_restore_state()?
>>> "    "     "    "      below pci_enable_device()?
>>
>> Placement makes no difference here, it works after pci_enable_device()
>> as well. What matters is the delay coming before the ata_busy_wait().
>> You could just stuff it in front of that, if you wanted.
> 
> That would increase the wait needlessly, since it would be then done 
> per-device, even though the devices spin up in parallel on ata_piix.
> 

This sounds a lot like hotplug spinup-wait case.  Are those harddisks 
PATA or SATA?  Also, I think this can be handled better by EH.  ie. 
register it as hotplug event -> wait for spin up if necessary -> reset & 
revalidate.

-- 
tejun
