From: "Luciano A. Stertz" <luciano@tteng.com.br>
Subject: Re: T10/04-262 ATA pass thru - patch.
Date: Tue, 05 Oct 2004 15:53:23 -0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4162EDA3.1030202@tteng.com.br>
References: <20040928001633.A8363@florence.linkmargin.com> <415AFF27.7080906@tteng.com.br> <415AFFBB.8090503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 200-203-041-086.paemt7002.e.brasiltelecom.net.br ([200.203.41.86]:117
	"EHLO einstein.tteng.com.br") by vger.kernel.org with ESMTP
	id S264668AbUJESru (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Oct 2004 14:47:50 -0400
In-Reply-To: <415AFFBB.8090503@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Andy Warner <andyw@pobox.com>

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
	Am I supposed to be able to run any ATA command from user-space now, 
then? Let's say I want to run a IDENTIFY DEVICE, how can I do that? I 
tried SG_IO, but sg_allow_access blocks my request since the 'ATA_16' 
command isn't recognized yet. Is there another way?

	Thanks again,
		Luciano

-- 
Luciano A. Stertz
luciano@tteng.com.br
T&T Engenheiros Associados Ltda
http://www.tteng.com.br
Fone/Fax (51) 3224 8425
