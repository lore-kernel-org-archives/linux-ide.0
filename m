From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata-acpi: improve dock	event
 handling
Date: Wed, 19 Mar 2008 15:44:10 +0900
Message-ID: <47E0B63A.4090801@gmail.com>
References: <47D7691B.3080107@gmail.com> <20080313181946.GD26183@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:18120 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757101AbYCSXBg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Mar 2008 19:01:36 -0400
Received: by el-out-1112.google.com with SMTP id v27so544983ele.17
        for <linux-ide@vger.kernel.org>; Wed, 19 Mar 2008 16:01:34 -0700 (PDT)
In-Reply-To: <20080313181946.GD26183@homac.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

Holger Macht wrote:
> On Wed 12. Mar - 14:24:43, Tejun Heo wrote:
>> Improve ACPI hotplug handling such that dock event is handled properly.
>>
>> * Register handlers for dock events.
>>
>> * Directly detach device on EJECT_REQUEST instead of signaling hotplug
>>   event.  This prevents libata from accessing severed controller
>>   and/or device.
>>
>> * While at it, use named constants for ACPI events and move uevent
>>   signaling inside host lock.
>>
>> Original patch and testing by Holger Macht.
> 
> Grrrr, unfortunately, the patch still seems to be not perfect:
>   http://marc.info/?l=linux-acpi&m=120543202908662&w=2
> 
> Are you sure access to the device (/dev/srX) is locked before
> ata_acpi_dev_notify() returns?

Sorry about the delay.  I'm fairly sure /dev/srX goes away before
ata_acpi_handle_hotplug() returns.  ata_port_wait_eh() waits for EH to
complete and the EH run triggered by ata_port_schedule_eh() above
disables the device, so any command issued after that will be aborted
with BAD_TARGET.  Can you capture kernel log of such lock up?  If so, it
would be very helpful to sprinkle some printks around and see what
actually goes on.

Thanks.

-- 
tejun
