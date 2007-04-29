From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/13] libata-acpi: clean up parameters and misc stuff
Date: Sun, 29 Apr 2007 11:54:07 +0900
Message-ID: <463408CF.1060200@gmail.com>
References: <11772636663949-git-send-email-htejun@gmail.com> <463398B4.1010004@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <463398B4.1010004@garzik.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> This patch cleans up libata-acpi such that it looks similar to other
>> libata files.  This patch doesn't introuce any behavior changes.
>>
>> * make libata-acpi functions take ata_device instead of ata_port +
>>   device index
>> * s/atadev/adev/
>> * de-indent local variable declarations
> 
> I prefer 'dev' over 'adev', unless that makes the code in question more
> ambiguous.

Alan is preferring adev over dev and I thought that might be better in
the spirit of 'ap'.  I don't really care about the naming tho.  Will
convert to dev.  It won't increase ambiguity.

-- 
tejun
