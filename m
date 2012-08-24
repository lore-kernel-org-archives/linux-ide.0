From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2] ahci: implement aggressive SATA device sleep support
Date: Fri, 24 Aug 2012 11:36:05 -0400
Message-ID: <50379F65.3070009@pobox.com>
References: <1345761072-2123-1-git-send-email-shane.huang@amd.com> <503647B3.6050706@pobox.com> <43EB3AB3EEFE8D43B525F4D2EAF507E107E1A41A@SCYBEXDAG03.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:35456 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759036Ab2HXPgL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Aug 2012 11:36:11 -0400
Received: by vcbfk26 with SMTP id fk26so2259651vcb.19
        for <linux-ide@vger.kernel.org>; Fri, 24 Aug 2012 08:36:10 -0700 (PDT)
In-Reply-To: <43EB3AB3EEFE8D43B525F4D2EAF507E107E1A41A@SCYBEXDAG03.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Aaron Lu <aaron.lwe@gmail.com>

On 08/24/2012 06:46 AM, Huang, Shane wrote:
> Jeff,
>
>> 2) If we are going to unconditionally add ATA_SECT_SIZE bytes to every
>> ata_device structure, let's at least move the ata_read_log_page() call
>> outside of the devslp test, so that others may have this information
>> even if the device does not support devslp.
>
> Agreed, the info in that page is not limited to DevSlp variables.
> Should I also move it outside of the ata_dev_configure() function?
> Do you have better place to suggest?

ata_dev_configure() is the proper place.  Just move the log-read outside 
the ata_id_devslp test.

To avoid attempting to enable on older devices, you will need an 
appropriate test (ata_id_has_ncq perhaps?)


>> 3) please define constants in linux/ata.h for sata_settings information,
>> rather than using hexidecimal constants ("magic numbers").
>
> OK, I will define ATA_ID_FEATURE_SUPP to replace all the 78.

As you figured out in the other email, I was referring to sata_settings


>> 4) is it wise to issue SET_FEATURES / SATA_DEVSLP prior to programming
>> the host controller?  that order seems wrong.
>
> Per our understanding, there is no sequence requirement on this,
> please correct me if you see risk.

I just do not like programming the device, when power policy may 
indicate otherwise.

Most conservative is to leave devslp feature in reset state and not 
touch device or host until power policy dictates it is time to program 
host + device.

	Jeff



