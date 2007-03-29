From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 2/3] libata: expose AN support to user space via sysfs
Date: Thu, 29 Mar 2007 11:04:31 +0900
Message-ID: <460B1EAF.8030207@gmail.com>
References: <20070328230108.597741522@intel.com> <20070328164450.b89d5156.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:39752 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933078AbXC2CEi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 22:04:38 -0400
Received: by nz-out-0506.google.com with SMTP id s1so35333nze
        for <linux-ide@vger.kernel.org>; Wed, 28 Mar 2007 19:04:38 -0700 (PDT)
In-Reply-To: <20070328164450.b89d5156.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Kristen Carlson Accardi wrote:
> Allow user space to determine if an ATAPI device supports
> async notification (AN) of media changes.  This is done by
> adding a new sysfs file "async_notification" to genhd.
> If the file reads 1, then the device supports async 
> notification.  If the file reads 0, it does not.  
> 
> A flag is set in the generic disk to indicate whether
> or not AN is supported.  This flag is set by the SCSI
> subsystem when it registers with add_disk.  The SCSI
> system gets information from libata on whether the
> device supports AN during dev_configure. 

I'm not sure whether this should be in generic block layer or in libata 
proper.  libata sysfs hierarchy isn't there yet but is scheduled to be 
added soon.  Async notification of media change is generic event for any 
block device with removable media, so I guess it can belong to generic 
layer.  BTW, I think you also need to forward the flag in sd - disk 
device can be removable too.  And please cc linux-scsi@vger.kernel.org 
to get SCSI part reviewed.

Thanks.

-- 
tejun
