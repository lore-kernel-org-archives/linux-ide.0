From: Daniel Schroeder <sec@dschroeder.info>
Subject: Re: sata_nv hotplug
Date: Sat, 18 Aug 2007 23:25:59 +0200
Message-ID: <46C763E7.1060200@dschroeder.info>
References: <20070818192250.GE2419@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:59680 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209AbXHRV0k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 17:26:40 -0400
In-Reply-To: <20070818192250.GE2419@kvack.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-ide@vger.kernel.org

Benjamin LaHaise wrote:
> Hello folks,
>
> Does anyone know the state of hot plug support for the sata_nv driver?  I'm 
> certainly willing to help out with any development and testing that's needed, 
> as it doesn't seem to function in basic testing at present.
>
> 		-ben
>   
hi,

i am using the following command for hotplug (warmplug):

echo 0 - 0 > /sys/class/scsi_host/host5/scan

and after umount before turning off the device:

echo 1 > /sys/class/scsi_device/5\:0\:0\:0/device/delete

i think that the "hot plug polling" patch is needed for automatic
detection of new devices, but i am only a user, not a developer ;)

cheers,
ds
