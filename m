From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3 0/5] ATA/ARM: convert ARM/DaVinci to use libata PATA
 drivers
Date: Thu, 30 Mar 2017 17:23:38 +0530
Message-ID: <f5ee9343-8af2-e264-0439-c7935064d095@ti.com>
References: <CGME20170322182127epcas1p267b13e8c92205223458863783bdea476@epcas1p2.samsung.com>
 <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
 <aaf669ba-4439-9af7-7943-c9163bd99020@ti.com> <7423344.GzQhW9fIvG@amdc3058>
 <20170329153552.GC30385@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:50757 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdC3Ly1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Mar 2017 07:54:27 -0400
In-Reply-To: <20170329153552.GC30385@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Wednesday 29 March 2017 09:05 PM, Tejun Heo wrote:
> On Fri, Mar 24, 2017 at 04:38:24PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> On Thursday, March 23, 2017 07:27:05 PM Sekhar Nori wrote:
>>> On Wednesday 22 March 2017 11:50 PM, Bartlomiej Zolnierkiewicz wrote:
>>>> Hi,
>>>>
>>>> This patchset adds Palmchip BK3710 IDE controller driver to
>>>> libata and switches ARM/DaVinci to use it (instead of the old
>>>> IDE driver).
>>>>
>>>> Sekhar, please check that it still works after changes, thanks.
>>>
>>> Did some basic mount/read/write tests, it passed.
>>
>> Thanks for checking.
>>
>> I guess that you can merge the patchset now to your tree
>> (with Tejun's ACK for the whole patches and Sergei's ACK
>> for ATA changes).
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Yeah, please feel free to route the series as you see fit.

Series applied to my tree for v4.12 with Tejun and Sergei's acks added.

Thanks,
Sekhar
