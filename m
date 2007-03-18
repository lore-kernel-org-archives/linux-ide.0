From: Tejun Heo <htejun@gmail.com>
Subject: Re: CONFIG_IBM_BAY
Date: Sun, 18 Mar 2007 14:38:42 +0900
Message-ID: <45FCD062.3050001@gmail.com>
References: <11736588493609-git-send-email-hmh@hmh.eng.br>	<20070315031015.GA6292@khazad-dum.debian.net>	<20070315031251.GB6292@khazad-dum.debian.net>	<200703150206.05811.lenb@kernel.org>	<20070315133900.GC26862@khazad-dum.debian.net>	<20070315080644.c73db24a.kristen.c.accardi@intel.com>	<20070315175505.GB6596@khazad-dum.debian.net>	<20070315110156.09e80b99.kristen.c.accardi@intel.com>	<20070315193123.GB14394@khazad-dum.debian.net> <20070315125037.3e82e0c4.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:32983 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbXCRFis (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 01:38:48 -0400
Received: by nz-out-0506.google.com with SMTP id s1so455133nze
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 22:38:47 -0700 (PDT)
In-Reply-To: <20070315125037.3e82e0c4.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-ide@vger.kernel.org

Hello,

Kristen Carlson Accardi wrote:
>> 1. It will handle all device types (ATAPI, PATA, SATA, batteries);
>>
>> 2. It will do the right thing on plug and unplug.  This means telling the
>> rest of the kernel to disable the device in the bay, for example.  Right now
>> we shutdown one end of the PATA/SATA link on ThinkPads eletrically, and
>> leave libata to scream blood murder until it disables its end due to too
>> many retries, for example;

:-)

> Personally - I think tighter integration to libata here would be beneficial.
> Once libata acpi support is straightened out, if we can store acpi handles
> associated with libata devices, we can perhaps have a mechanism of obtaining
> ata_device structs so that we can have a nice way of telling libata to 
> delete devices etc.  I am hoping libata-acpi will be straightened out for
> 2.6.22.

I dunno what the thread is really about but can't this be dealt within
acpid?  Finding out the correct scsi host node can be tricky but I think
it can be done reliably by jumping through some sysfs whoops.  Once
you're there, telling libata to kill or probe is really easy.

  http://www.thinkwiki.org/wiki/How_to_hotswap_UltraBay_devices

Thanks.

-- 
tejun
