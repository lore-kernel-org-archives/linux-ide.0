From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-acpi: summary, problems, questions and proposal
Date: Thu, 29 Mar 2007 10:42:03 +0900
Message-ID: <460B196B.5040306@gmail.com>
References: <460A197A.9000708@gmail.com> <20070328175712.GA10293@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.178]:50259 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965888AbXC2BmP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 21:42:15 -0400
Received: by ik-out-1112.google.com with SMTP id c21so27816ika
        for <linux-ide@vger.kernel.org>; Wed, 28 Mar 2007 18:42:14 -0700 (PDT)
In-Reply-To: <20070328175712.GA10293@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Randy.Dunlap y" <rdunlap@xenotime.net>, trenn@suse.de, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, forrest.zhao@gmail.com, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-acpi@vger.kernel.org

Hello, Matthew.

Matthew Garrett wrote:
> On Wed, Mar 28, 2007 at 04:30:02PM +0900, Tejun Heo wrote:
> 
> Hi Tejun,
> 
> Firstly, could I ask you to take a look at the patch in 
> http://permalink.gmane.org/gmane.linux.acpi.devel/22066/ ? It deals with 
> some of these issues.

Yeap, I've seen the patch.  That's why you're on the cc list in the 
first place.  :-)

>> ACPI support implementation in libata-dev supports both IDE and SATA
>> ACPI object layouts and subset of ATA ACPI methods - _SDD and _GTF.
>> It incorrectly uses ap->cbl (the port's cable type) to choose between
>> the two ACPI layouts.  Association between the host and its ACPI
>> object is performed every time ACPI methods are invoked but the
>> association between an ATA device and its ACPI object is cached in
>> ata_device object.
> 
> These issues are both fixed in my patch, I believe.

Yeap, I think it's in the right direction but we need to go further.

* I'm not sure whether the complex walk libata-acpi is doing is justifiable.

* You'll end up doing _STM/_GTM on ahci controller on some BIOSen - 1. 
it can be dangerous 2. you might get partial or incorrect mapping - 
think about ICH8-split-to-two-PCI-fn-in-piix-mode case.

>> 2-2. Missing proper _GTM/_STM support.  As stated above, although -mm
>>     contains _GTM/_STM support, it does not hook it to regular
>>     exception handling path and thus _GTF cannot be used in a lot of
>>     cases.
> 
> I've added _GTM and _STM support over suspend/resume. Right now they're 
> in the host power management code - I'm not sure whether they should be 
> here or the SCSI glue layer?

I think PM functions in libata-eh is better place and you also need to 
do _GTF after _GTM during resume.

>> 2-3. Misplaced _GTF hook.  _GTF currently is called prior to every
>>     device configuration.  This is unnecessary and incorrect.  The
>>     ACPI spec specifies that _GTM/_STM and _GTF should be executed
>>     during suspend/resume cycles not on every reset or
>>     reconfiguration.  This, for example, causes the following
>>     problem.
> 
> That should be quite easily fixable with the above patch.

Yeap.

>> 4-1. Depending on how questions in section 3 are answered, fix and
>>     clean up ATA host/device <-> ACPI object association.  Whether
>>     IDE or SATA native style hierarchy is used should be determined
>>     by driver flag not cable type.  e.g. ahci and sata_sil24 should
>>     use SATA native style hierarchy while ata_piix should use IDE
>>     hierarchy whether the port is SATA or PATA.
> 
> I think this is just a matter of making sure that the sata and pata 
> handle matching code matches reality now :)

Currently 1/2 of libata-acpi code is dealing with the above.  I'm trying 
to figure out why it needs to be that complex.

Anyways, I think your patch is a step in the right direction, so 
depending on how ACPI gurus enlighten us here, we can base further fix 
on your patch.  Let's see how the questions are answered.

Thanks.

-- 
tejun
