From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] RESEND: SCSI, libata: add support for ATA_16 commands
 to libata ATAPI devices
Date: Thu, 01 Feb 2007 17:43:15 +0900
Message-ID: <45C1A823.30008@gmail.com>
References: <200701021935.07840.liml@rtr.ca> <200701311346.26644.liml@rtr.ca> <45C1356B.6000907@gmail.com> <45C1377F.6070001@rtr.ca> <45C138E8.1040706@gmail.com> <45C1A4BD.3030909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <45C1A4BD.3030909@garzik.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Linux IDE <linux-ide@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> SCSI always uses the smallest command it can use, so we're safe.  Most
>> other commands are issued directly from the userland and it's their
>> responsibility not to feed disallowed commands to a device (or we need
>> more advanced filter).  Anyways, this has never been guaranteed because
>> the limit is host wide.
>>
>> So, I'm for setting it to 16.  Jeff, what do you think?
> 
> 
> Like I just noted in another email, the limit is really on the /device/
> side.  In theory the user could plug in a 16-byte ATAPI device and a
> 12-byte ATAPI device to the same host.
> 
> We should be able to safely raise the limit to 16-byte for most host
> controllers.  Note I said "most".  The bitch will be figuring out which
> host controllers do not like 16-byte CDBs.

Well, it's not any worse than what we're currently doing.  We don't set
host cdb len limit according to the host.  We set it to the largest
value among the attached devices.  So, if there is a 12 byte only
controller out there and if you connect 16 byte ATAPI device to it,
you're screwed already and will continue to be screwed after the change.

Note that raising host cdb limit to 16 doesn't make anybody issue 16
byte cdb to the device.  The only unconditionally allowed 16 byte cdb is
ATA_16 which is executed by libata SAT and thus doesn't pass through the
host.

-- 
tejun
