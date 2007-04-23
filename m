From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: improve ATA ACPI support
Date: Mon, 23 Apr 2007 17:06:35 +0900
Message-ID: <462C690B.1090802@gmail.com>
References: <11772636651400-git-send-email-htejun@gmail.com> <20070422192500.2e1014fd@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:59205 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbXDWIHx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 04:07:53 -0400
Received: by an-out-0708.google.com with SMTP id b33so1703287ana
        for <linux-ide@vger.kernel.org>; Mon, 23 Apr 2007 01:07:52 -0700 (PDT)
In-Reply-To: <20070422192500.2e1014fd@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
>> * after successfully executing _GTF taskfiles, IDENTIFY page is
>>   reloaded
> 
> Interesting question we should sort out: What is our identify page as
> supplied to the user meant to be ?
> 
> The old IDE one started off as the "identify data at boot" (which is
> useful) and mutated through a million "kind of boot but mangled" and "not
> boot" versions of the identify data, all of which are useless to
> userspace.
> 
> Having the "boot" data (for some definition of boot) is important in
> order to know things like the BIOS view of the disk geometry and HPA (eg
> for partitioning), having the current data is useless as its already
> available via SG_IO.

AFAIK, IDENTIFY using SG_IO is the way to obtain ID data.
HDIO_GET_IDENTITY is only added for backward compatibility and as a
sideway to obtain ATAPI IDENTIFY page while IDENTIFY_PACKET_DEVICE via
SG_IO is broken.  libata tries pretty hard to keep the cached IDENTIFY
page up-to-date and I'm pretty sure it stays in sync with the drive most
of the time.  I think HDIO_GET_IDENTITY's meaning is something like
"give me IDENTIFY page of the device as seen by the driver" and doesn't
really matter as long as it can be used to get general idea about the
device.

-- 
tejun
