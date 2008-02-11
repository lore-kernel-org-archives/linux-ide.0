From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Forcing PIO0 mode on reset must not freeze	system
Date: Tue, 12 Feb 2008 08:31:08 +0900
Message-ID: <47B0DABC.6080703@gmail.com>
References: <20080210195556.GA5261@homac> <47AFB4DB.1000204@gmail.com> <20080211100446.GA4646@homac.suse.de> <47B02E96.4050900@gmail.com> <20080211112802.GA4528@homac.suse.de> <47B04984.1020401@gmail.com> <20080211140603.GA4576@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:5510 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbYBKXbR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 18:31:17 -0500
Received: by wr-out-0506.google.com with SMTP id c48so4261929wra.23
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 15:31:16 -0800 (PST)
In-Reply-To: <20080211140603.GA4576@homac.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alan@redhat.com, jeff@garzik.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Holger Macht wrote:
> On a related note, shouldn't ata_acpi_handle_hotplug delete the device
> like what is done when doing
> 
>   echo 1 > /sys/devices/.../block/sr0/device/delete

Yeap, when the ata_acpi_handle_hotplug() was added, the focus was
supporting hotplug when the controller itself doesn't have hotplug
notification.  Removing device for undocking would need explicitly
killing it.

-- 
tejun
