From: Karel Zak <kzak@redhat.com>
Subject: Re: 4k sector size and WD20EARS
Date: Mon, 12 Apr 2010 14:34:14 +0200
Message-ID: <20100412123414.GK7858@nb.net.home>
References: <4BBDE620.3040601@gc-web.de> <yq17hoix78i.fsf@sermon.lab.mkp.net> <4BBE0C85.2020904@gc-web.de> <yq1wrwhv0ca.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57228 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359Ab0DLMeV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Apr 2010 08:34:21 -0400
Content-Disposition: inline
In-Reply-To: <yq1wrwhv0ca.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Alexander Clausen <alex@gc-web.de>, linux-ide@vger.kernel.org

On Thu, Apr 08, 2010 at 10:14:29PM -0400, Martin K. Petersen wrote:
> >>>>> "Alexander" == Alexander Clausen <alex@gc-web.de> writes:
> 
> >> For unknown reasons these drive report themselves as 512-byte drives
> >> despite using 4096-byte sectors internally.
> 
> Alexander> ouch.
> 
> Yeah, I know...
> 
> 
> Alexander> $ sudo cfdisk -P s /dev/sdb FATAL ERROR: Bad primary
> Alexander> partition 0: Partition ends in the final partial cylinder
> 
> Alexander> bug?
> 
> I'm not sure cfdisk has been kept in sync with the alignment and block
> size changes.  Karel?

 Unfortunately, sfdisk and cfdisk have no clue about alignment and 
 disks topology.

 Now only the fdisk and parted commands are ready for new disks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
