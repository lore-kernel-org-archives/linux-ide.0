From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: WDC WD20EARS and 4k sector size
Date: Mon, 24 Jan 2011 22:40:39 -0500
Message-ID: <AANLkTinr1OdvDOS-nbKT0OO9T+_=rVOQYz4TZHQC1Ww6@mail.gmail.com>
References: <20110125030410.GA24024@MAIL.13thfloor.at> <yq14o8x3c8t.fsf@sermon.lab.mkp.net>
 <20110125033259.GC24024@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63268 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab1AYDlA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 22:41:00 -0500
Received: by iyj18 with SMTP id 18so4667962iyj.19
        for <linux-ide@vger.kernel.org>; Mon, 24 Jan 2011 19:40:59 -0800 (PST)
In-Reply-To: <20110125033259.GC24024@MAIL.13thfloor.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

On Mon, Jan 24, 2011 at 10:32 PM, Herbert Poetzl <herbert@13thfloor.at>=
 wrote:
> On Mon, Jan 24, 2011 at 10:15:14PM -0500, Martin K. Petersen wrote:
>> >>>>> "Herbert" =3D=3D Herbert Poetzl <herbert@13thfloor.at> writes:
>
>> Herbert> =A0- the drive doesn't report 4k sectors at all, not
>> Herbert> =A0 =A0even as physical sector size.
>
>> There have been numerous threads on this list about EARS not
>> reporting block sizes correctly. Check the archives.
>
> really? well, they probably use strange subjects or the search
> function on the archives is broken ...
>
> I did a search on the archives, and I get a totla of 30 threads
> containing EARS (in linux-ide) and most of them talk about
> something completely different (like rabbit ears :)
>
>> Herbert> My question now is, how can I tell the kernel that this dri=
ve
>> Herbert> actually has 4k physical sectors and that it would be a sma=
rt
>> Herbert> thing to send requests in some kind of 4k I/O chunks?
>
>> Align your partitions on a 4K boundary.
>
> While this will ensure that the drive performance is better
> than without doing so (I'm not using a partition table on that
> drive anyways, but I get what you mean), this doesn't inform
> the kernel about proper I/O sizes and for sure doesn't prevent
> unnecessary read-change-write operations for the disc ...
>
> best,
> Herbert

=46ilesystems in general use a 4K or 8K blocksize.  Those are of course
sent to the drive in logical sector units where they get aggregated by
the drive and written to the physical media.

There is nothing more that can be done.

So if it is aligned, all is good.  If not, performance sucks.  So the
goal of supporting 4K physical sectors is primarily to ensure a
performance degradation is not introduced due to mis-alignment.

Good Luck
Greg
