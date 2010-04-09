From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: 4k sector size and WD20EARS
Date: Thu, 08 Apr 2010 22:14:29 -0400
Message-ID: <yq1wrwhv0ca.fsf@sermon.lab.mkp.net>
References: <4BBDE620.3040601@gc-web.de> <yq17hoix78i.fsf@sermon.lab.mkp.net>
	<4BBE0C85.2020904@gc-web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:33085 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab0DICPL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 22:15:11 -0400
In-Reply-To: <4BBE0C85.2020904@gc-web.de> (Alexander Clausen's message of
	"Thu, 08 Apr 2010 19:04:05 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Clausen <alex@gc-web.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, Karel Zak <kzak@redhat.com>

>>>>> "Alexander" == Alexander Clausen <alex@gc-web.de> writes:

>> For unknown reasons these drive report themselves as 512-byte drives
>> despite using 4096-byte sectors internally.

Alexander> ouch.

Yeah, I know...


Alexander> $ sudo cfdisk -P s /dev/sdb FATAL ERROR: Bad primary
Alexander> partition 0: Partition ends in the final partial cylinder

Alexander> bug?

I'm not sure cfdisk has been kept in sync with the alignment and block
size changes.  Karel?

-- 
Martin K. Petersen	Oracle Linux Engineering
