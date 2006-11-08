From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_vsc: Add MSI support to sata_vsc driver (resubmit)
 (fixed attachment)
Date: Wed, 08 Nov 2006 08:22:58 -0500
Message-ID: <4551DA32.9040801@garzik.org>
References: <4396600.1162858354272.JavaMail.?@fh1037.dia.cp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47748 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965722AbWKHNXB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2006 08:23:01 -0500
In-Reply-To: <4396600.1162858354272.JavaMail.?@fh1037.dia.cp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "daniel@wolstenholme.net" <daniel@wolstenholme.net>
Cc: linux-ide@vger.kernel.org

daniel@wolstenholme.net wrote:
>> Wolstenholme, Daniel E wrote:
>>> Ok, hopefully I can get the attachment right here.
>>>
>>> Here's a resubmission of my MSI patch for the sata_vsc driver.
>>>
>>> I've added a new vsc_sata_host_priv data structure (basically copied
>>> from the sata_mv driver) which has an hp_flags bitfield with a bit to
>>> indicate whether MSI is being used. This is used in the new
>>> vsc_sata_host_stop() routine to call
>>> pci_disable_msi() if MSI is on, pci_intx() if not.
>>>
>>> Signed-off-by: Daniel Wolstenholme <daniel.e.wolstenholme@intel.com>
>> ACK the patch technical content.
>>
>> Unfortunately, the patch was corrupted, and tabs were converted to 
>> spaces, which makes it impossible to apply the patch.apply the patch.
> 
> Ok, this one should get it right.  This makes me miss the days of elm and no 
> firewalls.

Alas!

This attempt yielded:
> error: patch fragment without header at line 49: @@ -337,6 +356,7 @@ static int __devinit vsc_sata_init_one (
> error: patch fragment without header at line 57: @@ -378,6 +398,7 @@ static int __devinit vsc_sata_init_one (
> error: patch fragment without header at line 65: @@ -389,19 +410,33 @@ static int __devinit vsc_sata_init_one (
> error: patch fragment without header at line 100: @@ -428,10 +463,12 @@ static int __devinit vsc_sata_init_one (

Your previous attempt (MIME attachment) worked manually, but not through 
the normal git-applymbox merge mechanism than me (and others) use.

Also, your MIME attachment was based on kernel 2.6.18.  libata moves 
very rapidly, so you need to make sure that all your patches are based 
on the latest kernel, which is either kernel-2.6.X-rcY (in a Release 
Candidate cycle) or kernel-2.6.X-gitY (not -rc cycle).

Nonetheless, I managed to apply the patch (thank you git), and it is now 
queued for kernel 2.6.20 in repository jgarzik/libata-dev.git#upstream.

	Jeff


