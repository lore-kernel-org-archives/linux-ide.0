From: Mark Lord <kernel@start.ca>
Subject: Re: [PATCH v2] ata: ahci: find eSATA ports and flag them as removable
Date: Fri, 16 Oct 2015 08:42:02 -0400
Message-ID: <5620F09A.9010909@start.ca>
References: <1443640225-11860-1-git-send-email-manuel.lauss@gmail.com>
 <20150930213910.GG2627@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.start.ca ([64.140.120.243]:51446 "EHLO mail3.start.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbbJPMtT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Oct 2015 08:49:19 -0400
In-Reply-To: <20150930213910.GG2627@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Manuel Lauss <manuel.lauss@gmail.com>
Cc: linux-ide@vger.kernel.org

On 15-09-30 05:39 PM, Tejun Heo wrote:
> On Wed, Sep 30, 2015 at 09:10:25PM +0200, Manuel Lauss wrote:
>> If the AHCI ports' HPCP or ESP bits are set, the port
>> should be considered external (e.g. eSATA) and is marked
>> as removable.  Userspace tools like udisks then treat it
>> like an usb drive.
>>
>> With this patch applied, when I plug a drive into the esata port,
>> KDE pops up a window asking what to do with the drives(s), just
>> like it does for any random USB stick.
>>
>> Removability is indicated to the upper layers by way of the
>> SCSI RMB bit, as I haven't found another way to signal
>> userspace to treat a sata disk like any usb stick.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>
> Applied to libata/for-4.4.  Let's see what happens.

Ugh.  Yet another revert to include in my own builds, I guess.

eSATA is used for permanent storage expansion with port-multipliers,
and having to stop command queuing frequently for useless polling
is gonna be a performance drain.

-ml

