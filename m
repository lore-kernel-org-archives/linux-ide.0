From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] libata: Register for dock events when the drive is
	inside a dock station
Date: Thu, 21 Feb 2008 12:53:05 +0100
Message-ID: <20080221115305.GB5032@homac.suse.de>
References: <20080214124048.GB9708@homac.suse.de> <20080214125615.GD9708@homac.suse.de> <47BC5F44.605@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:49655 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbYBULwF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Feb 2008 06:52:05 -0500
Content-Disposition: inline
In-Reply-To: <47BC5F44.605@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

On Wed 20. Feb - 12:11:32, Jeff Garzik wrote:
> Holger Macht wrote:
>> On Thu 14. Feb - 13:40:48, Holger Macht wrote:
>>> If a device/bay is inside a docking station, we need to register for dock
>>> events additionally to bay events. If a dock event occurs, the dock driver
>>> will call the appropriate handler (ata_acpi_ap_notify() or
>>> ata_acpi_dev_notify()) for us.
>>>
>>> Signed-off-by: Holger Macht <hmacht@suse.de>
>>
>> Updated patch which only includes the dock specific function if the dock
>> driver is actually compiled.
>>
>> Signed-off-by: Holger Macht <hmacht@suse.de>
>> ---
>>
>> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
>> index 9e8ec19..5f16055 100644
>> --- a/drivers/ata/libata-acpi.c
>> +++ b/drivers/ata/libata-acpi.c
>> @@ -191,20 +191,33 @@ void ata_acpi_associate(struct ata_host *host)
>>  		else
>>  			ata_acpi_associate_ide_port(ap);
>>  -		if (ap->acpi_handle)
>> +		if (ap->acpi_handle) {
>>  			acpi_install_notify_handler (ap->acpi_handle,
>>  						     ACPI_SYSTEM_NOTIFY,
>>  						     ata_acpi_ap_notify,
>>  						     ap);
>> +#ifdef CONFIG_ACPI_DOCK
>> +			/* we might be on a docking station */
>> +			register_hotplug_dock_device(ap->acpi_handle,
>> +						     ata_acpi_ap_notify, ap);
>> +#endif
>> +		}
>>   		for (j = 0; j < ata_link_max_devices(&ap->link); j++) {
>>  			struct ata_device *dev = &ap->link.device[j];
>>  -			if (dev->acpi_handle)
>> +			if (dev->acpi_handle) {
>>  				acpi_install_notify_handler (dev->acpi_handle,
>>  							     ACPI_SYSTEM_NOTIFY,
>>  							     ata_acpi_dev_notify,
>>  							     dev);
>> +#ifdef CONFIG_ACPI_DOCK
>> +				/* we might be on a docking station */
>> +				register_hotplug_dock_device(ap->acpi_handle,
>> +							     ata_acpi_dev_notify,
>> +							     ap);
>> +#endif
>
> CONFIG_ACPI_DOCK is a tristate, so you might have CONFIG_ACPI_DOCK_MODULE...

Thanks for the hint, so once again:


If a device/bay is inside a docking station, we need to register for dock
events additionally to bay events. If a dock event occurs, the dock driver
will call the appropriate handler (ata_acpi_ap_notify() or
ata_acpi_dev_notify()) for us.

Signed-off-by: Holger Macht <hmacht@suse.de>
---

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 9e8ec19..563ad72 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -191,20 +191,33 @@ void ata_acpi_associate(struct ata_host *host)
 		else
 			ata_acpi_associate_ide_port(ap);
 
-		if (ap->acpi_handle)
+		if (ap->acpi_handle) {
 			acpi_install_notify_handler (ap->acpi_handle,
 						     ACPI_SYSTEM_NOTIFY,
 						     ata_acpi_ap_notify,
 						     ap);
+#ifdef CONFIG_ACPI_DOCK_MODULE
+			/* we might be on a docking station */
+			register_hotplug_dock_device(ap->acpi_handle,
+						     ata_acpi_ap_notify, ap);
+#endif
+		}
 
 		for (j = 0; j < ata_link_max_devices(&ap->link); j++) {
 			struct ata_device *dev = &ap->link.device[j];
 
-			if (dev->acpi_handle)
+			if (dev->acpi_handle) {
 				acpi_install_notify_handler (dev->acpi_handle,
 							     ACPI_SYSTEM_NOTIFY,
 							     ata_acpi_dev_notify,
 							     dev);
+#ifdef CONFIG_ACPI_DOCK_MODULE
+				/* we might be on a docking station */
+				register_hotplug_dock_device(ap->acpi_handle,
+							     ata_acpi_dev_notify,
+							     ap);
+#endif
+			}
 		}
 	}
 }
