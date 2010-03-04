From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Linux kernel - Libata bad block error handling to user mode
 program
Date: Thu, 04 Mar 2010 12:49:55 -0500
Message-ID: <4B8FF2C3.1060808@teksavvy.com>
References: <f875e2fe1003032052p944f32ayfe9fe8cfbed056d4@mail.gmail.com>	 <20100303224245.ae8d1f7a.akpm@linux-foundation.org>	 <87f94c371003040617t4a4fcd0dt1c9fc0f50e6002c4@mail.gmail.com>	 <4B8FC6AC.4060801@teksavvy.com> <f875e2fe1003040733h20d5523ex5d18b84f47fee8c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <f875e2fe1003040733h20d5523ex5d18b84f47fee8c7@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: foo saa <foosaa@gmail.com>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-mm@kvack.org
List-Id: linux-ide@vger.kernel.org

On 03/04/10 10:33, foo saa wrote:
..
> hdparm is good, but I don't want to use the internal ATA SECURE ERASE
> because I can never get the amount of bad sectors the drive had.
..

Oh.. but isn't that information in the S.M.A.R.T. data ??

You'll not find the bad sectors by writing -- a true WRITE nearly never
reports a media error.  Instead, the drive simply remaps to a good sector
on the fly and returns success.

Generally, only READs report media errors.

Cheers

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
