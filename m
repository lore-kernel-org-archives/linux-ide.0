From: "Luciano A. Stertz" <luciano@tteng.com.br>
Subject: Re: T10/04-262 ATA pass thru - patch.
Date: Wed, 29 Sep 2004 16:31:38 -0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <415B0D9A.5080204@tteng.com.br>
References: <20040928001633.A8363@florence.linkmargin.com> <415AFF27.7080906@tteng.com.br> <415AFFBB.8090503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 200-203-041-086.paemt7002.e.brasiltelecom.net.br ([200.203.41.86]:61771
	"EHLO einstein.tteng.com.br") by vger.kernel.org with ESMTP
	id S267720AbUI2T1S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Sep 2004 15:27:18 -0400
In-Reply-To: <415AFFBB.8090503@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Luciano A. Stertz wrote:
> 
>>
>>     Just trying to understand the SATA SMART problem as a whole. With 
>> your patch, it's possible to send ATA commands that are encapsulated 
>> in CDBs, right? If so, to enable sending direct ATA commands to a SATA 
>> device, one has to create a ioctl that receives the command and 
>> creates a CDB from it, as John Linville did a few weeks ago. This way 
>> a user-space application (e.g. smartmontools) can use this ioctl to 
>> send ATA commands. Am I right?
> 
> 
> No.  SCSI "send CDB" ioctls have existed for years.
> 
> The ioctls John added are merely for compatibility with existing IDE 
> utilities.
	Hmm, didn't know that. Do you mean that I can already send ATA commands 
to SATA devices? Where can I find information about these ioctls?

	Thanks again,
	Luciano

-- 
Luciano A. Stertz
luciano@tteng.com.br
T&T Engenheiros Associados Ltda
http://www.tteng.com.br
Fone/Fax (51) 3224 8425
