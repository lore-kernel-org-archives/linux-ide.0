From: s ponnusa <foosaa@gmail.com>
Subject: Re: Linux kernel - Libata bad block error handling to user mode
	program
Date: Sat, 13 Mar 2010 17:44:06 -0500
Message-ID: <f875e2fe1003131444p238ad546xdadb3fca530fb074@mail.gmail.com>
References: <f875e2fe1003032052p944f32ayfe9fe8cfbed056d4@mail.gmail.com>
	 <20100303224245.ae8d1f7a.akpm@linux-foundation.org>
	 <87f94c371003040617t4a4fcd0dt1c9fc0f50e6002c4@mail.gmail.com>
	 <4B8FC6AC.4060801@teksavvy.com>
	 <87f94c371003111029s7c7daebgf691ab11e6bdda25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57807 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759381Ab0CMWoH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Mar 2010 17:44:07 -0500
In-Reply-To: <87f94c371003111029s7c7daebgf691ab11e6bdda25@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-mm@kvack.org

Had some issues with the libata in 2.6.27 kernel's libata code, but
believe the issues were fixed in the subsequent versions. Atleast one
prominent issue was with a Western Digital HDD of 40 GB size. The
manufacturer specific LBA was 78125000 and was reported as correctly
in Win32 and DOS applications. But the 2.6.27 kernel was reporting
~40000 sectors more. But the problem dissappeared with the 2.6.3x
kernel and I did not bother to check the patches due to lack of time.
But still, the write's failure is not being seen by the application. I
can understand the fact of not checking the media errors during the
write operation, and had posted a request for a quick suggestions of
the locations which needs to be changed / checked for the return
value. ( Should it be handled at the vfs or at the libata code?). Will
surely update the testing results with the new kernel (Well, not
exactly as I am not using the latest version though! Currently trying
with 2.6.31). Thank you all for suggestions.
-
SP

On Thu, Mar 11, 2010 at 1:29 PM, Greg Freemyer <greg.freemyer@gmail.com=
> wrote:
>>
>> But really.. isn't "hdparm --security-erase NULL /dev/sdX" good enou=
gh ???
>>
>
> This thread seems to have died off. =A0If there is a real problem, I
> hope it picks back up.
>
> Mark, as to your question the few times I've tried that the bios on
> the test machine blocked the command. =A0So it may have some specific
> utility, but it's a not a generic solution in my mind.
>
> Greg
>
