From: Mark Lord <liml@rtr.ca>
Subject: Re: libata sata_via unusual behaviour
Date: Thu, 01 May 2008 22:40:23 -0400
Message-ID: <481A7F17.6010103@rtr.ca>
References: <3bbeafe90805011018o28f46794h369242ccb02b7ced@mail.gmail.com>	<3bbeafe90805011158n5b45283awd43a7a534ba11456@mail.gmail.com> <20080501195823.79786815@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1902 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755921AbYEBCk0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 22:40:26 -0400
In-Reply-To: <20080501195823.79786815@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo <paoletto@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Thu, 1 May 2008 20:58:37 +0200
> Paolo <paoletto@gmail.com> wrote:
> 
>> Hello!
>>
>>  It seems that me and many others are experiencing poor sata performances
>>  in the last months, probably with 2.6.20+ kernels.
>>
>>  an example of these problems is here:
>>
>>  http://ubuntuforums.org/showthread.php?p=4845777
>>
>>  unfortunately it seems that sata subsystem on linux is little to none
>>  tweakable
> 
> It doesn't normally need tweaking, and the hdparm numbers show that it is
> working correctly in the example you give. There may be problems higher
> up the stack but the ATA layer appears to be doing just fine.
..

Yup.  The drive seems to be doing fine, according to the info you've provided.

But the "-T" (big T) number looks *very* slow:  220.02 MB/sec
That number has nothing to do with the drive.  Rather, it's an indication
of how fast the CPU and memory are together, and that's about 1/20 to 1/10
of a modern system.

Note that it's not a useful number in any absolute sense, but only when
compared with a "-T" value from some other system or Linux distro.

Strange.

