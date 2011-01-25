From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: add another PCI ID for marvell
Date: Tue, 25 Jan 2011 14:09:31 -0500
Message-ID: <4D3F1FEB.5050400@garzik.org>
References: <4CF3BF4A.4080009@kernel.org> <20110125134140.GX27510@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48653 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab1AYTJg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jan 2011 14:09:36 -0500
Received: by vws16 with SMTP id 16so88727vws.19
        for <linux-ide@vger.kernel.org>; Tue, 25 Jan 2011 11:09:36 -0800 (PST)
In-Reply-To: <20110125134140.GX27510@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Alessandro Tagliapietra <tagliapietra.alessandro@gmail.com>

On 01/25/2011 08:41 AM, Tejun Heo wrote:
> On Mon, Nov 29, 2010 at 03:57:14PM +0100, Tejun Heo wrote:
>> 1b4b:91a3 seems to be another PCI ID for marvell ahci.  Add it.
>> Reported and tested in the following thread.
>>
>>   http://thread.gmane.org/gmane.linux.kernel/1068354
>>
>> Signed-off-by: Tejun Heo<tj@kernel.org>
>> Reported-by: Borislav Petkov<bp@alien8.de>
>> Reported-by: Alessandro Tagliapietra<tagliapietra.alessandro@gmail.com>
>
> Jeff, ping?

Missed this one, for some reason.  Found, and queued.

Will go in the push to Linus this week, but due to LCA he might not pull 
for a bit.


