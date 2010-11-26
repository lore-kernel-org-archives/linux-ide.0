From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata_sil24: external raid storage mistaken as port multiplier
Date: Fri, 26 Nov 2010 15:13:44 -0500
Message-ID: <4CF014F8.9000700@teksavvy.com>
References: <1290461073.12443.21.camel@Tobias-Karnat>	 <1290514125.28293.2.camel@Tobias-Karnat> <1290572588.24847.20.camel@Tobias-Karnat> <4CEFEC17.6060503@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:6053 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751067Ab0KZUN6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Nov 2010 15:13:58 -0500
In-Reply-To: <4CEFEC17.6060503@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Tobias Karnat <tobias.karnat@googlemail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 10-11-26 12:19 PM, Tejun Heo wrote:
> On 11/24/2010 05:23 AM, Tobias Karnat wrote:
>> Hi,
>>
>> I got it fixed by removing ATA_FLAG_PMP from the SIL24_COMMON_FLAGS.
>>
>> Could someone turn this into a module option?
>>
>> The external raid case might in fact has a built-in port multiplier,
>> but the case can only be configured as raid0 and raid1.
>>
>> I suspect that Linux tries to to access the drives separately, which fails.
>
> Hmmm... well, libata is just sending SRST w/ the port number set to 15
> and the device is reporting that it is a port multipler to that.
> Depending on configuration these devices don't work too well when
> commanded as a PMP device.  If you put it into JBOD mode, it will
> probably work fine.  I have no idea why it still reports as a PMP
> device when configured as a virtual device.
>
> That said, yeah, it probably would be a good idea to add a
> libata.force param.

How about some form of auto-detection instead?

-ml
