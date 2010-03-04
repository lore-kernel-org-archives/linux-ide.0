From: s ponnusa <foosaa@gmail.com>
Subject: Re: Linux kernel - Libata bad block error handling to user mode
	program
Date: Thu, 4 Mar 2010 14:50:53 -0500
Message-ID: <f875e2fe1003041150k2e29c813w4149c73277c051d@mail.gmail.com>
References: <f875e2fe1003032052p944f32ayfe9fe8cfbed056d4@mail.gmail.com>
	 <20100303224245.ae8d1f7a.akpm@linux-foundation.org>
	 <87f94c371003040617t4a4fcd0dt1c9fc0f50e6002c4@mail.gmail.com>
	 <4B8FC6AC.4060801@teksavvy.com>
	 <f875e2fe1003040733h20d5523ex5d18b84f47fee8c7@mail.gmail.com>
	 <4B8FF2C3.1060808@teksavvy.com>
	 <f875e2fe1003041020t7cbab2c2x585df9b2dfc10dd2@mail.gmail.com>
	 <87f94c371003041141y1bcd30fdkdca7349eea5930b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63141 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932149Ab0CDTuy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Mar 2010 14:50:54 -0500
In-Reply-To: <87f94c371003041141y1bcd30fdkdca7349eea5930b4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-mm@kvack.org

Oops! ATA Specifications! It is a block device. HDD.

On Thu, Mar 4, 2010 at 2:41 PM, Greg Freemyer <greg.freemyer@gmail.com> wrote:
> On Thu, Mar 4, 2010 at 1:20 PM, s ponnusa <foosaa@gmail.com> wrote:
>> SMART data consists only the count of remapped sectors, seek failures,
>> raw read error rate, uncorrectable sector counts, crc errors etc., and
>> technically one should be aware of the error during write operation as
>> well.
>>
>> As per the ATAPI specifications\
>
>
> ATAPI?
>
> What sort of device is this?
>
> Greg
>
