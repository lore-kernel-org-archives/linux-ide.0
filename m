From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 6/6] Implement the AHCI suspend/resume
Date: Fri, 02 Jun 2006 17:34:23 +0900
Message-ID: <447FF80F.7030905@gmail.com>
References: <1149234379.13451.59.camel@forrest26.sh.intel.com> <447FF50E.4060609@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.199]:61092 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751331AbWFBIe3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jun 2006 04:34:29 -0400
Received: by nz-out-0102.google.com with SMTP id s18so475692nze
        for <linux-ide@vger.kernel.org>; Fri, 02 Jun 2006 01:34:29 -0700 (PDT)
In-Reply-To: <447FF50E.4060609@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, jeff@garzik.org, axboe@suse.de, jeremy@goop.org, lkml@rtr.ca, linux-ide@vger.kernel.org

Hannes Reinecke wrote:
> zhao, forrest wrote:
>> This patch implements the AHCI suspend/resume.
>> It puts the port suspend/resume operations in 
>> ahci_pci_device_suspend/resume(), which is in conformance with
>> Jeff's idea of host<->bus<->device suspend/resume sequence.
>>
>>
>> Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>
>>
> There is one quirky bit in here: we have to enable interrupts for the
> _adapter_ after all _devices_ have been re-initialized.
> This breaks the host<->bus<->device initialization sequence.
> Is there any chance libata can add some hooks for that sort of thing?
> The current approach (using a device map and run the host initialisation
> after the last device is done) is a bit hackish.
> I'd rather like to see the upper layers being able to deal with such
> devices. But until then:
> 

Working on it.  After quite some number of saying 'oh.. it's gonna be 
ready in a week' and then taking more than a month, I've pretty much 
given up specifying due date.  But, I'm on it.  :)

-- 
tejun
