From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/3] ahci: Allow setting a default LPM policy for mobile
 chipsets
Date: Mon, 11 Dec 2017 17:29:28 +0100
Message-ID: <6aba00d3-594c-ab0c-d58b-368ef742bbba@redhat.com>
References: <20171206154110.11548-1-hdegoede@redhat.com>
 <20171206154110.11548-4-hdegoede@redhat.com>
 <20171211144223.GB2421075@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38907 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdLKQ3b (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2017 11:29:31 -0500
Received: by mail-wm0-f47.google.com with SMTP id 64so15237421wme.3
        for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2017 08:29:30 -0800 (PST)
In-Reply-To: <20171211144223.GB2421075@devbig577.frc2.facebook.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 11-12-17 15:42, Tejun Heo wrote:
> Hello, Hans.
> 
> On Wed, Dec 06, 2017 at 04:41:10PM +0100, Hans de Goede wrote:
>>   CONFIG_SATA_AHCI=y
>> +CONFIG_SATA_MOBILE_LPM_POLICY=3
> 
> This would change the default behavior.  Can we not do that?

Actually if you would try to apply this git will likely
complain that .config is not tracked by git. I'm tracking
my own personal .config in my own git-repo and the change
to that accidentally ended up in the commit/patch, my bad,
sorry.

I will submit a v2 with this fixed.

Regards,

Hans
