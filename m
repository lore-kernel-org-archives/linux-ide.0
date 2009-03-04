From: Mark Lord <liml@rtr.ca>
Subject: Re: ahci fails with SATA DVD drive, IDE mode works
Date: Wed, 04 Mar 2009 10:51:02 -0500
Message-ID: <49AEA366.5070906@rtr.ca>
References: <20090211174558.505354fe@dhcp-100-2-144.bos.redhat.com>	<499D2202.7070503@kernel.org>	<20090221181705.0b5f9ed3@dhcp-100-2-144.bos.redhat.com>	<49A4DFD4.3030206@kernel.org>	<20090225181530.1c575a30@dhcp-100-2-144.bos.redhat.com>	<49A5EB45.6050202@kernel.org>	<20090227175746.44acdbfa@dhcp-100-2-144.bos.redhat.com>	<49AA7EF9.7000306@kernel.org> <20090303162352.23432dd1@dhcp-100-2-144.bos.redhat.com> <49ADD9C7.7000207@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:44038 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbZCDPvH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Mar 2009 10:51:07 -0500
In-Reply-To: <49ADD9C7.7000207@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Chuck Ebbert wrote:
>> On Sun, 01 Mar 2009 21:26:33 +0900
>> Tejun Heo <tj@kernel.org> wrote:
>>
>>>> I ran 'hdparm -I' here. Why would it send BLANK to the drive??
>>>> (There was a 1.4 GB DVD-RW in the drive when I did that.)
>>> CDB 0xa1 is BLANK alright.  Is the problem reproducible?
>>>
> 
> Now that I think about it, 0xa0 is PACKET and 0xa1 is IDENTIFY_ATAPI.
> You used "hdparm -I /dev/sr0", right?  Mark, any ideas?  Somehow
> IDENTIFY is getting wrapped inside packet and sent to the device.
..

Does it do that with the latest versions, hdparm-9.11 or hdparm-9.12 ?
(probably fine with those)

In hdparm-9.7 I changed things so that it used ATA_12 rather than ATA_16
when passing short commands through SCSI.  Worked for for disks, but failed
for optical drives -- libata doesn't process ATA_12 for ATAPI (oops).

Fixed it again in hdparm-9.11, so just upgrade.
