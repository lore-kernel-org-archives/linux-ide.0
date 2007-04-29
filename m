From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 06/13] libata-acpi: clean up parameters and misc stuff
Date: Sat, 28 Apr 2007 23:12:57 -0400
Message-ID: <46340D39.9030001@garzik.org>
References: <11772636663949-git-send-email-htejun@gmail.com> <463398B4.1010004@garzik.org> <463408CF.1060200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <463408CF.1060200@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> This patch cleans up libata-acpi such that it looks similar to other
>>> libata files.  This patch doesn't introuce any behavior changes.
>>>
>>> * make libata-acpi functions take ata_device instead of ata_port +
>>>   device index
>>> * s/atadev/adev/
>>> * de-indent local variable declarations
>> I prefer 'dev' over 'adev', unless that makes the code in question more
>> ambiguous.
> 
> Alan is preferring adev over dev and I thought that might be better in
> the spirit of 'ap'.  I don't really care about the naming tho.  Will
> convert to dev.  It won't increase ambiguity.

Cool.  You will see 'dev' used universally in the code I wrote.  It also 
matches well with "ata_dev_" prefixes, which are a bit better than 
"ata_adev_" prefix if one were to apply the alternate policy.

Yes, I sometimes spend way too much time pay attention to trivialities :)

	Jeff



