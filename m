From: "Kalra Ashish-B00888" <B00888@freescale.com>
Subject: RE: Linux kernel - Libata bad block error handling to user mode  program
Date: Fri, 5 Mar 2010 00:11:01 +0530
Message-ID: <292801cabbca$829e365e$2303d30a@fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Content-class: 
Sender: owner-linux-mm@kvack.org
To: Mark Lord <kernel@teksavvy.com>, foo saa <foosaa@gmail.com>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-mm@kvack.org
List-Id: linux-ide@vger.kernel.org



Sent from my HTC

-----Original Message-----
From: Mark Lord <kernel@teksavvy.com>
Sent: 04 March 2010 11:20 PM
To: foo saa <foosaa@gmail.com>
Cc: Greg Freemyer <greg.freemyer@gmail.com>; Andrew Morton <akpm@linux-foun=
dation.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; l=
inux-ide@vger.kernel.org <linux-ide@vger.kernel.org>; Jens Axboe <jens.axbo=
e@oracle.com>; linux-mm@kvack.org <linux-mm@kvack.org>
Subject: Re: Linux kernel - Libata bad block error handling to user mode  p=
rogram

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
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
