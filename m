From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 05/64] pata_atiixp: remove superfluous wrapper function
Date: Thu, 21 Jan 2010 11:50:13 -0500
Message-ID: <4B5885C5.1010607@garzik.org>
References: <20100118171349.14623.90030.sendpatchset@localhost> <4B57D2E4.30203@garzik.org> <4B57D365.3040201@garzik.org> <201001211223.16924.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:39804 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab0AUQuQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jan 2010 11:50:16 -0500
In-Reply-To: <201001211223.16924.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/21/2010 06:23 AM, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 21 January 2010 05:09:09 am Jeff Garzik wrote:
>> On 01/20/2010 11:07 PM, Jeff Garzik wrote:
>>> On 01/18/2010 12:14 PM, Bartlomiej Zolnierkiewicz wrote:
>>>> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
>>>> Subject: [PATCH] pata_atiixp: remove superfluous wrapper function
>>>>
>>>> Fix documentation for ->set_[pio,dma]mode methods while at it.
>>>>
>>>> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
>>>> ---
>>>> drivers/ata/pata_atiixp.c | 29 +++++++----------------------
>>>> 1 file changed, 7 insertions(+), 22 deletions(-)
>>>
>>> applied
>>
>> undone...  it broke the build, presumably because it requires something
>> in your tree that's not in libata-dev.git
>
> Jeff, as noted in the first mail those patches are against atang tree
> (which has many changes which are missing from your libata-dev tree)..

Yes, hence "presumably because it requires something in your tree"

Would you be willing to submit a push against the latest 
libata-dev.git#upstream?

	Jeff




